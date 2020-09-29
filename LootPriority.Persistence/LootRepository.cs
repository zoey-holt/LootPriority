using LootPriority.Core.Interface;
using LootPriority.Core.Model;
using System;
using System.Collections.Generic;

namespace LootPriority.Persistence
{
    public class LootRepository : ILootRepository
    {
        public List<Loot> GetLoot(List<string> characters, DateTime start, DateTime end)
        {
            throw new NotImplementedException();
        }
    }
}
