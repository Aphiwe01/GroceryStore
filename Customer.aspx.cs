using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GroceryStore
{
    public partial class Customer : System.Web.UI.Page
    {
        public static object customerId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string eventTarget = Request["__EVENTTARGET"];
                string eventArgument = Request["__EVENTARGUMENT"];

                if (eventTarget == "SaveProfile")
                {
                    SaveProfileData();
                }
            }
        }

        private void SaveProfileData()
        {
            string name = Request.Form["name"];
            string email = Request.Form["email"];
            string phone = Request.Form["phone"];
            string location = Request.Form["location"];
            string ageStr = Request.Form["age"];

            // Get user_id from session (assuming you store it after login)
            int user_id = Convert.ToInt32(Session["user_id"]);

            if (!decimal.TryParse(ageStr, out decimal age))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('INVALID AGE!');", true);
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["AgricultureConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    con.Open();

                    // Check if profile exists
                    string checkSql = "SELECT COUNT(*) FROM Profile WHERE user_id = @user_id";
                    SqlCommand checkCmd = new SqlCommand(checkSql, con);
                    checkCmd.Parameters.AddWithValue("@user_id", user_id);
                    int exists = (int)checkCmd.ExecuteScalar();

                    string sql;
                    if (exists > 0)
                    {
                        // Update existing profile
                        sql = @"UPDATE Profile SET 
                                FullName = @FullName, 
                                Email = @Email, 
                                Phone = @Phone, 
                                Location = @Location, 
                                Age = @Age 
                                WHERE user_id = @user_id";
                    }
                    else
                    {
                        // Insert new profile
                        sql = @"INSERT INTO Profile 
                                (user_id, FullName, Email, Phone, Location, Age) 
                                VALUES 
                                (@user_id, @FullName, @Email, @Phone, @Location, @Age)";
                    }

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@user_id", user_id);
                    cmd.Parameters.AddWithValue("@FullName", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Phone", phone);
                    cmd.Parameters.AddWithValue("@Location", location);
                    cmd.Parameters.AddWithValue("@Age", age);

                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('PROFILE SAVED SUCCESSFULLY!');", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('PROFILE SAVE FAILED! PLEASE TRY AGAIN.');", true);
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('ERROR: {ex.Message.Replace("'", "\\'")}');", true);
                }
            }
        }
        [WebMethod]
        public static void SaveProductData()
        {
            try
            {
                var context = HttpContext.Current;
                var response = context.Response;
                var request = context.Request;

                // Get form data
                string productName = request.Form["productName"];
                string description = request.Form["productDescription"];
                string category = request.Form["productCategory"];
                string productionDate = request.Form["productionDate"];
                string quantityStr = request.Form["productQuantity"];

                // Validate required fields
                if (string.IsNullOrEmpty(productName) ||
                    string.IsNullOrEmpty(category) ||
                    string.IsNullOrEmpty(productionDate) ||
                    string.IsNullOrEmpty(quantityStr))
                {
                    SendResponse(false, "MISSING REQUIRED FIELDS!");
                    return;
                }

                if (!decimal.TryParse(quantityStr, out decimal quantity))
                {
                    SendResponse(false, "INVALID QUANTITY VALUE!");
                    return;
                }

                // Get farmer ID from session (assuming you store it after login)
                int farmerId = Convert.ToInt32(context.Session["user_id"]);

                // Map category name to category ID (you might want to get this from database)
                int categoryId = GetCategoryId(category);

                // Default price (you might want to calculate this differently)
                decimal price = CalculatePrice(category, quantity);

                // Handle image upload if exists
                string imagePath = null;
                if (request.Files.Count > 0 && request.Files["productImage"] != null)
                {
                    HttpPostedFile imageFile = request.Files["productImage"];
                    imagePath = SaveUploadedImage(imageFile);
                }

                // Save to database
                string connectionString = ConfigurationManager.ConnectionStrings["AgricultureConnectionString"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    string sql = @"INSERT INTO products 
                                (product_id, name, customer_id, category_id, quantity, price, description, date_added) 
                                VALUES 
                                (@product_id, @name, @customer_id, @category_id, @quantity, @price, @description, @date_added)";

                    SqlCommand cmd = new SqlCommand(sql, con);

                    // Generate a new product ID (you might want to use identity column instead)
                    cmd.Parameters.AddWithValue("@product_id", Guid.NewGuid().GetHashCode() & 0x7FFFFFFF);
                    cmd.Parameters.AddWithValue("@name", productName);
                    cmd.Parameters.AddWithValue("@customer_id", customerId);
                    cmd.Parameters.AddWithValue("@category_id", categoryId);
                    cmd.Parameters.AddWithValue("@quantity", quantity);
                    cmd.Parameters.AddWithValue("@price", price);
                    cmd.Parameters.AddWithValue("@description", description ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@date_added", DateTime.Parse(productionDate));

                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        SendResponse(true, "PRODUCT SAVED SUCCESSFULLY!");
                    }
                    else
                    {
                        SendResponse(false, "FAILED TO SAVE PRODUCT!");
                    }
                }
            }
            catch (Exception ex)
            {
                SendResponse(false, "ERROR: " + ex.Message);
            }
        }

        private static int GetCategoryId(string categoryName)
        {
            // This is a simple mapping - you should get this from your database
            switch (categoryName.ToLower())
            {
                case "vegetables": return 1;
                case "fruits": return 2;
                case "grains": return 3;
                case "dairy": return 4;
                case "poultry": return 5;
                default: return 0;
            }
        }

        private static decimal CalculatePrice(string category, decimal quantity)
        {
            // Simple price calculation - you should implement your own logic
            decimal basePrice = 0;

            switch (category.ToLower())
            {
                case "vegetables": basePrice = 50; break;
                case "fruits": basePrice = 80; break;
                case "grains": basePrice = 40; break;
                case "dairy": basePrice = 120; break;
                case "poultry": basePrice = 200; break;
                default: basePrice = 30; break;
            }

            return basePrice * quantity;
        }

        private static string SaveUploadedImage(HttpPostedFile imageFile)
        {
            // Implement your image saving logic here
            // For example:
            string uploadFolder = HttpContext.Current.Server.MapPath("~/ProductImages/");
            string fileName = Guid.NewGuid().ToString() + Path.GetExtension(imageFile.FileName);
            string filePath = Path.Combine(uploadFolder, fileName);

            if (!Directory.Exists(uploadFolder))
            {
                Directory.CreateDirectory(uploadFolder);
            }

            imageFile.SaveAs(filePath);
            return "/ProductImages/" + fileName;
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