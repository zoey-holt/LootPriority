using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using Csv;

namespace LootPriority.ConsoleApp
{
    public static class LootDb
    {
        public static string LootFolder = $"{Program.DataFolder}/Loot/";

        public static List<Loot> LoadLoot()
        {
            var lootList = new List<Loot>();
            foreach (var file in Directory.GetFiles(LootFolder))
            {
                var lines = File.ReadAllLines(file).Skip(1);
                foreach (var line in lines)
                {
                    var l = CsvReader.ReadFromText(line, new CsvOptions() { HeaderMode = HeaderMode.HeaderAbsent }).ToArray()[0];
                    lootList.Add(new Loot
                    {
                        Id = l.Values[3],
                        DateTime = DateTime.ParseExact($"{l.Values[1]} {l.Values[2]}", "M/dd/yy HH:mm:ss", null, System.Globalization.DateTimeStyles.None),
                        Character = l.Values[0].Replace($"-{Program.ServerName}", ""),
                        ItemName = l.Values[4].Replace("[", "").Replace("]", ""),
                        ItemId = l.Values[5],
                        Response = Enum.TryParse(typeof(LootResponse), l.Values[17], out object response) ? (LootResponse)response : LootResponse.Pass,
                    });
                }
            }
            return lootList.GroupBy(l => l.Id).Select(l => l.First()).ToList();
        }
    }

    public class Loot
    {
        public string Id { get; set; }
        public DateTime DateTime { get; set; }
        public string Character { get; set; }
        public string ItemName { get; set; }
        public string ItemId { get; set; }
        public LootResponse Response { get; set; }
    }

    public enum LootResponse
    {
        Pass = 0,
        BiS = 1,
        Upgrade = 2,
        PvP = 3,
        Offspec = 4
    }
}
