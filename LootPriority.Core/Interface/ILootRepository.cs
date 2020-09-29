using LootPriority.Core.Model;
using System;
using System.Collections.Generic;

namespace LootPriority.Core.Interface
{
    public interface ILootRepository
    {
        List<Loot> GetLoot(List<string> characters, DateTime start, DateTime end);
    }
}
