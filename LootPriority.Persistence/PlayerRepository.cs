using LootPriority.Core.Interface;
using LootPriority.Core.Model;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace LootPriority.Persistence
{
    public class PlayerRepository : IPlayerRepository
    {
        public List<Player> GetPlayers()
        {
            var players = new List<Player>();
            using (SqlConnection connection = new SqlConnection("Server=.\\SQLEXPRESS;Initial Catalog=LootPriority;Integrated Security=true;"))
            {
                SqlCommand command = new SqlCommand("SELECT * FROM Player", connection);
                connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        players.Add(new Player {
                            Id = (int)reader[0],
                            Nickname = (string)reader[1],
                            Characters = new List<Character>(),
                        });
                    }
                }
            }
            return players;
        }
    }
}
