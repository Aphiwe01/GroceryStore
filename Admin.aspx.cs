using System;
using System.Configuration;
using System.IO;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Table;
using Microsoft.WindowsAzure.Storage.Blob;
using Microsoft.WindowsAzure.Storage.Queue;
using Microsoft.WindowsAzure.Storage.File;

namespace GroceryStore
{
    public partial class Admin : System.Web.UI.Page
    {
        // Azure Storage connections
        public CloudStorageAccount storageAccount;
        public CloudTableClient tableClient;
        public CloudBlobClient blobClient;
        public CloudQueueClient queueClient;
        public CloudFileClient fileClient;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Initialize Azure Storage
            InitializeAzureStorage();

            if (IsPostBack)
            {
                // Handle form submission if needed
            }
        }

        private void InitializeAzureStorage()
        {
            try
            {
                string connectionString = ConfigurationManager.AppSettings["AzureStorageConnection"];
                storageAccount = CloudStorageAccount.Parse(connectionString);

                tableClient = storageAccount.CreateCloudTableClient();
                blobClient = storageAccount.CreateCloudBlobClient();
                queueClient = storageAccount.CreateCloudQueueClient();
                fileClient = storageAccount.CreateCloudFileClient();
            }
            catch (Exception ex)
            {
                // Log error
                LogToAzureFiles("Error initializing Azure Storage: " + ex.Message);
            }
        }

