using LootPriority.Persistence;
using System;
using LootPriority.Core.Model;
using LootPriority.Core.Enum;
using System.Linq;
using System.Collections.Generic;
using Flurl.Http;

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

            var bossIds = new Dictionary<string, string>
            {
                { "Lucifron", "12118" },
                { "Magmadar", "11982" },
                { "Gehennas", "12259" },
                { "Garr", "12057" },
                { "Baron Geddon", "12056" },
                { "Shazzrah", "12264" },
                { "Sulfuron Harbinger", "12098" },
                { "Golemagg the Incinerator", "11988" },
                { "Majordomo Executus", "12018" },
                { "Ragnaros", "11502" },
                { "Razorgore the Untamed", "12435" },
                { "Vaelastrasz the Corrupt", "13020" },
                { "Broodlord Lashlayer", "12017" },
                { "Firemaw", "11983" },
                { "Ebonroc", "14601" },
                { "Flamegor", "11981" },
                { "Chromaggus", "14020" },
                { "Nefarian", "11583" },
                //{ "AQ40", "000" },
                //{ "AQ40", "000" },
                //{ "AQ40", "000" },
                //{ "AQ40", "000" },
                //{ "AQ40", "000" },
                //{ "AQ40", "000" },
                //{ "AQ40", "000" },
                //{ "AQ40", "000" },
                //{ "AQ40", "000" },
                //{ "NAXX", "000" },
                //{ "NAXX", "000" },
                //{ "NAXX", "000" },
                //{ "NAXX", "000" },
                //{ "NAXX", "000" },
                //{ "NAXX", "000" },
                //{ "NAXX", "000" },
                //{ "NAXX", "000" },
                //{ "NAXX", "000" },
                //{ "NAXX", "000" },
                //{ "NAXX", "000" },
                //{ "NAXX", "000" },
                //{ "NAXX", "000" },
                //{ "NAXX", "000" },
                //{ "NAXX", "000" },
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
                { 14, Slot.OffHand }, // shield
                { 15, Slot.Ranged },
                { 16, Slot.Back },
                { 17, Slot.TwoHand },
                { 21, Slot.MainHand },
                { 23, Slot.OffHand },
            };
            var bossDrops = new Dictionary<string, List<Item>>();

            foreach (var bossId in bossIds)
            {
                Console.WriteLine(bossId.Key);

                var bossPage = $"https://classic.wowhead.com/npc={bossId.Value}".GetAsync().GetAwaiter().GetResult().Content.ReadAsStringAsync().GetAwaiter().GetResult();
                foreach (var line in bossPage.Split('\n'))
                {
                    if (line.StartsWith("new Listview({template: 'item', id: 'drops'"))
                    {
                        var dataString = "data:";
                        var start = line.IndexOf(dataString) + dataString.Length;
                        var dropsString = line.Substring(start, line.Length - ");".Length - start - 1);
                        var drops = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, object>[]>(dropsString);
                        foreach (var drop in drops.Where(d => Convert.ToInt32(d["quality"]) == 4 && slotConverter.ContainsKey(Convert.ToInt32(d["slot"]))))
                        {
                            var item = new Item
                            {
                                Id = Convert.ToInt32(drop["id"]),
                                Name = (string)drop["name"],
                                Level = Convert.ToInt32(drop["level"]),
                                Slot = slotConverter.ContainsKey(Convert.ToInt32(drop["slot"])) ? (Slot?)slotConverter[Convert.ToInt32(drop["slot"])] : null,
                            };
                            if (bossDrops.ContainsKey(bossId.Key)) bossDrops[bossId.Key].Add(item);
                            else bossDrops.Add(bossId.Key, new List<Item> { item });
                        }
                    }
                }
                PrintItems(bossDrops[bossId.Key]);
            }


            Console.ReadKey();
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
    }
}
