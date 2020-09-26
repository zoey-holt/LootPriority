using System.Collections.Generic;
using System.IO;
using System.Linq;
using System;
using Csv;


namespace LootPriority
{
    public static class ItemDb
    {
        public static string ItemsFile = $"{Program.DataFolder}/Items/items.csv";

        public static List<Item> LoadItems()
        {
            var items = new List<Item>();
            var lines = File.ReadAllLines(ItemsFile).Skip(1);
            foreach (string line in lines)
            {
                var l = CsvReader.ReadFromText(line, new CsvOptions() { HeaderMode = HeaderMode.HeaderAbsent }).ToArray()[0];
                {
                    items.Add(new Item
                    {
                        Id = l.Values[0],
                        Name = l.Values[1],
                        Slot = (Slot)Enum.Parse(typeof(Slot), l.Values[2]),
                        DropChance = double.Parse(l.Values[3]),
                        RaidTier = (RaidTier)Enum.Parse(typeof(RaidTier), l.Values[4]),
                        MageStatWeight = double.Parse(l.Values[5]),
                        MageBestInSlot = bool.Parse(l.Values[6]),
                        WarlockStatWeight = double.Parse(l.Values[7]),
                        WarlockBestInSlot = bool.Parse(l.Values[8]),
                    });
                }
            }
            return items;
        }

        public static void SaveItems(List<Item> items)
        {
            List<string> lines = new List<string>
            {
                "ID,Name,Slot,DropChance,RaidTier,MageStatWeight,MageBestInSlot,WarlockStatWeight,WarlockBestInSlot",
            };
            foreach (Item item in items)
            {
                IEnumerable<string> values = new List<string>
                {
                    item.Id,
                    item.Name,
                    item.Slot.ToString(),
                    item.DropChance.ToString(),
                    item.RaidTier.ToString(),
                    item.MageStatWeight.ToString(),
                    item.MageBestInSlot.ToString(),
                    item.WarlockStatWeight.ToString(),
                    item.WarlockBestInSlot.ToString(),
                };
                values = values.Select(v => "\"" + v.Replace("\"", "\"\"") + "\"");
                lines.Add(string.Join(',', values));
            }
            File.WriteAllText(ItemsFile, string.Join('\n', lines));
        }
    }

    public enum Slot
    {
        Head,
        Neck,
        Shoulder,
        Back,
        Chest,
        Wrist,
        Hands,
        Waist,
        Legs,
        Feet,
        Finger,
        Trinket,
        OneHand,
        OffHand,
        Staff,
        Wand
    }

    public class Item
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public Slot Slot { get; set; }

        public double DropChance { get; set; }
        public RaidTier RaidTier { get; set; }
        public double RaidTierModifier { get => 1 - (0.25 * ((int)(Program.RaidTierDates.First(r => DateTime.Now >= r.Value).Key) - (int)RaidTier)); }

        public double MageStatWeight { get; set; }
        public bool MageBestInSlot { get; set; }
        public double MageLootValue { get => RaidTierModifier * SlotWeights[Slot] * MageStatWeight * (MageBestInSlot ? 1.25 : 1) / Math.Sqrt(DropChance); }

        public double WarlockStatWeight { get; set; }
        public bool WarlockBestInSlot { get; set; }
        public double WarlockLootValue { get => RaidTierModifier * SlotWeights[Slot] * WarlockStatWeight * (WarlockBestInSlot ? 1.25 : 1) / Math.Sqrt(DropChance); }

        public Dictionary<Slot, double> SlotWeights = new Dictionary<Slot, double>
        {
            { Slot.Head, 1.0 },
            { Slot.Neck, 0.75 },
            { Slot.Shoulder, 0.75 },
            { Slot.Back, 0.75 },
            { Slot.Chest, 1.0 },
            { Slot.Wrist, 0.5 },
            { Slot.Hands, 0.75 },
            { Slot.Waist, 0.75 },
            { Slot.Legs, 1.0 },
            { Slot.Feet, 0.75 },
            { Slot.Finger, 0.75 },
            { Slot.Trinket, 1.0 },
            { Slot.OneHand, 1.5 },
            { Slot.OffHand, 0.75 },
            { Slot.Staff, 1.25 },
            { Slot.Wand, 0.25 },
        };
    }
}
