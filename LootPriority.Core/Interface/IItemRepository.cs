using LootPriority.Core.Model;
using System.Collections.Generic;

namespace LootPriority.Core.Interface
{
    public interface IItemRepository
    {
        Item GetItem(int id);
        Item GetItem(string name);
        List<Item> GetItems();
    }
}
