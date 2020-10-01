using LootPriority.Core.Enum;
using System.Collections.Generic;

namespace LootPriority.Core.Model
{
    public class Item
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Level { get; set; }
        public Slot? Slot { get; set; }
        public bool IsQuestItem { get; set; }
        public List<Item> QuestRewards { get; set; } = new List<Item>();
        public List<CharacterClass> Classes { get; set; } = new List<CharacterClass>();
    }
}
