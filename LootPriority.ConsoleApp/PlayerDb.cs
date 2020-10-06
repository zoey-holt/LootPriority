using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using Csv;

namespace LootPriority.ConsoleApp
{
    public static class PlayerDb
    {
        public static string PlayersFile = $"{Program.DataFolder}/Players/players.csv";

        public static List<Player> LoadPlayers(DateTime? attendanceFromDate = null, DateTime? lootFromDate = null, DateTime? performanceFromDate = null)
        {
            var players = new Dictionary<int, Player>();
            var lines = File.ReadAllLines(PlayersFile).Skip(1);
            foreach (string line in lines)
            {
                var l = CsvReader.ReadFromText(line, new CsvOptions() { HeaderMode = HeaderMode.HeaderAbsent }).ToArray()[0];
                int playerId = int.Parse(l.Values[0]);
                var character = new Character
                {
                    Name = l.Values[1],
                    Class = (CharacterClass)Enum.Parse(typeof(CharacterClass), l.Values[2]),
                    IsMain = bool.Parse(l.Values[3]),
                };
                if (players.ContainsKey(playerId))
                {
                    players[playerId].Characters.Add(character);
                }
                else
                {
                    players.Add(playerId, new Player
                    {
                        Id = playerId,
                        Characters = new List<Character> { character },
                        Attitude = l.Values.Length > 4 ? double.Parse(l.Values[4]) : 1,
                    });
                }
            }

            var lootByCharacter = new Dictionary<string, List<Loot>>();
            foreach (var loot in LootDb.LoadLoot().Where(l => l.DateTime >= lootFromDate))
            {
                if (lootByCharacter.ContainsKey(loot.Character))
                    lootByCharacter[loot.Character].Add(loot);
                else
                    lootByCharacter.Add(loot.Character, new List<Loot> { loot });
            }
            var items = ItemDb.LoadItems().ToDictionary(i => i.Id, i => i);
            var mageMax = items.Values.Max(i => i.MageLootValue);
            var warlockMax = items.Values.Max(i => i.WarlockLootValue);

            var logs = WarcraftLogDb.LoadWarcraftLogs();

            foreach (var player in players.Values)
            {
                player.Attendance = logs
                    .Where(l => l.Date >= attendanceFromDate || attendanceFromDate == null)
                    .Select(l => l.Parses.Any(p => player.Characters.Any(c => c.Name == p.Key)) ? 1 : 0)
                    .Average();
                var performances = logs
                    .Where(l => l.Date >= performanceFromDate && (l.Date >= Program.RaidTierDates[l.RaidTier] && l.Date < Program.RaidTierDates[(RaidTier)((int)l.RaidTier + 1)]))
                    .Select(l => l.Parses.Any(p => p.Key == player.Main.Name) ? l.Parses.First(p => p.Key == player.Main.Name).Value : -1)
                    .Where(p => p >= 0)
                    .ToList();
                player.Performance = performances.Any() ? performances.Average() : 0;
                player.Loot = lootByCharacter.ContainsKey(player.Main.Name) ? lootByCharacter[player.Main.Name]
                    .Where(l => items.ContainsKey(l.ItemId))
                    .Select(l => new Tuple<Loot, Item>(l, items[l.ItemId]))
                    .ToList()
                    : new List<Tuple<Loot, Item>>();
            }

            return players.Values.ToList();
        }

        public static void SavePlayers(List<Player> players)
        {
            List<string> lines = new List<string>
            {
                "ID,Name,Class,IsMain,Attitude",
            };
            foreach (Player player in players)
            {
                foreach (Character character in player.Characters)
                {
                    var values = new List<string>
                    {
                        player.Id.ToString(),
                        character.Name,
                        character.Class.ToString(),
                        character.IsMain.ToString(),
                        player.Attitude.ToString(),
                    };
                    lines.Add(string.Join(',', values));
                }
            }
            File.WriteAllText(PlayersFile, string.Join('\n', lines));
        }
    }

    public enum CharacterClass
    {
        Druid,
        Hunter,
        Mage,
        Paladin,
        Priest,
        Rogue,
        Shaman,
        Warlock,
        Warrior
    }

    public class Player
    {
        public int Id { get; set; }
        public List<Character> Characters { get; set; }
        public Character Main { get => Characters.First(c => c.IsMain); }

        public double Attendance { get; set; }
        public double Performance { get; set; }
        public List<Tuple<Loot, Item>> Loot { get; set; }
        public double LootScore { 
            get => Loot?
                .Where(l => l.Item1.Response != LootResponse.PvP && l.Item1.Response != LootResponse.Offspec && l.Item1.Response != LootResponse.Pass)
                .Select(l => Main.Class == CharacterClass.Mage ? l.Item2.MageLootValue : l.Item2.WarlockLootValue)
                .Sum() ?? 0; 
        }
        public double Attitude { get; set; }
        public double LootPriority { get => Attendance * Math.Pow(Performance, Program.PerformancePower) * Attitude / (LootScore > 0 ? LootScore : 0.01); }

        public void PrintCharacters()
        {
            Console.WriteLine($"ID {Id}");
            foreach (Character character in Characters)
            {
                string mainString = character.IsMain ? "Main" : "Alt";
                Console.WriteLine($"\t{character.Name} {character.Class} {mainString}");
            }
        }

        public void PrintMain(double maxPerformance, double maxLootScore, double maxLootPriority)
        {
            var nameTabs = Main.Name.Length < 7 ? "\t\t" : "\t";
            Console.WriteLine($"{Main.Name}{nameTabs}" +
                $"{Main.Class}\t\t" +
                $"{Attendance:F}\t\t" +
                $"{Program.Normalize(Performance, 0, maxPerformance):F}\t\t" +
                $"{Program.Normalize(LootScore, 0, maxLootScore):F}\t\t" +
                $"{Program.Normalize(LootPriority, 0, maxLootPriority):F}");
        }

        public void PrintMainLoot(double mageMax, double warlockMax)
        {
            var nameTabs = Main.Name.Length < 7 ? "\t\t" : "\t";
            Console.WriteLine($"{Main.Name}{nameTabs}{Main.Class}");
            var i = 0;
            foreach (var loot in Loot.OrderBy(l => l.Item1.DateTime))
            {
                i++;
                Console.WriteLine($"\t\t\t" +
                    $"{i}\t" +
                    $"{loot.Item1.DateTime:yyyy-MM-dd}\t" +
                    $"{(Main.Class == CharacterClass.Mage ? loot.Item2.MageLootValue : loot.Item2.WarlockLootValue):F}\t" +
                    $"{loot.Item1.Response}\t\t" +
                    $"{loot.Item2.Name}");
            }
            Console.WriteLine($"\t\t\tTotal\t\t\t\t\t{Loot?.Select(l => Main.Class == CharacterClass.Mage ? l.Item2.MageLootValue : l.Item2.WarlockLootValue).Sum() ?? 0:F}");
            Console.WriteLine($"\t\t\tLoot Score\t\t\t\t{LootScore:F}");
        }
    }

    public class Character
    {
        public string Name { get; set; }
        public CharacterClass Class { get; set; }
        public bool IsMain { get; set; }
    }
}
