using System;
using System.Data;

namespace LootPriority.Persistence
{
    internal static class SqlHelper
    {
        public const string connectionString = "Server=.\\SQLEXPRESS;Initial Catalog=LootPriority;Integrated Security=true;";

        public static string GetStringNullable(this IDataRecord record, int i)
        {
            return record.IsDBNull(i) ? null : (string)record[i];
        }

        public static T GetEnum<T>(this IDataRecord record, int i) where T : struct
        {
            return (T)Enum.Parse(typeof(T), (string)record[i]);
        }
    }
}
