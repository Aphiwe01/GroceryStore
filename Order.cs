using Microsoft.Azure.Cosmos.Table;
using System;

namespace GroceryStore
{
    public class Order
    {
        public int OrderID { get; set; }
        public int CustomerID { get; set; }
        public int ProductID { get; set; }
        public string FullName { get; set; }
        public string EmailAddress { get; set; }
        public string PhoneNumber { get; set; }
        public string DeliveryAddress { get; set; }
        public string PaymentMethod { get; set; }
        public string Reference { get; set; }
    }

    // Azure Table Storage Entity
    public class OrderEntity : TableEntity
    {
        public OrderEntity()
        {
        }

        public OrderEntity(string partitionKey, string rowKey)
        {
            PartitionKey = partitionKey;
            RowKey = rowKey;
        }

        public int CustomerID { get; set; }
        public int ProductID { get; set; }
        public string FullName { get; set; }
        public string EmailAddress { get; set; }
        public string PhoneNumber { get; set; }
        public string DeliveryAddress { get; set; }
        public string PaymentMethod { get; set; }
        public string Reference { get; set; }
    }
}