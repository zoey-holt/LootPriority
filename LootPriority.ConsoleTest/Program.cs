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

            var itemRepo = new ItemRepository();
            PrintItems(itemRepo);

            Console.ReadKey();
        }

        private static void AddPlayersFromFile(PlayerRepository playerRepo)
        {
            var dbPlayers = playerRepo.GetPlayers();
            var dbPlayerNames = dbPlayers.Select(p => p.Nickname).ToList();
            var dbCharacterNames = dbPlayers.SelectMany(p => p.Characters.Select(c => c.Name)).ToList();
            var filePlayers = ConsoleApp.PlayerDb.LoadPlayers().Select(p =>
                new Player
                {
                    Nickname = p.Main.Name,
                    Characters = p.Characters.Select(c =>
                        new Character
                        {
                            Name = c.Name,
                            Class = (CharacterClass)Enum.Parse(typeof(CharacterClass), c.Class.ToString()),
                            Realm = "Grobbulus",
                            Team = c.IsMain ? "ENCORE Purple" : null,
                        }
                    ).Where(c => !dbCharacterNames.Contains(c.Name)).ToList()
                }
            ).Where(p => !dbPlayerNames.Contains(p.Nickname)).ToList();
            if (filePlayers.Any()) playerRepo.AddPlayers(filePlayers);
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

        private static void PrintItems(ItemRepository itemRepo)
        {
            var items = itemRepo.GetItems();
            foreach (var item in items)
            {
                Console.WriteLine(item.Id + "\t" + item.QuestRewards.Count.ToString() + "\t" + item.Name);
            }
        }
    }
}
