using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace GroceryStore
{
    public class DatabaseHelper
    {
        private static readonly string connectionString = ConfigurationManager.ConnectionStrings["FreshMartConnection"].ConnectionString;

        public static bool InsertOrder(Order order)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();
                    string query = @"INSERT INTO Orders (CustomerID, ProductID, FullName, EmailAddress, PhoneNumber, 
                                    DeliveryAddress, PaymentMethod, Reference)
                                    VALUES (@CustomerID, @ProductID, @FullName, @EmailAddress, @PhoneNumber, 
                                    @DeliveryAddress, @PaymentMethod, @Reference)";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@CustomerID", order.CustomerID);
                        command.Parameters.AddWithValue("@ProductID", order.ProductID);
                        command.Parameters.AddWithValue("@FullName", order.FullName);
                        command.Parameters.AddWithValue("@EmailAddress", order.EmailAddress);
                        command.Parameters.AddWithValue("@PhoneNumber", order.PhoneNumber);
                        command.Parameters.AddWithValue("@DeliveryAddress", order.DeliveryAddress);
                        command.Parameters.AddWithValue("@PaymentMethod", order.PaymentMethod);
                        command.Parameters.AddWithValue("@Reference", order.Reference);

                        int result = command.ExecuteNonQuery();
                        return result > 0;
                    }
                }
                catch (Exception ex)
                {
                    // Log error
                    System.Diagnostics.Debug.WriteLine($"Database error: {ex.Message}");
                    return false;
                }
            }
        }
    }
}