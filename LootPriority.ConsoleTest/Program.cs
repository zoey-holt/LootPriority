using LootPriority.Persistence;
using System;
using LootPriority.Core.Model;
using LootPriority.Core.Enum;
using System.Linq;
using System.Collections.Generic;
using Flurl.Http;
using Newtonsoft.Json.Linq;

namespace LootPriority.ConsoleTest
{
    public class Program
    {
        public static void Main(string[] args)
        {
            //var playerRepo = new PlayerRepository();
            //AddPlayersFromFile(playerRepo);
            //PrintPlayers(playerRepo.GetPlayers());

            //var itemRepo = new ItemRepository();
            //PrintItems(itemRepo.GetItems());

            Dictionary<string, List<BossLoot>> bossDrops = GetBossDropsFromWowhead();

            Console.ReadKey();
        }

        private static Dictionary<string, List<BossLoot>> GetBossDropsFromWowhead()
        {
            var bossIds = new Dictionary<string, string[]>
            {
                { "Lucifron", new string[] { "12118" } },
                { "Magmadar", new string[] { "11982" } },
                { "Gehennas", new string[] { "12259" } },
                { "Garr", new string[] { "12057" } },
                { "Baron Geddon", new string[] { "12056" } },
                { "Shazzrah", new string[] { "12264" } },
                { "Sulfuron Harbinger", new string[] { "12098" } },
                { "Golemagg the Incinerator", new string[] { "11988" } },
                { "Majordomo Executus", new string[] { "12018" } },
                { "Ragnaros", new string[] { "11502" } },
                { "Razorgore the Untamed", new string[] { "12435" } }, // wowhead shows no loot
                { "Vaelastrasz the Corrupt", new string[] { "13020" } },
                { "Broodlord Lashlayer", new string[] { "12017" } },
                { "Firemaw", new string[] { "11983" } },
                { "Ebonroc", new string[] { "14601" } },
                { "Flamegor", new string[] { "11981" } },
                { "Chromaggus", new string[] { "14020" } },
                { "Nefarian", new string[] { "11583" } },
                { "The Prophet Skeram", new string[] { "15263" } },
                { "Bug Trio", new string[] { "15543", "15544", "15511" } },
                { "Battleguard Sartura", new string[] { "15516" } },
                { "Fankriss the Unyielding", new string[] { "15510" } },
                { "Viscidus", new string[] { "15299" } },
                { "Princess Huhuran", new string[] { "15509" } },
                { "Twin Emperors", new string[] { "15275", "15276" } },
                { "Ouro", new string[] { "15517" } },
                { "C'Thun", new string[] { "15727" } },
                { "Anub'Rekhan", new string[] { "15956" } },
                { "Grand Widow Faerlina", new string[] { "15953" } },
                { "Maexxna", new string[] { "15952" } },
                { "Noth the Plaguebringer", new string[] { "15954" } },
                { "Heigan the Unclean", new string[] { "15936" } },
                { "Loatheb", new string[] { "16011" } },
                { "Instructor Razuvious", new string[] { "16061" } },
                { "Gothik the Harvester", new string[] { "16060" } },
                { "Four Horsemen", new string[] { "181366" } }, //loot code not working for this loot chest object
                { "Patchwerk", new string[] { "16028" } },
                { "Grobbulus", new string[] { "15931" } },
                { "Gluth", new string[] { "15932" } },
                { "Thaddius", new string[] { "15928" } },
                { "Sapphiron", new string[] { "15989" } },
                { "Kel'Thuzad", new string[] { "15990" } },
            };
            var slotConverter = new Dictionary<int, Slot>
            {
                { 1, Slot.Head },
                { 2, Slot.Neck },
                { 3, Slot.Shoulder },
                { 5, Slot.Chest },
                { 6, Slot.Waist },
                { 7, Slot.Legs },
                { 8, Slot.Feet },
                { 9, Slot.Wrist },
                { 10, Slot.Hands },
                { 11, Slot.Finger },
                { 12, Slot.Trinket },
                { 13, Slot.OneHand },
                { 14, Slot.Shield },
                { 15, Slot.Ranged },
                { 16, Slot.Back },
                { 17, Slot.TwoHand },
                { 21, Slot.MainHand },
                { 23, Slot.OffHand },
                { 28, Slot.Relic },
            };
            var classConverter = new Dictionary<long, CharacterClass>
            {
                { (long)Math.Pow(2, 0), CharacterClass.Warrior },
                { (long)Math.Pow(2, 1), CharacterClass.Paladin },
                { (long)Math.Pow(2, 2), CharacterClass.Hunter },
                { (long)Math.Pow(2, 3), CharacterClass.Rogue },
                { (long)Math.Pow(2, 4), CharacterClass.Priest },
                { (long)Math.Pow(2, 6), CharacterClass.Shaman },
                { (long)Math.Pow(2, 7), CharacterClass.Mage },
                { (long)Math.Pow(2, 8), CharacterClass.Warlock },
                { (long)Math.Pow(2, 10), CharacterClass.Druid },
            };

            var bossDrops = new Dictionary<string, List<BossLoot>>();
            foreach (var bossId in bossIds)
            {
                Console.WriteLine(bossId.Key);
                var key = Console.ReadKey();
                if (key.Key == ConsoleKey.Spacebar)
                {
                    Console.WriteLine("Skipped");
                    continue;
                }
                var wowhead = "https://classic.wowhead.com/";
                foreach (var bossMob in bossId.Value)
                {
                    var bossPage = $"{wowhead}{(bossId.Key == "Four Horsemen" ? "object" : "npc")}={bossMob}".GetAsync().GetAwaiter().GetResult().Content.ReadAsStringAsync().GetAwaiter().GetResult();
                    foreach (var line in bossPage.Split('\n'))
                    {
                        if (line.StartsWith("new Listview({template: 'item', id: 'drops'"))
                        {
                            var dataString = "data:";
                            var start = line.IndexOf(dataString) + dataString.Length;
                            var dropsString = line.Substring(start, line.Length - ");".Length - start - 1);
                            var drops = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, object>[]>(dropsString);
                            foreach (var drop in drops.Where(d => Convert.ToInt32(d["quality"]) == 4))
                            {
                                var dropTotal = (double)((JObject)drop["modes"])["0"]["outof"];
                                var dropChance = dropTotal > 0 ? (double)((JObject)drop["modes"])["0"]["count"] / dropTotal : Convert.ToDouble(drop["percentOverride"]) / 100;
                                var classes = drop.ContainsKey("reqclass") ? (long)drop["reqclass"] : -1;
                                var bossLoot = new BossLoot
                                {
                                    Item = new Item
                                    {
                                        Id = Convert.ToInt32(drop["id"]),
                                        Name = (string)drop["name"],
                                        Level = Convert.ToInt32(drop["level"]),
                                        Slot = slotConverter.ContainsKey(Convert.ToInt32(drop["slot"])) ? (Slot?)slotConverter[Convert.ToInt32(drop["slot"])] : null,
                                        Classes = classes > -1 ? classConverter.Select(c => (classes & c.Key, c.Value)).Where(c => c.Item1 > 0).Select(c => c.Item2).ToList() : new List<CharacterClass>(),
                                    },
                                    DropChance = dropChance,
                                };
                                if (bossDrops.ContainsKey(bossId.Key))
                                {
                                    if (!bossDrops[bossId.Key].Select(d => d.Item.Id).Contains(bossLoot.Item.Id)) bossDrops[bossId.Key].Add(bossLoot);
                                }
                                else bossDrops.Add(bossId.Key, new List<BossLoot> { bossLoot });
                            }
                        }
                    }
                }
                if (bossDrops.ContainsKey(bossId.Key)) PrintBossLoot(bossDrops[bossId.Key].OrderByDescending(bd => bd.DropChance).ToList());
            }

            return bossDrops;
        }

