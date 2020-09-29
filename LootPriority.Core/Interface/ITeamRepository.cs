using LootPriority.Core.Model;
using System.Collections.Generic;

namespace LootPriority.Core.Interface
{
    public interface ITeamRepository
    {
        List<Team> GetTeams();
    }
}
