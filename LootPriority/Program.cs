using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;

namespace LootPriority
{
    public class Program
    {
        public const string ServerName = "Grobbulus";
        public const double PerformancePower = 0.25;
        public static string DataFolder = $"{Path.GetDirectoryName(Path.GetDirectoryName(Path.GetDirectoryName(Path.GetDirectoryName(Directory.GetCurrentDirectory()))))}\\Data";
        public static Dictionary<RaidTier, DateTime> RaidTierDates = new Dictionary<RaidTier, DateTime>
        {
            { RaidTier.MoltenCore, new DateTime(2019, 8, 26) },
            { RaidTier.BlackwingLair, new DateTime(2020, 2, 12) },
            // ZG 2020-04-15
            { RaidTier.AhnQiraj, new DateTime(2020, 8, 20) },
            { RaidTier.Naxxramas, new DateTime(2021, 1, 19) }, // projected
            { RaidTier.TBC, new DateTime(2022, 1, 1) }, // ???
        };

        public static void Main()
        {
            var items = ItemDb.LoadItems();
            var warlockMax = items.Max(i => i.WarlockLootValue);
            var mageMax = items.Max(i => i.MageLootValue);

            PrintItems(items, warlockMax, mageMax);

            var nDaysAgo = DateTime.Today - TimeSpan.FromDays(90);
            IEnumerable<Player> players = PlayerDb.LoadPlayers(nDaysAgo, RaidTierDates[RaidTier.BlackwingLair], RaidTierDates[RaidTier.AhnQiraj])
                .Where(p => p.Characters.Any(c => c.IsMain && (c.Class == CharacterClass.Warlock || c.Class == CharacterClass.Mage)))
                .OrderByDescending(p => p.LootPriority);

            PrintPlayersLoot(players, mageMax, warlockMax);
            PrintPlayers(players);

            Console.ReadKey();
        }

        private static void PrintPlayers(IEnumerable<Player> players)
        {
            var maxPerformance = players.Max(p => p.Performance);
            var maxReceivedLoot = players.Max(p => p.LootScore);
            var maxLootPriority = players.Max(p => p.LootPriority);
            Console.WriteLine("Name\t\tClass\t\tAttendance\tPerformance\tLootScore\tLootPriority");
            foreach (Player player in players)
            {
                player.PrintMain(maxPerformance, maxReceivedLoot, maxLootPriority);
            }
            Console.WriteLine();
        }

        private static void PrintPlayersLoot(IEnumerable<Player> players, double mageMax, double warlockMax)
        {
            Console.WriteLine("Name\t\tClass\tLoot");
            foreach (Player player in players)
            {
                player.PrintMainLoot(mageMax, warlockMax);
                Console.WriteLine();
            }
            Console.WriteLine();
        }

        private static void PrintItems(List<Item> items, double warlockMax, double mageMax)
        {
            Console.WriteLine("ID\tWarlock\tName");
            foreach (Item item in items.Where(i => i.WarlockLootValue > 0).OrderBy(i => i.WarlockLootValue))
            {
                Console.WriteLine($"{item.Id}\t{Normalize(item.WarlockLootValue, 0, warlockMax):F}\t{item.Name}");
            }
            Console.WriteLine($"Total\t{items.Select(i => Normalize(i.WarlockLootValue, 0, warlockMax)).Sum():F}");
            Console.WriteLine();
            Console.WriteLine("ID\tMage\tName");
            foreach (Item item in items.Where(i => i.MageLootValue > 0).OrderBy(i => i.MageLootValue))
            {
                Console.WriteLine($"{item.Id}\t{Normalize(item.MageLootValue, 0, mageMax):F}\t{item.Name}");
            }
            Console.WriteLine($"Total\t{items.Select(i => Normalize(i.MageLootValue, 0, mageMax)).Sum():F}");
            Console.WriteLine();
        }

        public static double Normalize(double value, double min, double max)
        {
            return (value - min) / (max - min);
        }
    }

    public enum RaidTier
    {
        MoltenCore = 1,
        BlackwingLair = 2,
        AhnQiraj = 3,
        Naxxramas = 4,
        TBC = 5,
    }
}
