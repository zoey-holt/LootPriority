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
            using (SqlConnection connection = new SqlConnection(SqlHelper.connectionString))
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

        public void AddPlayers(List<Player> players)
        {
            using (SqlConnection connection = new SqlConnection(SqlHelper.connectionString))
            {
                connection.Open();
                foreach (var player in players)
                {
                    string playerQuery = $"INSERT INTO Player (Nickname) VALUES (@nickname); SELECT SCOPE_IDENTITY()";
                    SqlCommand playerCommand = new SqlCommand(playerQuery, connection);
                    playerCommand.Parameters.AddWithValue("@nickname", (object)player.Nickname ?? DBNull.Value);
                    player.Id = decimal.ToInt32((decimal)playerCommand.ExecuteScalar());
                    foreach (var character in player.Characters)
                    {
                        string characterQuery = 
                            $"INSERT INTO Character (Name, PlayerID, ClassID, TeamID, RealmID) " +
                            $"VALUES (@name, @playerID, " +
                            $"(SELECT ID FROM Class WHERE Name = @class), " +
                            $"(SELECT ID FROM Team WHERE Name = @team), " +
                            $"(SELECT ID FROM Realm WHERE Name = @realm)); " +
                            $"SELECT SCOPE_IDENTITY()";
                        SqlCommand characterCommand = new SqlCommand(characterQuery, connection);
                        characterCommand.Parameters.AddWithValue("@name", character.Name);
                        characterCommand.Parameters.AddWithValue("@playerID", player.Id);
                        characterCommand.Parameters.AddWithValue("@class", character.Class.ToString());
                        characterCommand.Parameters.AddWithValue("@team", (object)character.Team ?? DBNull.Value);
                        characterCommand.Parameters.AddWithValue("@realm", character.Realm);
                        character.Id = decimal.ToInt32((decimal)characterCommand.ExecuteScalar());
                    }
                }
            }
        }
    }
}
