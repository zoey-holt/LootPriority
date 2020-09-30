using System.Collections.Generic;

namespace LootPriority.Core.Model
{
    public class Player
    {
        public int Id { get; set; }
        public string Nickname { get; set; }
        public List<Character> Characters { get; set; }
    }
}