        private static void AddPlayersFromFile(PlayerRepository playerRepo)
        {
            var dbPlayers = playerRepo.GetPlayers();
            var dbPlayerNames = dbPlayers.Select(p => p.Nickname).ToList();
            var dbCharacterNames = dbPlayers.SelectMany(p => p.Characters.Select(c => c.Name)).ToList();
            var filePlayers = ConsoleApp.PlayerDb.LoadPlayers().Select(p =>
                new Player
                {
                    Nickname = p.Main.Name,
                    Characters = p.Characters.Select(c =>
                        new Character
                        {
                            Name = c.Name,
                            Class = (CharacterClass)Enum.Parse(typeof(CharacterClass), c.Class.ToString()),
                            Realm = "Grobbulus",
                            Team = c.IsMain ? "ENCORE Purple" : null,
                        }
                    ).Where(c => !dbCharacterNames.Contains(c.Name)).ToList()
                }
            ).Where(p => !dbPlayerNames.Contains(p.Nickname)).ToList();
            if (filePlayers.Any()) playerRepo.AddPlayers(filePlayers);
        }

        private static void PrintPlayers(List<Player> players)
        {
            foreach (var player in players)
            {
                Console.WriteLine(player.Nickname);
                foreach (var character in player.Characters)
                {
                    Console.WriteLine("\t" + character.Name);
                }
            }
        }

        private static void PrintItems(List<Item> items)
        {
            foreach (var item in items)
            {
                Console.WriteLine(item.Id + "\t" + item.Level + "\t" + item.Slot.ToString() + (item.Slot.ToString().Length > 7 ? "\t" : "\t\t") + item.Name);
                foreach (var qr in item.QuestRewards)
                {
                    Console.WriteLine("\t" + qr.Id + "\t" + qr.Classes.Count.ToString() + "\t" + qr.Name);
                }
            }
        }

        private static void PrintBossLoot(List<BossLoot> bossLoots)
        {
            foreach (var bossLoot in bossLoots)
            {
                var slot = bossLoot.Item.Slot.ToString();
                var classes = string.Join(',', bossLoot.Item.Classes.Select(c => c.ToString()));
                Console.WriteLine(
                    bossLoot.Item.Id + "\t" +
                    bossLoot.Item.Level + "\t" +
                    slot + (slot.Length > 7 ? "\t" : "\t\t") +
                    $"{bossLoot.DropChance:F}\t" +
                    classes + (classes.Length > 7 ? "\t" : "\t\t") +
                    bossLoot.Item.Name);
                foreach (var qr in bossLoot.Item.QuestRewards)
                {
                    Console.WriteLine("\t" + qr.Id + "\t" + qr.Classes.Count.ToString() + "\t" + qr.Name);
                }
            }
        }
    }
}
