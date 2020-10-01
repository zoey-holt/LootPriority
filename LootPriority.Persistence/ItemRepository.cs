using LootPriority.Core.Interface;
using LootPriority.Core.Model;
using System;
using System.Collections.Generic;
using LootPriority.Core.Enum;
using System.Data.SqlClient;
using System.Linq;

namespace LootPriority.Persistence
{
    public class ItemRepository : IItemRepository
    {
        public Item GetItem(int id)
        {
            throw new NotImplementedException();
        }

        public Item GetItem(string name)
        {
            throw new NotImplementedException();
        }

        public List<Item> GetItems()
        {
            var items = new Dictionary<int, Item>();
            using (SqlConnection connection = new SqlConnection(SqlHelper.connectionString))
            {
                string query =
                    "SELECT " +
                    "i.ID, " +
                    "i.Name, " +
                    "i.Level, " +
                    "s.Name Slot, " +
                    "i.IsQuestItem, " +
                    "c.Name Class, " +
                    "i2.ID QuestRewardID " +
                    "FROM Item i " +
                    "LEFT JOIN Slot s " +
                    "ON i.SlotID = s.ID " +
                    "LEFT JOIN ItemClass ic " +
                    "ON ic.ItemID = i.ID " +
                    "LEFT JOIN Class c " +
                    "ON c.ID = ic.ClassID " +
                    "LEFT JOIN Item i2 " +
                    "ON i.ID = i2.RewardFromQuestItem "+
                    "ORDER BY i.IsQuestItem ASC";
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        int itemId = reader.GetInt32(0);
                        int questRewardId = reader.GetInt32Nullable(6);
                        if (items.ContainsKey(itemId))
                        {
                            items[itemId].QuestRewards.Add(items[questRewardId]);
                        }
                        else
                        {
                            items.Add(itemId, new Item
                            {
                                Id = itemId,
                                Name = reader.GetString(1),
                                Level = reader.GetInt32Nullable(2),
                                Slot = reader.IsDBNull(3) ? null : (Slot?)reader.GetEnum<Slot>(3),
                                IsQuestItem = reader.GetBoolean(4),
                                Classes = reader.IsDBNull(5) ? new List<CharacterClass>() : new List<CharacterClass> { reader.GetEnum<CharacterClass>(5) },
                                QuestRewards = questRewardId > 0 ? new List<Item> { items[questRewardId] } : new List<Item>(),
                            });
                        }
                    }
                }
            }
            return items.Values.ToList();
        }
    }
}
