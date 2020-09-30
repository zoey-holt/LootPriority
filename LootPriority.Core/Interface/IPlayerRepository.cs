using LootPriority.Core.Model;
using System.Collections.Generic;

namespace LootPriority.Core.Interface
{
    public interface IPlayerRepository
    {
        List<Player> GetPlayers();
        void AddPlayers(List<Player> players);
    }
}
