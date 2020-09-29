using LootPriority.Core.Model;
using System;
using System.Collections.Generic;

namespace LootPriority.Core.Interface
{
    public interface IRaidLogRepository
    {
        List<RaidLog> GetRaidLogs(string raid, string team, DateTime start, DateTime end);
    }
}
