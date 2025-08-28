using System;

namespace GroceryStore.AzureStorage
{
    public class LogEntry
    {
        public DateTime Timestamp { get; set; }
        public string Level { get; set; }
        public string Component { get; set; }
        public string Message { get; set; }
        public string Details { get; set; }

        public LogEntry(string level, string component, string message, string details = null)
        {
            Timestamp = DateTime.UtcNow;
            Level = level;
            Component = component;
            Message = message;
            Details = details;
        }

        public override string ToString()
        {
            return $"{Timestamp:yyyy-MM-dd HH:mm:ss} [{Level}] {Component}: {Message}" +
                   (string.IsNullOrEmpty(Details) ? "" : $"\nDetails: {Details}");
        }
    }
}