using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;

namespace LootPriority.ConsoleApp
{
    public static class WarcraftLogDb
    {
        public static string WarcraftLogsFolder = $"{Program.DataFolder}/Warcraft Logs/";

        public static List<WarcraftLog> LoadWarcraftLogs(DateTime? fromDate = null, DateTime? toDate = null)
        {
            return Directory.GetFiles(WarcraftLogsFolder)
                .Select(f => new WarcraftLog
                {
                    Date = DateTime.Parse(Path.GetFileName(f).Replace(".csv", "").Split(" ")[0]),
                    RaidTier = (RaidTier)Enum.Parse(typeof(RaidTier), Path.GetFileName(f).Replace(".csv", "").Split(" ")[1]),
                    Parses = File.ReadAllLines(f).Skip(1).ToDictionary(l => l.Split("\",\"")[1], l => l.Split("\",\"")[0].Remove(0, 1) == "-" ? 0 : int.Parse(l.Split("\",\"")[0].Remove(0, 1)))
                })
                .Where(l => (fromDate == null || l.Date >= fromDate) && (toDate == null || l.Date < toDate))
                .ToList();
        }
    }

    public class WarcraftLog
    {
        public DateTime Date { get; set; }
        public RaidTier RaidTier { get; set; }
        public Dictionary<string, int> Parses { get; set; }
    }
}
