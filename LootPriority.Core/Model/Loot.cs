using System;

namespace LootPriority.Core.Model
{
    public class Loot
    {
        public int Id { get; set; }
        public Character Character { get; set; }
        public Item Item { get; set; }
        public DateTime Date { get; set; }
    }
}
