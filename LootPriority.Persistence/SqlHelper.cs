using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace LootPriority.Persistence
{
    internal static class SqlHelper
    {
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
