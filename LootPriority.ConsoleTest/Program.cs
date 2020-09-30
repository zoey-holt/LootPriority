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
            }

            Console.ReadKey();
        }
    }
}
