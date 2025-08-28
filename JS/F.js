  
    // Sample Product Data
    let products = [
      { 
        id: 1, 
        name: "Organic Tomatoes", 
        description: "Fresh organic tomatoes harvested daily",
        category: "vegetables", 
        date: "2025-05-01", 
        quantity: 50, 
        image: "data:image/jpeg;base64,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" 
      },
      { 
        id: 2, 
        name: "Avocados", 
        description: "Premium Hass avocados",
        category: "fruits", 
        date: "2025-05-05", 
        quantity: 30, 
        image: "https://source.unsplash.com/random/300x200/?avocado" 
      },
      { 
        id: 3, 
        name: "Maize", 
        description: "High-quality maize grain",
        category: "grains", 
        date: "2025-04-20", 
        quantity: 200, 
        image: "https://source.unsplash.com/random/300x200/?corn" 
      }
    ];

    // Farmer Profile Data
    let farmerProfile = {
      name: "John Farmer",
      email: "john.farmer@example.com",
      phone: "+254 700 000 000",
      location: "Nairobi, Kenya",
      farmSize: 10
    };

    // DOM Elements
    const productContainer = document.getElementById('productContainer');
    const searchInput = document.getElementById('searchInput');
    const saveProductBtn = document.getElementById('saveProduct');
    const sidebarToggle = document.getElementById('sidebarToggle');
    const sidebar = document.getElementById('sidebar');
    const productForm = document.getElementById('productForm');
    const profileForm = document.getElementById('profileForm');
    const navLinks = document.querySelectorAll('.nav-link[data-section]');
    const sections = {
      dashboard: document.getElementById('dashboardSection'),
      products: document.getElementById('productsSection'),
      profile: document.getElementById('profileSection')
    };
    const totalProductsEl = document.getElementById('totalProducts');
    const activeProductsEl = document.getElementById('activeProducts');

    // Initialize
    displayProducts(products);
    updateDashboardStats();
    loadProfileData();

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
                  <i class="fas fa-weight me-2"></i> ${product.quantity} kg
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
        btn.addEventListener('click', function() {
          const productId = parseInt(this.closest('.col-md-4').dataset.id);
          editProduct(productId);
        });
      });

      document.querySelectorAll('.delete-btn').forEach(btn => {
        btn.addEventListener('click', function() {
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
        updateDashboardStats();
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
      const productData = {
        name: document.getElementById('productName').value,
        description: document.getElementById('productDescription').value,
        category: document.getElementById('productCategory').value,
        date: document.getElementById('productionDate').value,
        quantity: parseInt(document.getElementById('productQuantity').value),
        image: "https://source.unsplash.com/random/300x200/?" + document.getElementById('productCategory').value
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
      updateDashboardStats();
      
      // Hide modal
      bootstrap.Modal.getInstance(document.getElementById('productModal')).hide();
      
      // Reset form
      productForm.reset();
      productForm.classList.remove('was-validated');
    }

    // Update Dashboard Stats
    function updateDashboardStats() {
      totalProductsEl.textContent = products.length;
      activeProductsEl.textContent = products.filter(p => {
        const productDate = new Date(p.date);
        const today = new Date();
        return productDate >= new Date(today.setDate(today.getDate() - 30));
      }).length;
    }

    // Load Profile Data
    function loadProfileData() {
      document.getElementById('name').value = farmerProfile.name;
      document.getElementById('email').value = farmerProfile.email;
      document.getElementById('phone').value = farmerProfile.phone;
      document.getElementById('location').value = farmerProfile.location;
      document.getElementById('farmSize').value = farmerProfile.farmSize;
    }

    // Save Profile Data
    function saveProfile() {
      farmerProfile = {
        name: document.getElementById('name').value,
        email: document.getElementById('email').value,
        phone: document.getElementById('phone').value,
        location: document.getElementById('location').value,
        farmSize: parseInt(document.getElementById('farmSize').value)
      };
      alert('Profile updated successfully!');
    }

    // Switch Sections
    function switchSection(sectionId) {
      // Hide all sections
      Object.values(sections).forEach(section => {
        section.classList.add('d-none');
      });
      
      // Show selected section
      sections[sectionId].classList.remove('d-none');
      
      // Update active nav link
      navLinks.forEach(link => {
        link.classList.remove('active');
        if (link.dataset.section === sectionId) {
          link.classList.add('active');
        }
      });
    }

    // Event Listeners
    document.getElementById('sidebarToggle').addEventListener('click', function() {
      sidebar.classList.toggle('active');
    });

    document.querySelector('[data-bs-target="#addProductModal"]').addEventListener('click', addProduct);

    document.getElementById('saveProduct').addEventListener('click', saveProduct);

    searchInput.addEventListener('input', filterProducts);

    document.querySelectorAll('[data-filter]').forEach(link => {
      link.addEventListener('click', function(e) {
        e.preventDefault();
        document.querySelectorAll('[data-filter]').forEach(l => l.classList.remove('active'));
        this.classList.add('active');
        filterProducts();
      });
    });

    document.querySelectorAll('[data-date]').forEach(link => {
      link.addEventListener('click', function(e) {
        e.preventDefault();
        document.querySelectorAll('[data-date]').forEach(l => l.classList.remove('active'));
        this.classList.add('active');
        filterProducts();
      });
    });

    navLinks.forEach(link => {
      link.addEventListener('click', function(e) {
        e.preventDefault();
        switchSection(this.dataset.section);
      });
    });

    profileForm.addEventListener('submit', function(e) {
      e.preventDefault();
      saveProfile();
    });

    // Initialize with dashboard section
    switchSection('dashboard');

    // Add this JavaScript to handle the dashboard functionality
  document.addEventListener('DOMContentLoaded', function() {
    // Initialize dashboard products data
    const dashboardProducts = [
      { 
        id: 1, 
        name: "Organic Tomatoes", 
        description: "Fresh organic tomatoes harvested daily",
        category: "vegetables", 
        date: "2025-05-01", 
        quantity: 50, 
        price: "KSh 120/kg",
        status: "active",
        image: "https://images.unsplash.com/photo-1518977676601-b53f82aba655?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" 
      },
      { 
        id: 2, 
        name: "Hass Avocados", 
        description: "Premium Hass avocados",
        category: "fruits", 
        date: "2025-05-05", 
        quantity: 100, 
        price: "KSh 50/piece",
        status: "active",
        image: "https://images.unsplash.com/photo-1550258987-190a2d41a8ba?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80" 
      },
      { 
        id: 3, 
        name: "Free-range Eggs", 
        description: "Organic free-range eggs",
        category: "poultry", 
        date: "2025-04-28", 
        quantity: 30, 
        price: "KSh 350/tray",
        status: "low",
        image: "https://images.unsplash.com/photo-1601493700631-2b16ec4b4716?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=735&q=80" 
      },
      { 
        id: 4, 
        name: "Organic Maize", 
        description: "High-quality maize grain",
        category: "grains", 
        date: "2025-04-20", 
        quantity: 200, 
        price: "KSh 80/kg",
        status: "active",
        image: "https://images.unsplash.com/photo-1594282486555-88f2f92b522b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" 
      },
      { 
        id: 5, 
        name: "Fresh Cow Milk", 
        description: "Fresh daily milk from grass-fed cows",
        category: "dairy", 
        date: "2025-05-10", 
        quantity: 50, 
        price: "KSh 60/liter",
        status: "active",
        image: "https://images.unsplash.com/photo-1550583724-b2692b85b150?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80" 
      },
      { 
        id: 6, 
        name: "Organic Kale", 
        description: "Fresh organic kale leaves",
        category: "vegetables", 
        date: "2025-04-15", 
        quantity: 20, 
        price: "KSh 100/kg",
        status: "out",
        image: "https://images.unsplash.com/photo-1601493700631-2b16ec4b4716?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=735&q=80" 
      }
    ];

    // Category filter functionality
    document.querySelectorAll('[data-category]').forEach(item => {
      item.addEventListener('click', function(e) {
        e.preventDefault();
        const category = this.dataset.category;
        filterDashboardProducts(category);
        
        // Update active state
        document.querySelectorAll('[data-category]').forEach(link => {
          link.classList.remove('active');
        });
        this.classList.add('active');
      });
    });

    // Function to filter products in dashboard table
    function filterDashboardProducts(category) {
      const rows = document.querySelectorAll('#recentProductsTable tbody tr');
      
      rows.forEach(row => {
        if (category === 'all' || row.dataset.category === category) {
          row.style.display = '';
        } else {
          row.style.display = 'none';
        }
      });
    }

    // Edit button functionality
    document.querySelectorAll('.edit-btn').forEach(btn => {
      btn.addEventListener('click', function() {
        const productId = parseInt(this.closest('tr').dataset.id);
        const product = dashboardProducts.find(p => p.id === productId);
        
        if (product) {
          // In a real app, you would open a modal or form to edit the product
          alert(`Editing product: ${product.name}`);
          // Here you would implement the actual edit functionality
          // For example, open a modal with the product data
        }
      });
    });

    // Delete button functionality
    document.querySelectorAll('.delete-btn').forEach(btn => {
      btn.addEventListener('click', function() {
        const row = this.closest('tr');
        const productId = parseInt(row.dataset.id);
        
        if (confirm('Are you sure you want to delete this product?')) {
          // In a real app, you would remove the product from your data array
          // and update the UI accordingly
          row.remove();
          alert('Product deleted successfully!');
          
          // Update the total products count
          document.getElementById('totalProducts').textContent = 
            parseInt(document.getElementById('totalProducts').textContent) - 1;
        }
      });
    });

    // View All Products button functionality
    document.querySelector('a[href="#productsSection"]').addEventListener('click', function(e) {
      e.preventDefault();
      // In a real app, you would switch to the products section
      // and show all products there
      alert('Showing all products in the products section');
    });
  });
  