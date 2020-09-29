using System.Collections.Generic;

namespace LootPriority.Core.Model
{
    public class Team
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public List<Character> Characters { get; set; }
    }
}
