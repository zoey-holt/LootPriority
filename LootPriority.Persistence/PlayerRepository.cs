using LootPriority.Core.Interface;
using LootPriority.Core.Enum;
using LootPriority.Core.Model;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System;

namespace LootPriority.Persistence
{
    public class PlayerRepository : IPlayerRepository
    {
        public List<Player> GetPlayers()
        {
            var players = new Dictionary<int, Player>();
            using (SqlConnection connection = new SqlConnection("Server=.\\SQLEXPRESS;Initial Catalog=LootPriority;Integrated Security=true;"))
            {
                string query =
                    "SELECT p.ID, p.Nickname, c.ID, c.Name, cl.Name, t.Name, r.Name " +
                    "FROM Player p " +
                    "LEFT JOIN Character c ON c.PlayerID = p.ID " +
                    "LEFT JOIN Class cl ON cl.ID = c.ClassID " +
                    "LEFT JOIN Team t ON t.ID = c.TeamID " +
                    "LEFT JOIN Realm r ON r.ID = c.RealmID";
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        int playerId = reader.GetInt32(0);
                        if (players.ContainsKey(playerId))
                        {
                            players[playerId].Characters.Add(new Character
                            {
                                Id = reader.GetInt32(2),
                                Name = reader.GetStringNullable(3),
                                Class = reader.GetEnum<CharacterClass>(4),
                                Team = reader.GetStringNullable(5),
                                Realm = reader.GetStringNullable(6),
                            });
                        }
                        else
                        {
                            players.Add(playerId, new Player
                            {
                                Id = playerId,
                                Nickname = reader.GetStringNullable(1),
                                Characters = new List<Character>
                                {
                                    new Character
                                    {
                                        Id = reader.GetInt32(2),
                                        Name = reader.GetStringNullable(3),
                                        Class = reader.GetEnum<CharacterClass>(4),
                                        Team = reader.GetStringNullable(5),
                                        Realm = reader.GetStringNullable(6),
                                    }
                                },
                            });
                        }
                    }
                }
            }
            return players.Values.ToList();
        }
    }
}
