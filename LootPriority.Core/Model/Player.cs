using System.Collections.Generic;

namespace LootPriority.Core.Model
{
    public class Player
    {
        public int Id { get; set; }
        public int Nickname { get; set; }
        public List<Character> Characters { get; set; }
    }
}
