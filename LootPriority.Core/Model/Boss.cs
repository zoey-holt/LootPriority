using System.Collections.Generic;

namespace LootPriority.Core.Model
{
    public class Boss
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public List<BossLoot> Loot { get; set; }
    }
}
