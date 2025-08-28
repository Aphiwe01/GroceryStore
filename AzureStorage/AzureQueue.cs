using System;

namespace GroceryStore.AzureStorage
{
    public class QueueMessage
    {
        public string MessageType { get; set; } // "OrderProcessing", "InventoryUpdate", "ImageUpload"
        public string Content { get; set; }
        public DateTime Timestamp { get; set; }
        public string EntityId { get; set; }

        public QueueMessage(string messageType, string content, string entityId = null)
        {
            MessageType = messageType;
            Content = content;
            Timestamp = DateTime.UtcNow;
            EntityId = entityId;
        }

        public override string ToString()
        {
            return $"{Timestamp:yyyy-MM-dd HH:mm:ss} [{MessageType}] {Content}";
        }
    }
}