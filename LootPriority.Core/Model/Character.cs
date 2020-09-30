using LootPriority.Core.Enum;

namespace LootPriority.Core.Model
{
    public class Character
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public CharacterClass Class { get; set; }
        public string Realm { get; set; }
        public string Team { get; set; }
    }
}
