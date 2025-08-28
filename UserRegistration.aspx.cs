using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace GroceryStore
{
    public partial class UserRegistration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request.Form["__action"];

            if (IsPostBack)
            {
                if (action == "signup")
                {
                    HandleSignUp();
                }
                else if (action == "login")
                {
                    HandleLogin();
                }
            }
        }

        private void HandleSignUp()
        {
            string name = Request.Form["signupName"];
            string email = Request.Form["signupEmail"];
            string password = Request.Form["signupPassword"];

            if (!ValidateInput(name, email, password)) return;

            string connStr = ConfigurationManager.ConnectionStrings["AgricultureConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                int newUserId = 1;
                SqlCommand getMaxIdCmd = new SqlCommand("SELECT ISNULL(MAX(user_id), 0) + 1 FROM signup", conn);
                newUserId = (int)getMaxIdCmd.ExecuteScalar();

                SqlCommand insertSignup = new SqlCommand("INSERT INTO signup (user_id, name, email, password) VALUES (@id, @name, @mail, @pass)", conn);
                insertSignup.Parameters.AddWithValue("@id", newUserId);
                insertSignup.Parameters.AddWithValue("@name", name);
                insertSignup.Parameters.AddWithValue("@mail", email);
                insertSignup.Parameters.AddWithValue("@pass", password);

                SqlCommand insertLogin = new SqlCommand("INSERT INTO login (user_id, email, password) VALUES (@id, @mail, @pass)", conn);
                insertLogin.Parameters.AddWithValue("@id", newUserId);
                insertLogin.Parameters.AddWithValue("@mail", email);
                insertLogin.Parameters.AddWithValue("@pass", password);

                insertSignup.ExecuteNonQuery();
                insertLogin.ExecuteNonQuery();

                Response.Write("<script>alert('Welcome'); window.location='index.aspx';</script>");
            }
        }

        private void HandleLogin()
        {
            string email = Request.Form["loginEmail"];
            string password = Request.Form["loginPassword"];

            if (!ValidateInput("dummy", email, password)) return;

            string connStr = ConfigurationManager.ConnectionStrings["AgricultureConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM login WHERE email=@mail AND password=@pass", conn);
                cmd.Parameters.AddWithValue("@mail", email);
                cmd.Parameters.AddWithValue("@pass", password);

                int count = (int)cmd.ExecuteScalar();
                if (count == 1)
                {
                    Response.Write("<script>alert('Welcome'); window.location='index.aspx';</script>");
                }
                else
                {
                    Response.Write("<script>alert('Invalid credentials');</script>");
                }
            }
        }

        private bool ValidateInput(string name, string email, string password)
        {
            if (string.IsNullOrWhiteSpace(name) && name != "dummy")
            {
                Response.Write("<script>alert('Name field is empty');</script>");
                return false;
            }

            if (name != "dummy" && !Regex.IsMatch(name, @"^(?=.*[a-z])(?=.*[A-Z]).{2,}$"))
            {
                Response.Write("<script>alert('Name must use both uppercase and lowercase letters');</script>");
                return false;
            }

            if (string.IsNullOrWhiteSpace(email))
            {
                Response.Write("<script>alert('Email field is empty');</script>");
                return false;
            }

            if (!Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.(com)$"))
            {
                Response.Write("<script>alert('Email must be valid and include @ and .co.za');</script>");
                return false;
            }

            if (string.IsNullOrWhiteSpace(password))
            {
                Response.Write("<script>alert('Password field is empty');</script>");
                return false;
            }

            if (password.Length < 8)
            {
                Response.Write("<script>alert('Password too short (min 8 characters)');</script>");
                return false;
            }

            if (password.Length > 20)
            {
                Response.Write("<script>alert('Password too long (max 20 characters)');</script>");
                return false;
            }

            if (!Regex.IsMatch(password, @"^(?=.*[a-z])(?=.*[A-Z])(?=.*[\W_]).{8,20}$"))
            {
                Response.Write("<script>alert('Password must include at least 1 uppercase, 1 lowercase, and 1 special character');</script>");
                return false;
            }

            return true;
        }
    }
}
