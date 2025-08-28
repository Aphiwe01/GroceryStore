<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Customer.aspx.cs" Inherits="GroceryStore.Customer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Online Grocery Store</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --bg-dark: #1a2131;
            --btn-primary: #2869ff;
            --text-light: #ffffff;
            --card-bg: #2a3447;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-dark);
            color: var(--text-light);
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
            background-color: #f5f5f5;
            min-height: 100vh;
        }
        /* Cards */
        .product-card {
            background: var(--card-bg);
            border: none;
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.3s;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            color: var(--text-light);
        }
        .product-card:hover {
            transform: translateY(-5px);
        }
        .product-card .card-img-top {
            height: 150px;
            object-fit: cover;
        }
        .product-card .category-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: var(--btn-primary);
        }
        /* Buttons */
        .btn-primary {
            background-color: var(--btn-primary);
            border: none;
        }
        .btn-outline-primary {
            color: var(--btn-primary);
            border-color: var(--btn-primary);
        }
        .btn-outline-primary:hover {
            background-color: var(--btn-primary);
        }
        /* Responsive Adjustments */
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
        /* Image preview */
        #imagePreview {
            max-width: 100%;
            max-height: 200px;
            margin-top: 10px;
            display: none;
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
      <li class="nav-item">
        <a class="nav-link active" href="#" data-section="products">
          <i class="fas fa-box-open"></i> My Products
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#addProductModal">
          <i class="fas fa-plus-circle"></i> Add Product
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
    <!-- Products Section (Default) -->
    <div id="productsSection">
      <div class="d-flex justify-content-between align-items-center mb-4">
        <button class="btn btn-dark d-md-none" id="sidebarToggle">
          <i class="fas fa-bars"></i>
        </button>
        <h3 class="mb-0 text-dark">My Products</h3>
        <div class="d-flex">
          <div class="input-group me-2" style="width: 250px;">
            <input type="text" class="form-control" placeholder="Search products..." id="searchInput">
            <button class="btn btn-primary" type="button">
              <i class="fas fa-search"></i>
            </button>
          </div>
          <div class="dropdown me-2">
            <button class="btn btn-secondary dropdown-toggle" type="button" id="categoryFilter" data-bs-toggle="dropdown">
              <i class="fas fa-filter"></i> Category
            </button>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#" data-filter="all">All Categories</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" href="#" data-filter="vegetables">Vegetables</a></li>
              <li><a class="dropdown-item" href="#" data-filter="fruits">Fruits</a></li>
              <li><a class="dropdown-item" href="#" data-filter="grains">Grains</a></li>
              <li><a class="dropdown-item" href="#" data-filter="dairy">Dairy</a></li>
              <li><a class="dropdown-item" href="#" data-filter="poultry">Poultry</a></li>
                <li><a class="dropdown-item" href="#" data-filter="beverages">Beverages</a></li>
            <li><a class="dropdown-item" href="#" data-filter="snacks">Snacks &amp; Chips</a></li>
            <li><a class="dropdown-item" href="#" data-filter="bakery">Bakery</a></li>
            <li><a class="dropdown-item" href="#" data-filter="frozen">Frozen Foods</a></li>
            <li><a class="dropdown-item" href="#" data-filter="meat">Meat</a></li>

            </ul>
          </div>
        </div>
      </div>

      <div class="row" id="productContainer">
        <!-- Product cards will be dynamically inserted here -->
      </div>
    </div>
  </div>

  <!-- Add/Edit Product Modal -->
  <div class="modal fade" id="productModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header bg-primary text-white">
          <h5 class="modal-title" id="modalTitle">Add New Product</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form id="productForm">
            <input type="hidden" id="productId">
            <div class="mb-3">
              <label for="productName" class="form-label" style="color: black;">Product Name *</label>
              <input type="text" class="form-control" id="productName" required>
            </div>
            <div class="mb-3">
              <label for="productDescription" class="form-label" style="color: black;">Description</label>
              <textarea class="form-control" id="productDescription" rows="2"></textarea>
            </div>
            <div class="mb-3">
              <label for="productCategory" class="form-label" style="color: black;">Category *</label>
              <select class="form-select" id="productCategory" required>
                <option value="">Select category</option>
                <option value="vegetables">Vegetables</option>
                <option value="fruits">Fruits</option>
                <option value="grains">Grains</option>
                <option value="dairy">Dairy</option>
                <option value="poultry">Poultry</option>
                <option value="beverages">Beverages</option>
                <option value="snacks">Snacks & Chips</option>
                <option value="bakery">Bakery</option>
                <option value="frozen">Frozen Foods</option>
                <option value="meat">Meat</option>
              </select>
            </div>
            <div class="mb-3">
              <label for="productionDate" class="form-label" style="color: black;">Production Date</label>
              <input type="date" class="form-control" id="productionDate" required>
            </div>
            <div class="mb-3">
              <label for="productQuantity" class="form-label" style="color: black;">Quantity</label>
              <input type="number" class="form-control" id="productQuantity" min="1" required>
            </div>
            <div class="mb-3">
              <label for="productImage" class="form-label" style="color: black;">Product Image</label>
              <input type="file" class="form-control" id="productImage" accept="image/*">
              <img id="imagePreview" src="#" alt="Image Preview" class="img-thumbnail">
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
          <button type="button" class="btn btn-primary" id="saveProduct">Save Product</button>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap 5 JS Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <!-- Custom JS -->
  <script>
      // Sample Product Data
      let products = [
          {
              id: 1,
              name: "Organic Tomatoes",
              description: "Fresh organic tomatoes harvested daily",
              category: "vegetables",
              date: "2025-05-01",
              quantity: 50,
              image: "https://images.unsplash.com/photo-1467020323552-36f7bf0e30e6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8dG9tYXRvZXN8ZW58MHx8MHx8fDA%3D"
          },
          {
              id: 2,
              name: "Avocados",
              description: "Premium Hass avocados",
              category: "fruits",
              date: "2025-05-05",
              quantity: 30,
              image: "https://images.unsplash.com/photo-1601039641847-7857b994d704?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8YXZvY2Fkb3xlbnwwfHwwfHx8MA%3D%3D"
          },
          {
              id: 3,
              name: "Maize",
              description: "High-quality maize grain",
              category: "grains",
              date: "2025-04-20",
              quantity: 200,
              image: "https://images.unsplash.com/photo-1511817354854-e361703ac368?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Y29ybnxlbnwwfHwwfHx8MA%3D%3D"
          }
      ];

      // DOM Elements
      const productContainer = document.getElementById('productContainer');
      const searchInput = document.getElementById('searchInput');
      const saveProductBtn = document.getElementById('saveProduct');
      const sidebarToggle = document.getElementById('sidebarToggle');
      const sidebar = document.getElementById('sidebar');
      const productForm = document.getElementById('productForm');
      const productImageInput = document.getElementById('productImage');
      const imagePreview = document.getElementById('imagePreview');
      let selectedImage = null;

      // Initialize
      displayProducts(products);

      // Display Products
      function displayProducts(productsToShow) {
          productContainer.innerHTML = '';
          productsToShow.forEach(product => {
              productContainer.innerHTML += `
          <div class="col-md-4 mb-4" data-id="${product.id}" data-category="${product.category}" data-date="${product.date}">
            <div class="card product-card h-100">
              <img src="${product.image}" class="card-img-top" alt="${product.name}">
              <span class="badge category-badge">${product.category.charAt(0).toUpperCase() + product.category.slice(1)}</span>
              <div class="card-body">
                <h5 class="card-title">${product.name}</h5>
                <p class="card-text">${product.description}</p>
                <p class="card-text">
                  <i class="fas fa-calendar-alt me-2"></i> ${new Date(product.date).toLocaleDateString()}<br>
                  <i class="fas fa-weight me-2"></i> ${product.quantity} 
                </p>
              </div>
              <div class="card-footer bg-transparent">
                <button class="btn btn-sm btn-outline-primary me-2 edit-btn">Edit</button>
                <button class="btn btn-sm btn-outline-danger delete-btn">Delete</button>
              </div>
            </div>
          </div>
        `;
          });

          // Add event listeners to new buttons
          document.querySelectorAll('.edit-btn').forEach(btn => {
              btn.addEventListener('click', function () {
                  const productId = parseInt(this.closest('.col-md-4').dataset.id);
                  editProduct(productId);
              });
          });

          document.querySelectorAll('.delete-btn').forEach(btn => {
              btn.addEventListener('click', function () {
                  const productId = parseInt(this.closest('.col-md-4').dataset.id);
                  deleteProduct(productId);
              });
          });
      }

      // Filter Products
      function filterProducts() {
          const searchTerm = searchInput.value.toLowerCase();
          const categoryFilter = document.querySelector('[data-filter].active')?.dataset.filter || 'all';
          const dateFilter = document.querySelector('[data-date].active')?.dataset.date || 'all';

          const filteredProducts = products.filter(product => {
              // Search filter
              const matchesSearch = product.name.toLowerCase().includes(searchTerm) ||
                  product.description.toLowerCase().includes(searchTerm);

              // Category filter
              const matchesCategory = categoryFilter === 'all' || product.category === categoryFilter;

              // Date filter
              const productDate = new Date(product.date);
              const today = new Date();
              today.setHours(0, 0, 0, 0);

              let matchesDate = true;
              if (dateFilter !== 'all') {
                  if (dateFilter === 'today') {
                      matchesDate = productDate.toDateString() === today.toDateString();
                  } else if (dateFilter === 'week') {
                      const weekAgo = new Date(today);
                      weekAgo.setDate(weekAgo.getDate() - 7);
                      matchesDate = productDate >= weekAgo && productDate <= today;
                  } else if (dateFilter === 'month') {
                      const monthAgo = new Date(today);
                      monthAgo.setMonth(monthAgo.getMonth() - 1);
                      matchesDate = productDate >= monthAgo && productDate <= today;
                  }
              }

              return matchesSearch && matchesCategory && matchesDate;
          });

          displayProducts(filteredProducts);
      }

      // Add New Product
      function addProduct() {
          const modal = document.getElementById('productModal');
          const modalTitle = document.getElementById('modalTitle');
          const productIdInput = document.getElementById('productId');

          // Reset form
          productForm.reset();
          productIdInput.value = '';
          modalTitle.textContent = 'Add New Product';
          imagePreview.style.display = 'none';
          selectedImage = null;

          // Show modal
          new bootstrap.Modal(modal).show();
      }

      // Edit Product
      function editProduct(id) {
          const product = products.find(p => p.id === id);
          if (!product) return;

          const modal = document.getElementById('productModal');
          const modalTitle = document.getElementById('modalTitle');
          const productIdInput = document.getElementById('productId');

          // Fill form
          document.getElementById('productName').value = product.name;
          document.getElementById('productDescription').value = product.description;
          document.getElementById('productCategory').value = product.category;
          document.getElementById('productionDate').value = product.date;
          document.getElementById('productQuantity').value = product.quantity;
          productIdInput.value = product.id;

          // Set image preview
          imagePreview.src = product.image;
          imagePreview.style.display = 'block';
          selectedImage = product.image;

          // Update modal title
          modalTitle.textContent = 'Edit Product';

          // Show modal
          new bootstrap.Modal(modal).show();
      }

      // Delete Product
      function deleteProduct(id) {
          if (confirm('Are you sure you want to delete this product?')) {
              products = products.filter(p => p.id !== id);
              displayProducts(products);
          }
      }

      // Save Product (Add/Edit)
      function saveProduct() {
          // Validate form
          if (!productForm.checkValidity()) {
              productForm.classList.add('was-validated');
              return;
          }

          const id = document.getElementById('productId').value;
          const productName = document.getElementById('productName').value;
          const productDescription = document.getElementById('productDescription').value;
          const productCategory = document.getElementById('productCategory').value;
          const productionDate = document.getElementById('productionDate').value;
          const productQuantity = document.getElementById('productQuantity').value;

          const productData = {
              name: productName,
              description: productDescription,
              category: productCategory,
              date: productionDate,
              quantity: parseInt(productQuantity),
              image: selectedImage || "https://source.unsplash.com/random/300x200/?" + productCategory
          };

          if (id) {
              // Update existing product
              const index = products.findIndex(p => p.id === parseInt(id));
              if (index !== -1) {
                  products[index] = { ...products[index], ...productData };
              }
          } else {
              // Add new product
              const newId = products.length > 0 ? Math.max(...products.map(p => p.id)) + 1 : 1;
              products.push({ id: newId, ...productData });
          }

          // Update UI
          displayProducts(products);

          // Hide modal
          bootstrap.Modal.getInstance(document.getElementById('productModal')).hide();

          // Reset form
          productForm.reset();
          productForm.classList.remove('was-validated');

          // ✅ Show pop-up message with user entries
          const message =
              `PROD_6 ,Aphiwe Ngobese\n\n` +
              `Product Name: ${productName}\n` +
              `Description: ${productDescription}\n` +
              `Category: ${productCategory}\n` +
              `Production Date: ${productionDate}\n` +
              `Quantity: ${productQuantity}\n\n` +
              `(Thank you for your order!)`;

          alert(message);
      }
      // Image Preview Functionality
      productImageInput.addEventListener('change', function () {
          const file = this.files[0];
          if (file) {
              const reader = new FileReader();
              reader.onload = function (e) {
                  imagePreview.src = e.target.result;
                  imagePreview.style.display = 'block';
                  selectedImage = e.target.result;
              }
              reader.readAsDataURL(file);
          }
      });

      // Event Listeners
      document.getElementById('sidebarToggle').addEventListener('click', function () {
          sidebar.classList.toggle('active');
      });

      document.querySelector('[data-bs-target="#addProductModal"]').addEventListener('click', addProduct);

      document.getElementById('saveProduct').addEventListener('click', saveProduct);

      searchInput.addEventListener('input', filterProducts);

      document.querySelectorAll('[data-filter]').forEach(link => {
          link.addEventListener('click', function (e) {
              e.preventDefault();
              document.querySelectorAll('[data-filter]').forEach(l => l.classList.remove('active'));
              this.classList.add('active');
              filterProducts();
          });
      });
  </script>
</body>
</html>