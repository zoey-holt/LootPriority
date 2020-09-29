namespace LootPriority.Core.Model
{
    public class BossLoot
    {
        public int Id { get; set; }
        public Item Item { get; set; }
        public double DropChance { get; set; }
    }
}
