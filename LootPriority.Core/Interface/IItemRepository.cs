using LootPriority.Core.Model;

namespace LootPriority.Core.Interface
{
    public interface IItemRepository
    {
        Item GetItem(int id);
        Item GetItem(string name);
    }
}
