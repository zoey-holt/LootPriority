using System;
using System.Collections.Generic;

namespace LootPriority.Core.Model
{
    public class RaidLog
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public Raid Raid { get; set; }
        public Team Team { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public List<Character> Characters { get; set; }
        public List<Loot> Loot { get; set; }
    }
}
