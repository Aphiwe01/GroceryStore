using Microsoft.WindowsAzure.Storage.Table;
using System;

namespace GroceryStore.AzureEntities
{
    public class CustomerEntity : TableEntity
    {
        public CustomerEntity(string customerId, string name)
        {
            this.PartitionKey = "Customers";
            this.RowKey = customerId;
            this.Name = name;
        }

        public CustomerEntity() { }

        public string Name { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Location { get; set; }
        public int Age { get; set; }
        public DateTime JoinDate { get; set; }
    }
    public class ProductEntity : TableEntity
    {
        public ProductEntity(string productId, string name)
        {
            this.PartitionKey = "Products";
            this.RowKey = productId;
            this.Name = name;
        }

        public ProductEntity() { }

        public string Name { get; set; }
        public string CustomerId { get; set; }
        public string Category { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
        public string Description { get; set; }
        public string ImageUrl { get; set; }
        public DateTime DateAdded { get; set; }
    }

  
  
}