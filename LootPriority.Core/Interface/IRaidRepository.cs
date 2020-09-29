using LootPriority.Core.Model;
using System.Collections.Generic;

namespace LootPriority.Core.Interface
{
    public interface IRaidRepository
    {
        List<Raid> GetRaids();
        Raid GetRaid(string name);
    }
}
