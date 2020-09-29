using LootPriority.Core.Interface;
using LootPriority.Core.Model;
using System;
using System.Collections.Generic;

namespace LootPriority.Persistence
{
    public class RaidLogRepository : IRaidLogRepository
    {
        public List<RaidLog> GetRaidLogs(string raid, string team, DateTime start, DateTime end)
        {
            throw new NotImplementedException();
        }
    }
}
