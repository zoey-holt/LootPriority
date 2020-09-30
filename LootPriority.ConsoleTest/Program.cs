using LootPriority.Persistence;
using System;

namespace LootPriority.ConsoleTest
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var playerRepo = new PlayerRepository();
            var players = playerRepo.GetPlayers();

            foreach (var player in players)
            {
                Console.WriteLine(player.Nickname);
                foreach (var character in player.Characters)
                {
                    Console.WriteLine("\t" + character.Name);
                }
            }

            Console.ReadKey();
        }
    }
}
