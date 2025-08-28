
using System;
using System.Threading.Tasks;
using System.Web.UI;

namespace GroceryStore
{
    public partial class index : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected async void ConfirmOrder_Click(object sender, EventArgs e)
        {
            try
            {
                // Create order object from form data
                Order newOrder = new Order
                {

                    FullName = Request.Form["fullName"],
                    EmailAddress = Request.Form["email"],
                    PhoneNumber = Request.Form["phone"],
                    DeliveryAddress = Request.Form["address"],
                    PaymentMethod = Request.Form["paymentMethod"],
                    Reference = GenerateOrderReference()
                };

                // Insert into SQL Database
                bool dbSuccess = DatabaseHelper.InsertOrder(newOrder);

                if (dbSuccess)
                {
                    // Store in Azure services asynchronously
                    await Task.WhenAll(
                        AzureServicesHelper.UploadOrderToBlob(newOrder),
                        AzureServicesHelper.SaveOrderToFileShare(newOrder),
                        AzureServicesHelper.AddOrderToQueue(newOrder),
                        AzureServicesHelper.InsertOrderToTable(newOrder)
                    );

                    // Show success message
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "orderSuccess",
                        $"alert('Order placed successfully! Reference: {newOrder.Reference}');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "orderError",
                        "alert('Error placing order. Please try again.');", true);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Order processing error: {ex.Message}");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "orderError",
                    "alert('Error placing order. Please try again.');", true);
            }
        }

        private string GenerateOrderReference()
        {
            return "ORD-" + DateTime.Now.ToString("yyyyMMdd") + "-" +
                   Guid.NewGuid().ToString().Substring(0, 8).ToUpper();
        }
    }
}