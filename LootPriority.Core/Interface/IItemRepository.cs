using LootPriority.Core.Model;
using System.Collections.Generic;

namespace LootPriority.Core.Interface
{
    public interface IItemRepository
    {
        Item GetItem(int id);
        List<Item> GetItems();
    }
}
