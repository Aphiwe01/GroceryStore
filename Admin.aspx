<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="GroceryStore.Admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Online Grocery Store</title>
  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <!-- Chart.js -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <!-- Custom CSS -->
  <style>
    :root {
      --bg-dark: #1a2131;
      --btn-primary: #2869ff;
      --text-light: #ffffff;
      --card-bg: #2a3447;
      --success: #28a745;
      --warning: #ffc107;
      --danger: #dc3545;
    }
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f5f5f5;
    }
    /* Sidebar */
    .sidebar {
      background: var(--bg-dark);
      color: var(--text-light);
      height: 100vh;
      position: fixed;
      border-right: 1px solid rgba(255, 255, 255, 0.1);
    }
    .sidebar .nav-link {
      color: rgba(255, 255, 255, 0.8);
      margin: 5px 0;
      border-radius: 5px;
      transition: all 0.3s;
    }
    .sidebar .nav-link:hover, .sidebar .nav-link.active {
      background: var(--btn-primary);
      color: white;
    }
    .sidebar .nav-link i {
      margin-right: 10px;
    }
    /* Main Content */
    .main-content {
      margin-left: 250px;
      padding: 20px;
      min-height: 100vh;
    }
    /* Cards */
    .stats-card {
      border: none;
      border-radius: 10px;
      padding: 20px;
      color: white;
      transition: transform 0.3s;
    }
    .stats-card:hover {
      transform: translateY(-5px);
    }
    /* Tables */
    .data-table {
      background: white;
      border-radius: 10px;
      padding: 20px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .status-badge {
      padding: 5px 10px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: bold;
    }
    .status-pending {
      background: #fff3cd;
      color: #856404;
    }
    .status-completed {
      background: #d4edda;
      color: #155724;
    }
    /* Forms */
    .form-section {
      background: white;
      border-radius: 10px;
      padding: 20px;
      margin-bottom: 20px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    /* Responsive */
    @media (max-width: 768px) {
      .sidebar {
        margin-left: -250px;
      }
      .sidebar.active {
        margin-left: 0;
      }
      .main-content {
        margin-left: 0;
      }
    }
  </style>
</head>

<body>
  <!-- Sidebar -->
  <div class="sidebar p-3" id="sidebar">
    <div class="text-center mb-4">
      <h4>Online Grocery Store</h4>
      <hr class="bg-light">
    </div>
    <ul class="nav flex-column">
      <!-- Dashboard removed -->
      <li class="nav-item">
        <a class="nav-link active" href="#" data-section="customers">
          <i class="fas fa-users"></i> Customers
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#" data-section="products">
          <i class="fas fa-box-open"></i> Products
        </a>
      </li>
        <li class="nav-item">
        <a class="nav-link" href="#" data-section="notifications">
          <i class="fas fa-bell"></i> Notifications
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#" data-section="login">
          <i class="fas fa-sign-in-alt"></i> Login
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#" data-section="signup">
          <i class="fas fa-user-plus"></i> SignUp
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#" data-section="orders">
          <i class="fas fa-shopping-cart"></i> Orders
        </a>
      </li>
        <li class="nav-item">
  <a class="nav-link" href="#" data-section="fileshare">
    <i class="fas fa-folder"></i> File Share
  </a>
</li>

      <li class="nav-item mt-3">
        <a class="nav-link text-danger" href="UserRegistration.aspx">
          <i class="fas fa-sign-out-alt"></i> Logout
        </a>
      </li>
    </ul>
  </div>

  <!-- Main Content -->
  <div class="main-content" id="mainContent">
    <!-- NOTE: I didn't change overall structure; using JS alerts for output messages as requested -->

    <!-- Customers Section -->
    <div id="customersSection">
      <div class="form-section">
        <h4>Add New Customer</h4>
        <form id="customerForm">
          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="customerName" class="form-label">Full Name *</label>
              <input type="text" class="form-control" id="customerName" required>
            </div>
            <div class="col-md-6 mb-3">
              <label for="customerEmail" class="form-label">Email *</label>
              <input type="email" class="form-control" id="customerEmail" required>
            </div>
          </div>
          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="customerPhone" class="form-label">Phone *</label>
              <input type="tel" class="form-control" id="customerPhone" required>
            </div>
            <div class="col-md-6 mb-3">
              <label for="customerLocation" class="form-label">Location *</label>
              <input type="text" class="form-control" id="customerLocation" required>
            </div>
          </div>
          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="customerAge" class="form-label">Age *</label>
              <input type="number" class="form-control" id="customerAge" min="18" step="1" required>
            </div>
            <div class="col-md-6 mb-3">
              <label for="customerJoinDate" class="form-label">Join Date *</label>
              <input type="date" class="form-control" id="customerJoinDate" required>
            </div>
          </div>
          <button type="submit" class="btn btn-primary">Add Customer</button>
        </form>
      </div>

      <div class="data-table">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <h5>All Customers</h5>
          <div>
            <input type="text" class="form-control form-control-sm" id="customerSearch" placeholder="Search customers..." style="width: 200px; display: inline-block;">
            <select class="form-control form-control-sm d-inline-block ms-2" id="customerCategoryFilter" style="width: 150px;">
              <option value="">All Categories</option>
              <option value="small">Young (18-25)</option>
              <option value="medium">Adult (26-40)</option>
              <option value="large">Senior (&gt;40)</option>
            </select>
            <input type="date" class="form-control form-control-sm d-inline-block ms-2" id="customerDateFilter" style="width: 150px;">
            <button class="btn btn-sm btn-outline-primary ms-2" id="resetCustomerSearch">
              <i class="fas fa-sync-alt"></i> Reset
            </button>
          </div>
        </div>
        <div class="table-responsive">
          <table class="table" id="customersTable">
            <thead>
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Location</th>
                <th>Age</th>
                <th>Join Date</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <!-- Customer data will be inserted here -->
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- Products Section -->
    <div class="d-none" id="productsSection">
      <div class="form-section">
        <h4>Add New Product</h4>
       <form id="productForm">
      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="productName" class="form-label">Product Name *</label>
          <input type="text" class="form-control" id="productName" required>
        </div>
        <div class="col-md-6 mb-3">
          <label for="productCustomer" class="form-label">Customer *</label>
          <select class="form-select" id="productCustomer" required>
            <option value="">Select Customer</option>
          </select>
        </div>
      </div>
      <div class="row">
        <div class="col-md-3 mb-3">
          <label for="productCategory" class="form-label">Category *</label>
          <select class="form-select" id="productCategory" required>
            <option value="">Select Category</option>
            <option value="vegetables">Vegetables</option>
            <option value="fruits">Fruits</option>
            <option value="grains">Grains</option>
            <option value="dairy">Dairy</option>
            <option value="beverages">Beverages</option>
            <option value="snacks">Snacks & Chips</option>
            <option value="bakery">Bakery</option>
            <option value="frozen">Frozen Foods</option>
            <option value="meat">Meat</option>
          </select>
        </div>
        <div class="col-md-3 mb-3">
          <label for="productQuantity" class="form-label">Quantity *</label>
          <input type="number" class="form-control" id="productQuantity" min="1" required>
        </div>
        <div class="col-md-3 mb-3">
          <label for="productPrice" class="form-label">Price (R) *</label>
          <input type="number" class="form-control" id="productPrice" min="0.01" step="0.01" required>
        </div>
        <div class="col-md-3 mb-3">
          <label for="productDate" class="form-label">Date *</label>
          <input type="date" class="form-control" id="productDate" required>
        </div>
      </div>
      <div class="mb-3">
        <label for="productDescription" class="form-label">Description</label>
        <textarea class="form-control" id="productDescription" rows="2"></textarea>
      </div>
      <div class="mb-3">
        <label for="productImage" class="form-label">Image</label>
        <input type="file" class="form-control" id="productImage" accept="image/*">
      </div>
      <button type="submit" class="btn btn-primary">Add Product</button>
    </form>
      </div>

      <div class="data-table">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <h5>All Products</h5>
          <div>
            <input type="text" class="form-control form-control-sm" id="productSearch" placeholder="Search products..." style="width: 200px; display: inline-block;">
            <select class="form-control form-control-sm d-inline-block ms-2" id="productCategoryFilter" style="width: 150px;">
              <option value="">All Categories</option>
              <option value="vegetables">Vegetables</option>
              <option value="fruits">Fruits</option>
              <option value="grains">Grains</option>
              <option value="dairy">Dairy</option>
             <option value="beverages">Beverages</option>
            <option value="snacks">Snacks & Chips</option>
            <option value="bakery">Bakery</option>
            <option value="frozen">Frozen Foods</option>
            <option value="meat">Meat</option>
            </select>
            <input type="date" class="form-control form-control-sm d-inline-block ms-2" id="productDateFilter" style="width: 150px;">
            <button class="btn btn-sm btn-outline-primary ms-2" id="resetProductSearch">
              <i class="fas fa-sync-alt"></i> Reset
            </button>
          </div>
        </div>
        <div class="table-responsive">
          <table class="table" id="productsTable">
            <thead>
              <tr>
                 <th>Customer ID</th>
                <th>Product ID</th>
                <th>Customer</th>
                 <th>Name</th>
                  <th>Description</th>
                <th>Category</th>
                <th>Quantity</th>
                <th>Price (R)</th>               
                <th>Image</th>
                <th>Date</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <!-- Product data will be inserted here -->
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

       <!-- Notifications Section -->
    <div class="d-none" id="notificationsSection">
      <div class="data-table"   style="margin-top:-540px">
        <h5>Notifications</h5>
        <div class="table-responsive" >
          <table class="table"style="margin-left:60px" >
            <thead>
              <tr>
                <th>Type</th>
                <th>Details</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>NewOrder</td>
                <td>CustID=1, OrdRef=ORD-564321, ProdID=PROD_1, Thabo Mokoena</td>
              </tr>
              <tr>
                <td>OrderReceived</td>
                <td>CustID=2, OrdRef=ORD-878012, ProdID=PROD_2, Lerato Nkosi, Cape Town</td>
              </tr>
              <tr>
                <td>Incoming</td>
                <td>CustID=3, OrdRef=ORD-234567, ProdID=PROD_3, Sipho Dlamini, Cash on Delivery</td>
              </tr>
              <tr>
                <td>CustomerOrder</td>
                <td>CustID=4, OrdRef=ORD-987654, ProdID=PROD_4, Nomvula Khumalo</td>
              </tr>
              <tr>
                <td>WebOrder</td>
                <td>CustID=5, OrdRef=ORD-456789, ProdID=PROD_5, Jabulani Mthembu, Port Elizabeth</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- Login Section -->
    <div class="d-none" id="loginSection">
      <div class="data-table"  style="margin-top:-540px">
        <h5>Login</h5>
        <div class="table-responsive">
          <table class="table">
            <thead>
              <tr>
                <th>PartitionKey</th>
                <th>RowKey</th>
                <th>LoginID</th>
                <th>Email</th>
                <th>Password</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>User</td>
                <td>1</td>
                <td>1</td>
                <td>thabo@yahoo.co.za</td>
                <td>tsdaaf#5as</td>
              </tr>
              <tr>
                <td>User</td>
                <td>2</td>
                <td>2</td>
                <td>lerato@outlook.co.za</td>
                <td>ksfd67679@#%</td>
              </tr>
              <tr>
                <td>User</td>
                <td>3</td>
                <td>3</td>
                <td>sipho@icloud.co.za</td>
                <td>23asdl[734]_</td>
              </tr>
              <tr>
                <td>User</td>
                <td>4</td>
                <td>4</td>
                <td>nomvula@gmail.co.za</td>
                <td>AS&"0234:"{</td>
              </tr>
              <tr>
                <td>User</td>
                <td>5</td>
                <td>5</td>
                <td>jabulani@live.co.za</td>
                <td>ASD&"0=I[</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- SignUp Section -->
    <div class="d-none" id="signupSection">
      <div class="data-table"   style="margin-top:-540px">
        <h5>SignUp</h5>
        <div class="table-responsive">
          <table class="table" style="margin-left:60px">
            <thead>
              <tr>
                <th>PartitionKey</th>
                <th>RowKey</th>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Password</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Register</td>
                <td>1</td>
                <td>1</td>
                <td>Thabo Mokoena</td>
                <td>thabo@yahoo.co.za</td>
                <td>tedaaf*$as</td>
              </tr>
              <tr>
                <td>Register</td>
                <td>2</td>
                <td>2</td>
                <td>Lerato Nkosi</td>
                <td>lerato@outlook.co.za</td>
                <td>ksfd67679@#%</td>
              </tr>
              <tr>
                <td>Register</td>
                <td>3</td>
                <td>3</td>
                <td>Sipho Dlamini</td>
                <td>sipho@icloud.co.za</td>
                <td>23asdl/34/...</td>
              </tr>
              <tr>
                <td>Register</td>
                <td>4</td>
                <td>4</td>
                <td>Nomvula Khumalo</td>
                <td>nomvula@gmail.co.za</td>
                <td>AS&^0234:{</td>
              </tr>
              <tr>
                <td>Register</td>
                <td>5</td>
                <td>5</td>
                <td>Jabulani Mthembu</td>
                <td>jabulani@live.co.za</td>
                <td>ASD&^0=]{</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- Orders Section -->
    <div class="d-none" id="ordersSection">
      <div class="data-table"  style="margin-top:-540px">
        <h5>Orders</h5>
        <div class="table-responsive">
          <table class="table">
            <thead>
              <tr>
                <th>CustomerID</th>
                <th>ProductID</th>
                <th>OrderID</th>
                <th>FullName</th>
                <th>EmailAddress</th>
                <th>PhoneNumber</th>
                <th>DeliveryAddress</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>1</td>
                <td>1</td>
                <td>1</td>
                <td>Thabo Mokoena</td>
                <td>thabo@yahoo.co.za</td>
                <td>+27 678345001</td>
                <td>Midrand_Johannesburg</td>
              </tr>
              <tr>
                <td>2</td>
                <td>2</td>
                <td>2</td>
                <td>Lerato Nkosi</td>
                <td>lerato@outlook.co.za</td>
                <td>+27 723345002</td>
                <td>Khayelitsha,Cape Town</td>
              </tr>
              <tr>
                <td>3</td>
                <td>3</td>
                <td>3</td>
                <td>Sipho Dlamini</td>
                <td>sipho@icloud.co.za</td>
                <td>+27 789345003</td>
                <td>Westville,Durban</td>
              </tr>
              <tr>
                <td>4</td>
                <td>4</td>
                <td>4</td>
                <td>Nomvula Khumalo</td>
                <td>nomvula@gmail.co.za</td>
                <td>+27 612345004</td>
                <td>EastRand_Gauteng</td>
              </tr>
              <tr>
                <td>5</td>
                <td>5</td>
                <td>5</td>
                <td>Jabulani Mthembu</td>
                <td>jabulani@live.co.za</td>
                <td>+27 315345005</td>
                <td>QwaQwa, Port Elizabeth</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  
   <!-- File Share Section -->
<div class="d-none" id="fileshareSection">
  <div class="data-table" style="margin-left:280px ;margin-top:-500px">
    <h5>Log Files</h5>
    <p class="text-muted">Files managed by the Admin</p>
    
    <div class="table-responsive">
      <table class="table table-hover" id="filesTable">
        <thead class="table-dark">
          <tr>
            <th>File Name</th>
            <th>Type</th>
            <th>Size</th>
            <th>Last Modified</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <!-- File data will be inserted here -->
        </tbody>
      </table>
    </div>
  </div>
</div>

  <!-- Edit Modals -->
  <div class="modal fade" id="editCustomerModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header bg-primary text-white">
          <h5 class="modal-title">Edit Customer</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body" id="editCustomerForm"></div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
          <button type="button" class="btn btn-primary" id="saveCustomerChanges">Save Changes</button>
        </div>
      </div>
    </div>
  </div>

  <!-- Product Edit Modal -->
  <div class="modal fade" id="editProductModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header bg-primary text-white">
          <h5 class="modal-title">Edit Product</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body" id="editProductForm"></div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
          <button type="button" class="btn btn-primary" id="saveProductChanges">Save Changes</button>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap 5 JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

  <!-- Custom JS -->
  <script>
      // initial data
      let customers = [
          { id: 1, name: "Thabo Mokoena", email: "thabo@yahoo.co.za", phone: "+27 678345001", location: "Johannesburg", age: 23, joinDate: "2021-01-10" },
          { id: 2, name: "Lerato Nkosi", email: "lerato@outlook.co.za", phone: "+27 723345002", location: "Cape Town", age: 31, joinDate: "2022-02-12" },
          { id: 3, name: "Sipho Dlamini", email: "sipho@icloud.co.za", phone: "+27 789345003", location: "Durban", age: 28, joinDate: "2023-03-15" },
          { id: 4, name: "Nomvula Khumalo", email: "nomvula@gmail.co.za", phone: "+27 612345004", location: "Pretoria", age: 35, joinDate: "2024-04-18" },
          { id: 5, name: "Jabulani Mthembu", email: "jabulani@live.co.za", phone: "+27 315345005", location: "Port Elizabeth", age: 41, joinDate: "2025-05-20" }
      ];

      let products = [
          { id: 1, name: "Maize Meal", customerId: 1, customerName: "Thabo Mokoena", category: "grains", quantity: 100, price: 45.50, description: "High-quality maize meal", dateAdded: "2021-01-10" },
          { id: 2, name: "Spinach", customerId: 2, customerName: "Lerato Nkosi", category: "vegetables", quantity: 50, price: 20.00, description: "Fresh local spinach", dateAdded: "2022-02-12" },
          { id: 3, name: "Apples", customerId: 3, customerName: "Sipho Dlamini", category: "fruits", quantity: 70, price: 30.00, description: "Crisp South African apples", dateAdded: "2023-03-15" },
          { id: 4, name: "Cheddar Cheese", customerId: 4, customerName: "Nomvula Khumalo", category: "dairy", quantity: 25, price: 80.00, description: "Aged cheddar cheese", dateAdded: "2024-04-18" },
          { id: 5, name: "Tomatoes", customerId: 5, customerName: "Jabulani Mthembu", category: "vegetables", quantity: 60, price: 25.00, description: "Fresh farm tomatoes", dateAdded: "2025-05-20" }
      ];

      const sidebarLinks = document.querySelectorAll('.sidebar .nav-link[data-section]');
      const sections = {
          customers: document.getElementById('customersSection'),
          products: document.getElementById('productsSection'),
          notifications: document.getElementById('notificationsSection'),
          login: document.getElementById('loginSection'),
          signup: document.getElementById('signupSection'),
          orders: document.getElementById('ordersSection'),
           fileshare: document.getElementById('fileshareSection')
      };

      // Default show customers
      Object.values(sections).forEach(s => s.classList.add('d-none'));
      sections.customers.classList.remove('d-none');

      sidebarLinks.forEach(link => {
          link.addEventListener('click', function (e) {
              e.preventDefault();
              const sectionId = this.dataset.section;

              Object.values(sections).forEach(sec => sec.classList.add('d-none'));
              sections[sectionId].classList.remove('d-none');

              sidebarLinks.forEach(l => l.classList.remove('active'));
              this.classList.add('active');
          });
      });

      // Utility: next IDs
      function nextCustomerId() {
          return customers.length ? Math.max(...customers.map(c => c.id)) + 1 : 1;
      }
      function nextProductId() {
          return products.length ? Math.max(...products.map(p => p.id)) + 1 : 1;
      }

      // Populate product customer select
      function populateProductCustomerSelect(selectElementId = 'productCustomer') {
          const select = document.getElementById(selectElementId);
          if (!select) return;
          const currentValue = select.value;
          select.innerHTML = `<option value="">Select Customer</option>`;
          customers.forEach(c => {
              const opt = document.createElement('option');
              opt.value = c.id;
              opt.textContent = `${c.name} (ID: ${c.id})`;
              select.appendChild(opt);
          });
          // try to restore previous selection if still valid
          if (currentValue) select.value = currentValue;
      }

      // Filtering helpers
      function customerMatchesFilters(customer) {
          const search = document.getElementById('customerSearch').value.trim().toLowerCase();
          const cat = document.getElementById('customerCategoryFilter').value;
          const dateFilter = document.getElementById('customerDateFilter').value; // yyyy-mm-dd

          // search across name, email, phone, location
          if (search) {
              const combined = `${customer.name} ${customer.email} ${customer.phone} ${customer.location}`.toLowerCase();
              if (!combined.includes(search)) return false;
          }

          // category by age
          if (cat) {
              if (cat === 'small' && !(customer.age >= 18 && customer.age <= 25)) return false;
              if (cat === 'medium' && !(customer.age >= 26 && customer.age <= 40)) return false;
              if (cat === 'large' && !(customer.age > 40)) return false;
          }

          // date filter
          if (dateFilter) {
              if (!customer.joinDate) return false;
              const custDate = new Date(customer.joinDate);
              const filterDate = new Date(dateFilter);
              // Only match same day
              if (custDate.toISOString().slice(0, 10) !== filterDate.toISOString().slice(0, 10)) return false;
          }

          return true;
      }

      function productMatchesFilters(product) {
          const search = document.getElementById('productSearch').value.trim().toLowerCase();
          const cat = document.getElementById('productCategoryFilter').value;
          const dateFilter = document.getElementById('productDateFilter').value;

          if (search) {
              const combined = `${product.name} ${product.customerName} ${product.category} ${product.description}`.toLowerCase();
              if (!combined.includes(search)) return false;
          }

          if (cat && product.category !== cat) return false;

          if (dateFilter) {
              if (!product.dateAdded) return false;
              const prodDate = new Date(product.dateAdded);
              const filterDate = new Date(dateFilter);
              if (prodDate.toISOString().slice(0, 10) !== filterDate.toISOString().slice(0, 10)) return false;
          }

          return true;
      }

      // Render functions attach event listeners for dynamic buttons
      function renderCustomersTable() {
          const tableBody = document.querySelector('#customersTable tbody');
          tableBody.innerHTML = '';
          customers.forEach(customer => {
              if (!customerMatchesFilters(customer)) return;
              tableBody.innerHTML += `
                  <tr>
                    <td>${customer.id}</td>
                    <td>${customer.name}</td>
                    <td>${customer.email}</td>
                    <td>${customer.phone}</td>
                    <td>${customer.location}</td>
                    <td>${customer.age}</td>
                    <td>${new Date(customer.joinDate).toLocaleDateString()}</td>
                    <td>
                      <button class="btn btn-sm btn-outline-primary edit-customer" data-id="${customer.id}">
                        <i class="fas fa-edit"></i>
                      </button>
                      <button class="btn btn-sm btn-outline-danger delete-customer" data-id="${customer.id}">
                        <i class="fas fa-trash"></i>
                      </button>
                    </td>
                  </tr>
              `;
          });

          // Attach handlers
          document.querySelectorAll('.edit-customer').forEach(btn => {
              btn.addEventListener('click', openEditCustomerModal);
          });
          document.querySelectorAll('.delete-customer').forEach(btn => {
              btn.addEventListener('click', deleteCustomer);
          });

          // Also refresh product customer select in case customers changed
          populateProductCustomerSelect();
      }

      function renderProductsTable() {
          const tableBody = document.querySelector('#productsTable tbody');
          tableBody.innerHTML = '';
          products.forEach(product => {
              if (!productMatchesFilters(product)) return;
              tableBody.innerHTML += `
  <tr>
    <td>${product.customerId}</td>
    <td>${product.id}</td>
    <td>${product.customerName}</td>
     <td>${product.name}</td>
 <td>${product.description || ''}</td>
    <td>${product.category}</td>
    <td>${product.quantity}</td>
    <td>R${product.price.toFixed(2)}</td>
    <td>${product.image ? `<img src="${product.image}" alt="Product Image" style="width:60px; height:60px; object-fit:cover;">` : ''}</td>
    <td>${new Date(product.dateAdded).toLocaleDateString()}</td>
    <td>
      <button class="btn btn-sm btn-outline-primary edit-product" data-id="${product.id}">
        <i class="fas fa-edit"></i>
      </button>
      <button class="btn btn-sm btn-outline-danger delete-product" data-id="${product.id}">
        <i class="fas fa-trash"></i>
      </button>
    </td>
  </tr>
`;

          });

          document.querySelectorAll('.edit-product').forEach(btn => {
              btn.addEventListener('click', openEditProductModal);
          });
          document.querySelectorAll('.delete-product').forEach(btn => {
              btn.addEventListener('click', deleteProduct);
          });
      }


      // Add customer
      // Add customer
      const customerForm = document.getElementById('customerForm');
      customerForm.addEventListener('submit', function (e) {
          e.preventDefault();
          const name = document.getElementById('customerName').value.trim();
          const email = document.getElementById('customerEmail').value.trim();
          const phone = document.getElementById('customerPhone').value.trim();
          const location = document.getElementById('customerLocation').value.trim();
          const age = parseInt(document.getElementById('customerAge').value, 10);
          const joinDate = document.getElementById('customerJoinDate').value;

          if (!name || !email || !phone || !location || !age || !joinDate) {
              alert('Please fill in all customer fields.');
              return;
          }

          const id = nextCustomerId();
          const newCustomer = { id, name, email, phone, location, age, joinDate };
          customers.push(newCustomer);

          // Show popup with all form entries
          const customerDetails = `
Customer Added Successfully!
-----------------------------
ID: cust_${id}
Name: ${name}
Email: ${email}
Phone: ${phone}
Location: ${location}
Age: ${age}
Join Date: ${joinDate}
-----------------------------
Customer has been added to the system.
    `;
          alert(customerDetails);

          renderCustomersTable();
          renderProductsTable(); // in case product filters rely on customers

          // Clear form
          customerForm.reset();
      });
      // Add product
      // Add product
      const productForm = document.getElementById('productForm');
      productForm.addEventListener('submit', function (e) {
          e.preventDefault();
          const name = document.getElementById('productName').value.trim();
          const customerId = parseInt(document.getElementById('productCustomer').value, 10);
          const category = document.getElementById('productCategory').value;
          const quantity = parseInt(document.getElementById('productQuantity').value, 10);
          const price = parseFloat(document.getElementById('productPrice').value);
          const description = document.getElementById('productDescription').value.trim();
          const dateAdded = document.getElementById('productDate').value;
          const imageFile = document.getElementById('productImage').files[0];

          if (!name || !customerId || !category || !quantity || isNaN(price) || !dateAdded) {
              alert('Please fill in all required product fields.');
              return;
          }

          let imageUrl = "";
          if (imageFile) {
              imageUrl = URL.createObjectURL(imageFile);
          }

          const customer = customers.find(c => c.id === customerId);
          const customerName = customer ? customer.name : 'Unknown';

          const id = nextProductId();

          const newProduct = {
              id,
              name,
              customerId,
              customerName,
              category,
              quantity,
              price,
              description,
              dateAdded,
              image: imageUrl
          };

          products.push(newProduct);

          // Show popup with all form entries
          const productDetails = `
Product Added Successfully!
-----------------------------
Customer ID: cust_${customerId}
Product ID: prod_${id}
Customer: ${customerName} (ID: ${customerId})
Name: ${name}
Description: ${description || 'N/A'}
Category: ${category}
Quantity: ${quantity}
Price: R${price.toFixed(2)}
Date Added: ${dateAdded}
Image: ${imageFile ? imageFile.name : 'No image uploaded'}
-----------------------------
Product has been added to the inventory.
    `;
          alert(productDetails);

          renderProductsTable();
          productForm.reset();
      });
      // Delete customer (also remove associated products)
      function deleteCustomer(e) {
          const id = parseInt(e.currentTarget.dataset.id, 10);
          const idx = customers.findIndex(c => c.id === id);
          if (idx === -1) return;
          const removed = customers.splice(idx, 1)[0];

          // Remove products belonging to this customer
          const removedProducts = products.filter(p => p.customerId === id).map(p => p.id);
          products = products.filter(p => p.customerId !== id);

          renderCustomersTable();
          renderProductsTable();

          let msg = `cust_${removed.id} (${removed.name}) deleted.`;
          if (removedProducts.length) {
              msg += ` Also removed products: ${removedProducts.map(i => 'prod_' + i).join(', ')}.`;
          }
          alert(msg);
      }

      // Delete product
      function deleteProduct(e) {
          const id = parseInt(e.currentTarget.dataset.id, 10);
          const idx = products.findIndex(p => p.id === id);
          if (idx === -1) return;
          const removed = products.splice(idx, 1)[0];
          renderProductsTable();
          alert(`prod_${removed.id} (${removed.name}) deleted.`);
      }

      // Edit customer modal logic
      const editCustomerModalEl = document.getElementById('editCustomerModal');
      const editCustomerModal = new bootstrap.Modal(editCustomerModalEl, { keyboard: true });
      function openEditCustomerModal(e) {
          const id = parseInt(e.currentTarget.dataset.id, 10);
          const customer = customers.find(c => c.id === id);
          if (!customer) return;

          const formHtml = `
            <form id="editCustomerInnerForm">
              <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" id="editCustomerName" class="form-control" value="${escapeHtml(customer.name)}">
              </div>
              <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" id="editCustomerEmail" class="form-control" value="${escapeHtml(customer.email)}">
              </div>
              <div class="mb-3">
                <label class="form-label">Phone</label>
                <input type="tel" id="editCustomerPhone" class="form-control" value="${escapeHtml(customer.phone)}">
              </div>
              <div class="mb-3">
                <label class="form-label">Location</label>
                <input type="text" id="editCustomerLocation" class="form-control" value="${escapeHtml(customer.location)}">
              </div>
              <div class="mb-3">
                <label class="form-label">Age</label>
                <input type="number" id="editCustomerAge" class="form-control" value="${customer.age}">
              </div>
              <div class="mb-3">
                <label class="form-label">Join Date</label>
                <input type="date" id="editCustomerJoinDate" class="form-control" value="${customer.joinDate}">
              </div>
            </form>
          `;
          document.getElementById('editCustomerForm').innerHTML = formHtml;
          // attach id to save button via dataset
          document.getElementById('saveCustomerChanges').dataset.id = id;
          editCustomerModal.show();
      }

      // Save customer changes
      document.getElementById('saveCustomerChanges').addEventListener('click', function () {
          const id = parseInt(this.dataset.id, 10);
          const customer = customers.find(c => c.id === id);
          if (!customer) return;

          const name = document.getElementById('editCustomerName').value.trim();
          const email = document.getElementById('editCustomerEmail').value.trim();
          const phone = document.getElementById('editCustomerPhone').value.trim();
          const location = document.getElementById('editCustomerLocation').value.trim();
          const age = parseInt(document.getElementById('editCustomerAge').value, 10);
          const joinDate = document.getElementById('editCustomerJoinDate').value;

          if (!name || !email || !phone || !location || isNaN(age) || !joinDate) {
              alert('Please fill in all customer fields.');
              return;
          }

          // update
          customer.name = name;
          customer.email = email;
          customer.phone = phone;
          customer.location = location;
          customer.age = age;
          customer.joinDate = joinDate;

          // update products that referenced this customer's name
          products.forEach(p => {
              if (p.customerId === id) p.customerName = name;
          });

          renderCustomersTable();
          renderProductsTable();
          editCustomerModal.hide();
          alert(`cust_${id} (${name}) updated successfully.`);
      });

      // Edit product modal logic
      const editProductModalEl = document.getElementById('editProductModal');
      const editProductModal = new bootstrap.Modal(editProductModalEl, { keyboard: true });
      function openEditProductModal(e) {
          const id = parseInt(e.currentTarget.dataset.id, 10);
          const product = products.find(p => p.id === id);
          if (!product) return;

          // build customer select options
          let customerOptions = `<option value="">Select Customer</option>`;
          customers.forEach(c => {
              const sel = c.id === product.customerId ? 'selected' : '';
              customerOptions += `<option value="${c.id}" ${sel}>${escapeHtml(c.name)} (ID: ${c.id})</option>`;
          });

          const formHtml = `
            <form id="editProductInnerForm">
              <div class="mb-3">
                <label class="form-label">Product Name</label>
                <input type="text" id="editProductName" class="form-control" value="${escapeHtml(product.name)}">
              </div>
              <div class="mb-3">
                <label class="form-label">Customer</label>
                <select id="editProductCustomer" class="form-select">${customerOptions}</select>
              </div>
              <div class="mb-3">
                <label class="form-label">Category</label>
                <select id="editProductCategory" class="form-select">
                  <option value="">Select Category</option>
                  <option value="vegetables" ${product.category === 'vegetables' ? 'selected' : ''}>Vegetables</option>
                  <option value="fruits" ${product.category === 'fruits' ? 'selected' : ''}>Fruits</option>
                  <option value="grains" ${product.category === 'grains' ? 'selected' : ''}>Grains</option>
                  <option value="dairy" ${product.category === 'dairy' ? 'selected' : ''}>Dairy</option>
                  <option value="beverages" ${product.category === 'beverages' ? 'selected' : ''}>Beverages</option>
                  <option value="snacks" ${product.category === 'snacks' ? 'selected' : ''}>Snacks &amp; Chips</option>
                  <option value="bakery" ${product.category === 'bakery' ? 'selected' : ''}>Bakery</option>
                  <option value="frozen" ${product.category === 'frozen' ? 'selected' : ''}>Frozen Foods</option>
                  <option value="meat" ${product.category === 'meat' ? 'selected' : ''}>Meat</option>

                </select>
              </div>
              <div class="row">
                <div class="col mb-3">
                  <label class="form-label">Quantity</label>
                  <input type="number" id="editProductQuantity" class="form-control" value="${product.quantity}">
                </div>
                <div class="col mb-3">
                  <label class="form-label">Price (R)</label>
                  <input type="number" step="0.01" id="editProductPrice" class="form-control" value="${product.price}">
                </div>
              </div>
              <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea id="editProductDescription" class="form-control" rows="3">${escapeHtml(product.description)}</textarea>
              </div>
            </form>
          `;
          document.getElementById('editProductForm').innerHTML = formHtml;
          document.getElementById('saveProductChanges').dataset.id = id;
          editProductModal.show();
      }

      // Save product changes
      document.getElementById('saveProductChanges').addEventListener('click', function () {
          const id = parseInt(this.dataset.id, 10);
          const product = products.find(p => p.id === id);
          if (!product) return;

          const name = document.getElementById('editProductName').value.trim();
          const customerId = parseInt(document.getElementById('editProductCustomer').value, 10);
          const category = document.getElementById('editProductCategory').value;
          const quantity = parseInt(document.getElementById('editProductQuantity').value, 10);
          const price = parseFloat(document.getElementById('editProductPrice').value);
          const description = document.getElementById('editProductDescription').value.trim();

          if (!name || !customerId || !category || isNaN(quantity) || isNaN(price)) {
              alert('Please fill in all required product fields.');
              return;
          }

          const customer = customers.find(c => c.id === customerId);
          const customerName = customer ? customer.name : 'Unknown';

          product.name = name;
          product.customerId = customerId;
          product.customerName = customerName;
          product.category = category;
          product.quantity = quantity;
          product.price = price;
          product.description = description;

          renderProductsTable();
          editProductModal.hide();
          alert(`prod_${id} (${name}) updated successfully. Customer: ${customerName}`);
      });

      // Reset search/filter buttons
      document.getElementById('resetCustomerSearch').addEventListener('click', function () {
          document.getElementById('customerSearch').value = '';
          document.getElementById('customerCategoryFilter').value = '';
          document.getElementById('customerDateFilter').value = '';
          renderCustomersTable();
      });

      document.getElementById('resetProductSearch').addEventListener('click', function () {
          document.getElementById('productSearch').value = '';
          document.getElementById('productCategoryFilter').value = '';
          document.getElementById('productDateFilter').value = '';
          renderProductsTable();
      });

      // Live filtering (re-render on input)
      document.getElementById('customerSearch').addEventListener('input', renderCustomersTable);
      document.getElementById('customerCategoryFilter').addEventListener('change', renderCustomersTable);
      document.getElementById('customerDateFilter').addEventListener('change', renderCustomersTable);

      document.getElementById('productSearch').addEventListener('input', renderProductsTable);
      document.getElementById('productCategoryFilter').addEventListener('change', renderProductsTable);
      document.getElementById('productDateFilter').addEventListener('change', renderProductsTable);

      // Escape helper to prevent markup issues when inserting into innerHTML
      function escapeHtml(text) {
          if (text === null || text === undefined) return '';
          return text.toString()
              .replace(/&/g, '&amp;')
              .replace(/</g, '&lt;')
              .replace(/>/g, '&gt;')
              .replace(/"/g, '&quot;')
              .replace(/'/g, '&#039;');
      }

      // Initial population
      populateProductCustomerSelect();
      renderCustomersTable();
      renderProductsTable();
      // File Share Data
      const logFiles = [
          {
              id: 1,
              name: "product_price_update_batch_20250822.log.txt",
              content: `{\n  "batchId": "PRICE-UPDATE-20250821-01",\n  "timestamp": "2025-08-21T02:00:00Z",\n  "updates": [\n    {\n      "productId": "PROD-1",\n      "productName": "Whole Wheat Bread",\n      "currentPrice": 45.50,\n      "newPrice": 50.00,\n      "reason": "Supplier cost increase"\n    },\n    {\n      "productId": "PROD-6",\n      "productName": "2L Full Cream Milk",\n      "currentPrice": 32.00,\n      "newPrice": 35.00,\n      "reason": "Price hold"\n    }\n  ]\n}`,
              type: "Price Update Log",
              size: "1.2 KB",
              lastModified: "2025-08-22 08:30:45"
          },
          {
              id: 2,
              name: "system_errors_20250821.log.txt",
              content: "WARN 2025-08-21 10:30:15 - Blob container 'product-images' connection latency above threshold (450ms).\nERROR 2025-08-21 10:05:55 - Exception in InventoryManagementAPI: System.ArgumentNullException: Value cannot be null. (Parameter 'productId')\nERROR 2025-08-21 10:05:55 - at InventoryService.CheckStock(String productId) in...\nINFO 2025-08-21 10:05:58 - Error report generated and sent to online grocerystore@gmail.co.za.",
              type: "Error Log",
              size: "0.8 KB",
              lastModified: "2025-08-21 14:22:10"
          },
          {
              id: 3,
              name: "product_description_20250821.log.txt",
              content: "[2025-08-21 10:45:32] INFO  - Product description created successfully.\nProduct ID: 3\nProduct Name: Apple\nImage File: apples.jpg\nDescription: Fresh red apples rich in fiber and vitamins.\nDate Added: 2025-08-21\nCreated By: Sipho Dlamini",
              type: "Product Log",
              size: "0.5 KB",
              lastModified: "2025-08-21 11:15:30"
          },
          {
              id: 4,
              name: "daily_orders_20250821.log.txt",
              content: "INFO 2025-08-21 08:15:34Z - Order ORD-564321 for customer thabo@yahoo.co.za successfully processed. Items: 1. Total: R45,50.\nINFO 2025-08-21 09:22:11Z - Order ORD-878012 for customer lerato@outlook.co.za placed. Payment status: Pending.\nERROR 2025-08-21 10:05:55Z - Inventory check failed for Product ID: PROD-6 (Milk). Stock level: 0.\nINFO 2025-08-21 10:06:01Z - Notification sent to team for Product ID: PROD-1.\nINFO 2025-08-21 12:30:45Z - Order ORD-234567 details captured.",
              type: "Order Log",
              size: "1.5 KB",
              lastModified: "2025-08-21 16:45:22"
          },
          {
              id: 5,
              name: "user_activity_20250818.log.txt",
              content: "INFO 2025-08-20 14:22:10Z - User: thabo@yahoo.co.za logged in successfuly: PROD-10125 (2L Full Cream Milk).\nINFO 2024-08-20 14:25:33Z - User: thabo@yahoo.co.za added product: PROD-10125 to cart.\nINFO 2024-10-27 14:30:01Z - User: thabo@yahoo.co.za added 2 more products in. Session ID: SESS-789abc456.\nINFO 2024-10-27 15:17:08Z - User: thabo@yahoo.co.za performed search for: \"meat\".",
              type: "User Activity Log",
              size: "1.0 KB",
              lastModified: "2025-08-18 09:12:05"
          }
      ];

      // Add fileshare section to sections object
      sections.fileshare = document.getElementById('fileshareSection');

      // Function to render files table
      function renderFilesTable() {
          const tableBody = document.querySelector('#filesTable tbody');
          tableBody.innerHTML = '';

          logFiles.forEach(file => {
              tableBody.innerHTML += `
      <tr>
        <td>${file.name}</td>
        <td><span class="badge bg-info">${file.type}</span></td>
        <td>${file.size}</td>
        <td>${file.lastModified}</td>
        <td>
          <button class="btn btn-sm btn-outline-primary view-file" data-id="${file.id}">
            <i class="fas fa-eye"></i> View
          </button>
          <button class="btn btn-sm btn-outline-success download-file" data-id="${file.id}">
            <i class="fas fa-download"></i> Download
          </button>
          <button class="btn btn-sm btn-outline-danger delete-file" data-id="${file.id}">
            <i class="fas fa-trash"></i> Delete
          </button>
        </td>
      </tr>
    `;
          });

          // Attach event handlers
          document.querySelectorAll('.view-file').forEach(btn => {
              btn.addEventListener('click', viewFile);
          });

          document.querySelectorAll('.download-file').forEach(btn => {
              btn.addEventListener('click', downloadFile);
          });

          document.querySelectorAll('.delete-file').forEach(btn => {
              btn.addEventListener('click', deleteFile);
          });
      }

      // View file content
      function viewFile(e) {
          const id = parseInt(e.currentTarget.dataset.id, 10);
          const file = logFiles.find(f => f.id === id);
          if (!file) return;

          // Create a modal to display file content
          const modalHtml = `
    <div class="modal fade" id="fileViewModal" tabindex="-1">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header bg-primary text-white">
            <h5 class="modal-title">${file.name}</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <pre class="bg-light p-3" style="max-height: 400px; overflow: auto;">${escapeHtml(file.content)}</pre>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary" onclick="downloadFileById(${id})">
              <i class="fas fa-download"></i> Download
            </button>
          </div>
        </div>
      </div>
    </div>
  `;

          // Remove existing modal if any
          const existingModal = document.getElementById('fileViewModal');
          if (existingModal) {
              existingModal.remove();
          }

          // Add modal to DOM and show it
          document.body.insertAdjacentHTML('beforeend', modalHtml);
          const modal = new bootstrap.Modal(document.getElementById('fileViewModal'));
          modal.show();
      }

      // Download file
      function downloadFile(e) {
          const id = parseInt(e.currentTarget.dataset.id, 10);
          downloadFileById(id);
      }

      // Download file by ID
      function downloadFileById(id) {
          const file = logFiles.find(f => f.id === id);
          if (!file) return;

          const blob = new Blob([file.content], { type: 'text/plain' });
          const url = URL.createObjectURL(blob);
          const a = document.createElement('a');
          a.href = url;
          a.download = file.name;
          document.body.appendChild(a);
          a.click();
          document.body.removeChild(a);
          URL.revokeObjectURL(url);

          alert(`File "${file.name}" downloaded successfully.`);
      }

      // Delete file
      function deleteFile(e) {
          const id = parseInt(e.currentTarget.dataset.id, 10);
          const fileIndex = logFiles.findIndex(f => f.id === id);

          if (fileIndex === -1) return;

          if (confirm(`Are you sure you want to delete "${logFiles[fileIndex].name}"?`)) {
              const deletedFile = logFiles.splice(fileIndex, 1)[0];
              renderFilesTable();
              alert(`File "${deletedFile.name}" has been deleted.`);
          }
      }

      // Initialize file share section
      renderFilesTable();
  </script>
</body>
</html>