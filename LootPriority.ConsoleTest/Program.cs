using LootPriority.Persistence;
using System;
using LootPriority.Core.Model;
using LootPriority.Core.Enum;
using System.Linq;

namespace LootPriority.ConsoleTest
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var playerRepo = new PlayerRepository();
            AddPlayersFromFile(playerRepo);
            PrintPlayers(playerRepo);

            Console.ReadKey();
        }

        private static void AddPlayersFromFile(PlayerRepository playerRepo)
        {
            playerRepo.AddPlayers(ConsoleApp.PlayerDb.LoadPlayers().Select(p =>
                new Player
                {
                    Nickname = p.Main.Name,
                    Characters = p.Characters.Select(c =>
                        new Character
                        {
                            Name = c.Name,
                            Class = (CharacterClass)Enum.Parse(typeof(CharacterClass), c.Class.ToString()),
                            Realm = "Grobbulus",
                            Team = "ENCORE Purple",
                        }
                    ).ToList()
                }
            ).ToList());
        }

        private static void PrintPlayers(PlayerRepository playerRepo)
        {
            var players = playerRepo.GetPlayers();
            foreach (var player in players)
            {
                Console.WriteLine(player.Nickname);
                foreach (var character in player.Characters)
                {
                    Console.WriteLine("\t" + character.Name);
                }
            }
        }
    }
}
