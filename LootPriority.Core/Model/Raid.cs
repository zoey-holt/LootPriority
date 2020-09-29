using System;
using System.Collections.Generic;

namespace LootPriority.Core.Model
{
    public class Raid
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int PlayerLimit { get; set; }        
        public DateTime ReleaseDate { get; set; } // TODO: revisit this with different release dates on different realms
        public List<Boss> Bosses { get; set; }
    }
}
