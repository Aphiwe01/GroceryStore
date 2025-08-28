using Microsoft.Azure.Storage; // For blob, queue operations
using Microsoft.Azure.Storage.Blob;
using Microsoft.Azure.Storage.Queue;
using Azure.Data.Tables; // For table operations (newer SDK)
using Azure;
using Newtonsoft.Json;
using System;
using System.Threading.Tasks;
using System.Configuration;


namespace GroceryStore
{
    public class AzureServicesHelper
    {
        private static string storageConnectionString = ConfigurationManager.ConnectionStrings["AzureStorageConnection"].ConnectionString;

        // Blob Storage
        public static async Task<string> UploadOrderToBlob(Order order)
        {
            try
            {
                Microsoft.Azure.Storage.CloudStorageAccount storageAccount = Microsoft.Azure.Storage.CloudStorageAccount.Parse(storageConnectionString);
                Microsoft.Azure.Storage.Blob.CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
                Microsoft.Azure.Storage.Blob.CloudBlobContainer container = blobClient.GetContainerReference("orders");

                await container.CreateIfNotExistsAsync();

                string blobName = $"order-{order.Reference}-{DateTime.UtcNow:yyyyMMddHHmmss}.json";
                Microsoft.Azure.Storage.Blob.CloudBlockBlob blockBlob = container.GetBlockBlobReference(blobName);

                string orderJson = JsonConvert.SerializeObject(order);
                await blockBlob.UploadTextAsync(orderJson);

                return blockBlob.Uri.ToString();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Blob storage error: {ex.Message}");
                return null;
            }
        }

        // File Share - REMOVED due to namespace conflicts
        // Consider using Blob Storage instead of File Share
        public static async Task<string> SaveOrderToFileShare(Order order)
        {
            // File Share has too many namespace conflicts
            // Consider using blob storage instead or implement this separately
            return null;
        }

        // Queue Message
        public static async Task<string> AddOrderToQueue(Order order)
        {
            try
            {
                Microsoft.Azure.Storage.CloudStorageAccount storageAccount = Microsoft.Azure.Storage.CloudStorageAccount.Parse(storageConnectionString);
                Microsoft.Azure.Storage.Queue.CloudQueueClient queueClient = storageAccount.CreateCloudQueueClient();
                Microsoft.Azure.Storage.Queue.CloudQueue queue = queueClient.GetQueueReference("ordersqueue");

                await queue.CreateIfNotExistsAsync();

                string orderJson = JsonConvert.SerializeObject(order);
                Microsoft.Azure.Storage.Queue.CloudQueueMessage message = new Microsoft.Azure.Storage.Queue.CloudQueueMessage(orderJson);
                await queue.AddMessageAsync(message);

                return message.Id;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Queue error: {ex.Message}");
                return null;
            }
        }

        // Azure Table Storage (using newer Azure.Data.Tables SDK)
        public static async Task<bool> InsertOrderToTable(Order order)
        {
            try
            {
                // Use the newer Azure.Data.Tables SDK for table operations
                TableServiceClient tableServiceClient = new TableServiceClient(storageConnectionString);
                TableClient tableClient = tableServiceClient.GetTableClient("Orders");

                await tableClient.CreateIfNotExistsAsync();

                // Create a table entity
                var orderEntity = new TableEntity("Orders", order.Reference)
                {
                    ["CustomerID"] = order.CustomerID,
                    ["ProductID"] = order.ProductID,
                    ["FullName"] = order.FullName,
                    ["EmailAddress"] = order.EmailAddress,
                    ["PhoneNumber"] = order.PhoneNumber,
                    ["DeliveryAddress"] = order.DeliveryAddress,
                    ["PaymentMethod"] = order.PaymentMethod,
                    ["Reference"] = order.Reference
                };

                await tableClient.AddEntityAsync(orderEntity);
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Table storage error: {ex.Message}");
                return false;
            }
        }

        // Alternative: Save order as JSON to blob storage (replacement for file share)
        public static async Task<string> SaveOrderAsJsonToBlob(Order order)
        {
            try
            {
                Microsoft.Azure.Storage.CloudStorageAccount storageAccount = Microsoft.Azure.Storage.CloudStorageAccount.Parse(storageConnectionString);
                Microsoft.Azure.Storage.Blob.CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
                Microsoft.Azure.Storage.Blob.CloudBlobContainer container = blobClient.GetContainerReference("order-jsons");

                await container.CreateIfNotExistsAsync();

                string blobName = $"order-{order.Reference}.json";
                Microsoft.Azure.Storage.Blob.CloudBlockBlob blockBlob = container.GetBlockBlobReference(blobName);

                string orderJson = JsonConvert.SerializeObject(order, Formatting.Indented);
                await blockBlob.UploadTextAsync(orderJson);

                return blockBlob.Uri.ToString();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"JSON blob storage error: {ex.Message}");
                return null;
            }
        }
    }
}