<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserRegistration.aspx.cs" Inherits="GroceryStore.UserRegistration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css"
          integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf"
          crossorigin="anonymous">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <link href="CSS/UU.css" rel="stylesheet" type="text/css" />
    <link href="CSS/U.css" rel="stylesheet" type="text/css" />
    <script src="JS/U.js" type="text/javascript"></script>
</head>
<body>
    <div class="nav">
        <div class="logo">
            <a href="index.aspx">Grocery Store </a>
        </div>
        <ul>
        <li><a href="index.aspx" id="homeLink">Home</a></li>
      <li><a href="Admin.aspx" id="adminLink">Admin</a></li>
            <li><a href="UserRegistration.aspx">UserRegistration</a></li>
          <li><a href="Customer.aspx" id="customerLink">Customer</a></li>
            <li>
                <div class="search-container">
                    <input type="text" placeholder="Search..." class="search-input">
                    <button class="search-button">G</button>
                </div>
            </li>
        </ul>
    </div>
    <section>

    </section>
    <section>

    </section>
    <section>

    </section>
    <div></div>
    <div class="container" id="container">
        <div class="form-container sign-up-container">
            <form action="#" method="post">
                <h1>Create Account</h1>
                <div class="social-container">
                    <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
                    <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
                </div>
                <span>or use your email for registration</span>
                <input type="text" id="signupName" placeholder="Name" />
                <input type="email" id="signupEmail" placeholder="Email" />
                <input type="password" id="signupPassword" placeholder="Password" />
                <input type="hidden" name="__action" id="__action" />
                <button type="button" id="signUpButton">Sign Up</button>
            </form>
        </div>
        <div class="form-container sign-in-container">
            <form action="#" method="post">
                <h1>Log in</h1>
                <div class="social-container">
                    <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
                    <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
                </div>
                <span>or use your account</span>
                <input type="email" id="loginEmail" placeholder="Email" />
                <input type="password" id="loginPassword" placeholder="Password" />
                <input type="hidden" name="__action" id="__action" />
                <a href="#">Forgot your password?</a>
                <button type="button" id="loginButton">Log In</button>
            </form>
        </div>
        <div class="overlay-container">
            <div class="overlay">
                <div class="overlay-panel overlay-left">
                    <h1>Welcome Back!</h1>
                    <p>To keep connected with us please login with your personal info</p>
                    <button class="ghost" id="signIn">Log in ADMIN</button>
                </div>
                <div class="overlay-panel overlay-right">
                    <h1>Hello, Friend!</h1>
                    <p>Enter your personal details and start journey with us</p>
                    <button class="ghost" id="signUp">Sign Up</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        let remainingAttempts = 3; // Start with 3 attempts

        document.getElementById("signIn").addEventListener("click", function () {
            if (remainingAttempts <= 0) {
                alert("No attempts left. Contact support.");
                return; // Exit if no attempts remain
            }

            const adminEmail = prompt("Enter admin email:");
            const adminPassword = prompt("Enter admin password:");

            // Hardcoded check (replace with backend auth later)
            if (adminEmail === "admin@example.com" && adminPassword === "admin123") {
                alert("Login successful! Redirecting...");
                window.location.href = "Admin.aspx";
            } else {
                remainingAttempts--;
                if (remainingAttempts > 0) {
                    alert(`Invalid credentials. ${remainingAttempts} attempt(s) left.`);
                } else {
                    alert("No attempts left. Account locked.");
                }
            }
        });
    </script>
    <script>
        document.getElementById("customerLink").addEventListener("click", (e) => {
            // Replace with your actual auth check (e.g., localStorage, JWT, or session)
            const isCustomer = false; // Default: false (user not logged in)
           

            // Block if user is not a logged-in farmer
            if (!isCustomer) {
                e.preventDefault(); // Stop the link from navigating
                alert(
                    "🚜 Customer Access Only\n\n" +
                    "You must be logged in as a customer to view this page.\n\n" +
                    "Please Login in with your customeraccount.\n" +
                    "Contact: OnlineGrocery@worldonline.com for assistance."
                );
            }
        });
    </script>
   <script>
       document.getElementById("homeLink").addEventListener("click", (e) => {
           // Replace with your actual auth check (e.g., localStorage, JWT, or session)
           const isHome = false; // Default: false (user not logged in)
            
           if (!isHome)  {
               e.preventDefault(); // Stop the link from navigating
               alert("🔒 Restricted Access\n\n" +
                   "You must log in to view this page.\n\n" +
                   "Admins and Customer: Please Login in to access your account.\n" +
                   "Need help? Contact OnlineGrocery@worldonline.com."
               );
           }
       });
   </script>
    <script>
        document.getElementById("adminLink").addEventListener("click", (e) => {
            const isAdmin = false; // Replace with real role check

            if (!isAdmin) {
                e.preventDefault(); // Stop the link from navigating
                alert("Admins only. Customer, use UserRegistration.");
            }
        });
    </script>

    <script>
      

        document.getElementById('signUpButton').addEventListener('click', function () {
            if (validateForm("signup")) {
                document.getElementById('__action').value = 'signup';
                const container = document.getElementById('container');
                container.classList.remove("right-panel-active");
                alert("Sign up validated successfully.");
            }
        });

        document.getElementById('loginButton').addEventListener('click', function () {
            if (validateForm("login")) {
                document.getElementById('__action').value = 'login';
                window.location.href = 'index.aspx';
               
            }
        });

        document.getElementById('signUp').addEventListener('click', () => {
            const container = document.getElementById('container');
            container.classList.add("right-panel-active");
        });

        document.getElementById('signIn').addEventListener('click', () => {
            const container = document.getElementById('container');
            container.classList.remove("right-panel-active");
        });
        // Validation function
        function validateForm(type) {
            let valid = true;
            let name, email, password;

            if (type === "signup") {
                name = document.getElementById("signupName").value.trim();
                email = document.getElementById("signupEmail").value.trim();
                password = document.getElementById("signupPassword").value;
            } else if (type === "login") {
                email = document.getElementById("loginEmail").value.trim();
                password = document.getElementById("loginPassword").value;
            }

            // Clear previous errors
            document.querySelectorAll(".error-message").forEach(el => el.remove());

            function showError(inputId, message) {
                const input = document.getElementById(inputId);
                const error = document.createElement("div");
                error.className = "error-message";
                error.style.color = "red";
                error.style.fontSize = "12px";
                error.innerText = message;
                input.parentNode.insertBefore(error, input.nextSibling);
                valid = false;
            }

            if (type === "signup") {
                if (!name) {
                    showError("signupName", "Field is empty");
                } else if (!(/[a-z]/.test(name) && /[A-Z]/.test(name))) {
                    showError("signupName", "Use both uppercase and lowercase letters in name");
                }

                if (!email) {
                    showError("signupEmail", "Field is empty");
                } else if (!(email.includes("@") && email.endsWith(".co.za"))) {
                    showError("signupEmail", "Email must include '@' and end with '.com'");
                }

                if (!password) {
                    showError("signupPassword", "Field is empty");
                } else {
                    if (password.length < 8) {
                        showError("signupPassword", "Password too short (min 8 chars)");
                    } else if (password.length > 20) {
                        showError("signupPassword", "Password too long");
                    }
                    if (!/[A-Z]/.test(password)) {
                        showError("signupPassword", "Must include uppercase letter");
                    }
                    if (!/[a-z]/.test(password)) {
                        showError("signupPassword", "Must include lowercase letter");
                    }
                    if (!/[!@#$%^&*(),.?":{}|<>]/.test(password)) {
                        showError("signupPassword", "Must include special character");
                    }
                }
            } else if (type === "login") {
                if (!email) {
                    showError("loginEmail", "Field is empty");
                } else if (!(email.includes("@") && email.endsWith(".co.za"))) {
                    showError("loginEmail", "Email must include '@' and end with '.co.za'");
                }

                if (!password) {
                    showError("loginPassword", "Field is empty");
                }
            }

            return valid;
        }

        document.getElementById('loginButton').addEventListener('click', function () {
            if (validateForm("login")) {
                document.getElementById('__action').value = 'login';
                // Add this line to show the popup message
                alert("Welcome, to the OnlineGroceryStore");
                window.location.href = 'index.aspx';
            }
        });


    </script>
</body>
</html>