        [WebMethod]
        public static void AddCustomer()
        {
            try
            {
                var context = HttpContext.Current;
                var request = context.Request;

                // Get form data
                string name = request.Form["customerName"];
                string email = request.Form["customerEmail"];
                string phone = request.Form["customerPhone"];
                string location = request.Form["customerLocation"];
                string ageStr = request.Form["customerAge"];
                string joinDateStr = request.Form["customerJoinDate"];

                // Validate required fields
                if (string.IsNullOrEmpty(name) ||
                    string.IsNullOrEmpty(email) ||
                    string.IsNullOrEmpty(phone) ||
                    string.IsNullOrEmpty(location) ||
                    string.IsNullOrEmpty(ageStr) ||
                    string.IsNullOrEmpty(joinDateStr))
                {
                    SendResponse(false, "ALL FIELDS MARKED WITH * ARE REQUIRED!");
                    return;
                }

                if (!decimal.TryParse(ageStr, out decimal age) || age <= 0)
                {
                    SendResponse(false, "PLEASE ENTER A VALID AGE (MUST BE GREATER THAN 0)!");
                    return;
                }

                if (!DateTime.TryParse(joinDateStr, out DateTime joinDate))
                {
                    SendResponse(false, "PLEASE ENTER A VALID JOIN DATE!");
                    return;
                }

                // Validate email format
                if (!System.Text.RegularExpressions.Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
                {
                    SendResponse(false, "PLEASE ENTER A VALID EMAIL ADDRESS!");
                    return;
                }

                // Validate phone number (basic check)
                if (phone.Length < 8)
                {
                    SendResponse(false, "PLEASE ENTER A VALID PHONE NUMBER!");
                    return;
                }

                // Generate customer ID
                string customerId = Guid.NewGuid().ToString();

                // Save to Azure Table Storage
                SaveCustomerToAzureTable(customerId, name, email, phone, location, age, joinDate);

                // Add message to queue
                AddMessageToQueue($"Customer {name} added with ID: {customerId}");

                SendResponse(true, $"CUSTOMER ADDED SUCCESSFULLY! ID: {customerId}");
            }
            catch (Exception ex)
            {
                LogToAzureFiles("Error adding customer: " + ex.Message);
                SendResponse(false, "ERROR: " + ex.Message);
            }
        }

        private static void SaveCustomerToAzureTable(string customerId, string name, string email, string phone, string location, decimal age, DateTime joinDate)
        {
            try
            {
                // This would be implemented with actual Azure Table Storage code
                // For now, we'll just log the operation
                LogToAzureFiles($"Customer saved to Azure Table: ID={customerId}, Name={name}, Email={email}");
            }
            catch (Exception ex)
            {
                LogToAzureFiles("Error saving to Azure Table: " + ex.Message);
                throw;
            }
        }

        [WebMethod]
        public static void AddProduct()
        {
            try
            {
                var context = HttpContext.Current;
                var request = context.Request;

                // Get form data
                string name = request.Form["productName"];
                string customerId = request.Form["productCustomer"];
                string category = request.Form["productCategory"];
                string quantityStr = request.Form["productQuantity"];
                string priceStr = request.Form["productPrice"];
                string description = request.Form["productDescription"];
                string dateStr = request.Form["productDate"];
                HttpPostedFile imageFile = context.Request.Files["productImage"];

                // Validate required fields
                if (string.IsNullOrEmpty(name) ||
                    string.IsNullOrEmpty(customerId) ||
                    string.IsNullOrEmpty(category) ||
                    string.IsNullOrEmpty(quantityStr) ||
                    string.IsNullOrEmpty(priceStr) ||
                    string.IsNullOrEmpty(dateStr))
                {
                    SendResponse(false, "ALL FIELDS MARKED WITH * ARE REQUIRED!");
                    return;
                }

                if (!int.TryParse(quantityStr, out int quantity) || quantity <= 0)
                {
                    SendResponse(false, "PLEASE ENTER A VALID QUANTITY (MUST BE GREATER THAN 0)!");
                    return;
                }

                if (!decimal.TryParse(priceStr, out decimal price) || price <= 0)
                {
                    SendResponse(false, "PLEASE ENTER A VALID PRICE (MUST BE GREATER THAN 0)!");
                    return;
                }

                if (!DateTime.TryParse(dateStr, out DateTime dateAdded))
                {
                    SendResponse(false, "PLEASE ENTER A VALID DATE!");
                    return;
                }

                // Generate product ID
                string productId = Guid.NewGuid().ToString();

                // Save image to Azure Blob Storage if provided
                string imageUrl = "";
                if (imageFile != null && imageFile.ContentLength > 0)
                {
                    imageUrl = SaveImageToBlobStorage(imageFile, productId);
                }

                // Save to Azure Table Storage
                SaveProductToAzureTable(productId, name, customerId, category, quantity, price, description, imageUrl, dateAdded);

                // Add message to queue
                AddMessageToQueue($"Product {name} added with ID: {productId}");

                SendResponse(true, $"PRODUCT ADDED SUCCESSFULLY! ID: {productId}");
            }
            catch (Exception ex)
            {
                LogToAzureFiles("Error adding product: " + ex.Message);
                SendResponse(false, "ERROR: " + ex.Message);
            }
        }

        private static string SaveImageToBlobStorage(HttpPostedFile imageFile, string productId)
        {
            try
            {
                string fileName = $"{productId}_{Path.GetFileName(imageFile.FileName)}";
                LogToAzureFiles($"Image saved to Azure Blob Storage: {fileName}");

                return $"images/chicken.jpg{fileName}";
            }
            catch (Exception ex)
            {
                LogToAzureFiles("Error saving image to blob storage: " + ex.Message);
                throw;
            }
        }

        private static void SaveProductToAzureTable(string productId, string name, string customerId, string category, int quantity, decimal price, string description, string imageUrl, DateTime dateAdded)
        {
            try
            {
                // This would be implemented with actual Azure Table Storage code
                // For now, we'll just log the operation
                LogToAzureFiles($"Product saved to Azure Table: ID={productId}, Name={name}, Category={category}");
            }
            catch (Exception ex)
            {
                LogToAzureFiles("Error saving product to Azure Table: " + ex.Message);
                throw;
            }
        }

        private static void AddMessageToQueue(string message)
        {
            try
            {
                // This would be implemented with actual Azure Queue Storage code
                // For now, we'll just log the operation
                LogToAzureFiles($"Message added to queue: {message}");
            }
            catch (Exception ex)
            {
                LogToAzureFiles("Error adding message to queue: " + ex.Message);
                throw;
            }
        }

        private static void LogToAzureFiles(string message)
        {
            try
            {
                // This would be implemented with actual Azure Files code
                // For now, we'll just write to a local file for demonstration
                string logPath = HttpContext.Current.Server.MapPath("~/App_Data/logs.txt");
                Directory.CreateDirectory(Path.GetDirectoryName(logPath));
                File.AppendAllText(logPath, $"{DateTime.Now}: {message}\n");
            }
            catch (Exception ex)
            {
                // If Azure Files fails, fall back to local logging
                string logPath = HttpContext.Current.Server.MapPath("~/App_Data/error_logs.txt");
                Directory.CreateDirectory(Path.GetDirectoryName(logPath));
                File.AppendAllText(logPath, $"{DateTime.Now}: Error logging to Azure Files: {ex.Message}\n");
            }
        }

        private static int GenerateCustomerId()
        {

            return Math.Abs(Guid.NewGuid().GetHashCode() & 0x7FFFFFFF);
        }

        private static void SendResponse(bool success, string message)
        {
            var response = new
            {
                success = success,
                message = message
            };

            HttpContext.Current.Response.ContentType = "application/json";
            HttpContext.Current.Response.Write(new JavaScriptSerializer().Serialize(response));
        }
    }
}

