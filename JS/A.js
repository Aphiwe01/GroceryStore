
      // Sample Data
    // Product Category Filter
    document.getElementById('productCategoryFilter').addEventListener('change', function () {
        applyProductFilters();
      });

    // Product Date Filter (we'll use the date added, which we need to add to our product data)
    document.getElementById('productDateFilter').addEventListener('change', function () {
        applyProductFilters();
      });

    function applyProductFilters() {
          const searchTerm = document.getElementById('productSearch').value.toLowerCase();
    const categoryFilter = document.getElementById('productCategoryFilter').value;
    const dateFilter = document.getElementById('productDateFilter').value;

    const rows = document.querySelectorAll('#productsTable tbody tr');

          rows.forEach(row => {
              const name = row.cells[1].textContent.toLowerCase();
    const farmer = row.cells[2].textContent.toLowerCase();
    const category = row.cells[3].textContent.toLowerCase();
    const dateAdded = row.dataset.dateAdded; // We'll need to add this data attribute

    // Search term filter
    const searchMatch = name.includes(searchTerm) ||
    farmer.includes(searchTerm) ||
    category.includes(searchTerm);

    // Category filter
    let categoryMatch = true;
    if (categoryFilter) {
        categoryMatch = category.toLowerCase() === categoryFilter.toLowerCase();
              }

    // Date filter
    let dateMatch = true;
    if (dateFilter && dateAdded) {
                  const rowDate = new Date(dateAdded).toISOString().split('T')[0];
    dateMatch = rowDate === dateFilter;
              }

    row.style.display = searchMatch && categoryMatch && dateMatch ? '' : 'none';
          });
      }

    // Update reset function to clear all product filters
    document.getElementById('resetProductSearch').addEventListener('click', function () {
        document.getElementById('productSearch').value = '';
    document.getElementById('productCategoryFilter').value = '';
    document.getElementById('productDateFilter').value = '';
          document.querySelectorAll('#productsTable tbody tr').forEach(row => {
        row.style.display = '';
          });
      });
    // Sales Chart
    const salesCtx = document.getElementById('salesChart').getContext('2d');
    const salesChart = new Chart(salesCtx, {
        type: 'line',
    data: {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
    datasets: [
    {
        label: 'CHM',
    data: [4000, 3000, 5000, 2000, 6000, 4000],
    borderColor: '#007bff',
    backgroundColor: 'rgba(0, 123, 255, 0.1)',
    fill: true,
    tension: 0.4
                  },
    {
        label: 'USA',
    data: [2000, 4000, 3000, 5000, 3000, 6000],
    borderColor: '#28a745',
    backgroundColor: 'rgba(40, 167, 69, 0.1)',
    fill: true,
    tension: 0.4
                  },
    {
        label: 'UK',
    data: [1000, 2000, 4000, 3000, 5000, 3000],
    borderColor: '#ffc107',
    backgroundColor: 'rgba(255, 193, 7, 0.1)',
    fill: true,
    tension: 0.4
                  }
    ]
          },
    options: {
        responsive: true,
    plugins: {
        legend: {
        display: false
                  }
              }
          }
      });

    // Sources Chart
    const sourcesCtx = document.getElementById('sourcesChart').getContext('2d');
    const sourcesChart = new Chart(sourcesCtx, {
        type: 'doughnut',
    data: {
        labels: ['Search Engines', 'Direct Buyers', 'Repeat Customers'],
    datasets: [{
        data: [45, 30, 25],
    backgroundColor: ['#007bff', '#28a745', '#ffc107'],
    borderWidth: 0
              }]
          },
    options: {
        responsive: true,
    plugins: {
        legend: {
        display: false
                  }
              }
          }
      });

    let farmers = [
    {
        id: 1, name: "John Kamau", email: "john@example.com", phone: "+254712345678",
    location: "Nairobi", farmSize: 5.2, joinDate: "2025-01-15"
          },
    {
        id: 2, name: "Mary Wambui", email: "mary@example.com", phone: "+254723456789",
    location: "Kiambu", farmSize: 3.8, joinDate: "2025-02-20"
          }
    ];

    let products = [
    {
        id: 1,
    name: "Organic Tomatoes",
    farmerId: 1,
    farmerName: "John Kamau",
    category: "vegetables",
    quantity: 50,
    price: 2.5,
    description: "Fresh organic tomatoes",
    dateAdded: "2025-01-20"
          },
    {
        id: 2,
    name: "Avocados",
    farmerId: 2,
    farmerName: "Mary Wambui",
    category: "fruits",
    quantity: 30,
    price: 3.2,
    description: "Premium Hass avocados",
    dateAdded: "2025-02-25"
          }
    ];

    // DOM Elements
    const sidebarLinks = document.querySelectorAll('.sidebar .nav-link[data-section]');
    const sections = {
        dashboard: document.getElementById('dashboardSection'),
    farmers: document.getElementById('farmersSection'),
    products: document.getElementById('productsSection'),

      };

    // Initialize
    renderFarmersTable();
    renderProductsTable();
    populateFarmerDropdown();

      // Navigation
      sidebarLinks.forEach(link => {
        link.addEventListener('click', function (e) {
            e.preventDefault();
            const sectionId = this.dataset.section;

            // Hide all sections
            Object.values(sections).forEach(section => {
                section.classList.add('d-none');
            });

            // Show selected section
            sections[sectionId].classList.remove('d-none');

            // Update active nav link
            sidebarLinks.forEach(link => link.classList.remove('active'));
            this.classList.add('active');
        });
      });

    // Render Farmers Table
    function renderFarmersTable() {
          const tableBody = document.querySelector('#farmersTable tbody');
    tableBody.innerHTML = '';

          farmers.forEach(farmer => {
        tableBody.innerHTML += `
          <tr>
            <td>${farmer.id}</td>
            <td>${farmer.name}</td>
            <td>${farmer.email}</td>
            <td>${farmer.phone}</td>
            <td>${farmer.location}</td>
            <td>${farmer.farmSize} acres</td>
            <td>${new Date(farmer.joinDate).toLocaleDateString()}</td>
            <td>
              <button class="btn btn-sm btn-outline-primary edit-farmer" data-id="${farmer.id}">
                <i class="fas fa-edit"></i>
              </button>
              <button class="btn btn-sm btn-outline-danger delete-farmer" data-id="${farmer.id}">
                <i class="fas fa-trash"></i>
              </button>
            </td>
          </tr>
        `;
          });

          // Add event listeners to new buttons
          document.querySelectorAll('.edit-farmer').forEach(btn => {
        btn.addEventListener('click', function () {
            const farmerId = parseInt(this.dataset.id);
            editFarmer(farmerId);
        });
          });

          document.querySelectorAll('.delete-farmer').forEach(btn => {
        btn.addEventListener('click', function () {
            const farmerId = parseInt(this.dataset.id);
            deleteFarmer(farmerId);
        });
          });
      }

    // Render Products Table
    function renderProductsTable() {
          const tableBody = document.querySelector('#productsTable tbody');
    tableBody.innerHTML = '';

          products.forEach(product => {
        tableBody.innerHTML += `
          <tr>
            <td>${product.id}</td>
            <td>${product.name}</td>
            <td>${product.farmerName}</td>
            <td>${product.category.charAt(0).toUpperCase() + product.category.slice(1)}</td>
            <td>${product.quantity} kg</td>
            <td>$${product.price.toFixed(2)}</td>
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

          // Add event listeners to new buttons
          document.querySelectorAll('.edit-product').forEach(btn => {
        btn.addEventListener('click', function () {
            const productId = parseInt(this.dataset.id);
            editProduct(productId);
        });
          });

          document.querySelectorAll('.delete-product').forEach(btn => {
        btn.addEventListener('click', function () {
            const productId = parseInt(this.dataset.id);
            deleteProduct(productId);
        });
          });
      }

    // Populate Farmer Dropdown
    function populateFarmerDropdown() {
          const dropdown = document.getElementById('productFarmer');
    dropdown.innerHTML = '<option value="">Select Farmer</option>';

          farmers.forEach(farmer => {
        dropdown.innerHTML += `<option value="${farmer.id}">${farmer.name} (${farmer.location})</option>`;
          });
      }

    // Farmer Search
    document.getElementById('farmerSearch').addEventListener('input', function () {
          const searchTerm = this.value.toLowerCase();
    const rows = document.querySelectorAll('#farmersTable tbody tr');

          rows.forEach(row => {
              const name = row.cells[1].textContent.toLowerCase();
    const email = row.cells[2].textContent.toLowerCase();
    const location = row.cells[4].textContent.toLowerCase();
    if (name.includes(searchTerm) || email.includes(searchTerm) || location.includes(searchTerm)) {
        row.style.display = '';
              } else {
        row.style.display = 'none';
              }
          });
      });

    // Product Search
    document.getElementById('productSearch').addEventListener('input', function () {
          const searchTerm = this.value.toLowerCase();
    const rows = document.querySelectorAll('#productsTable tbody tr');

          rows.forEach(row => {
              const name = row.cells[1].textContent.toLowerCase();
    const farmer = row.cells[2].textContent.toLowerCase();
    const category = row.cells[3].textContent.toLowerCase();
    if (name.includes(searchTerm) || farmer.includes(searchTerm) || category.includes(searchTerm)) {
        row.style.display = '';
              } else {
        row.style.display = 'none';
              }
          });
      });

    // Reset Search
    document.getElementById('resetFarmerSearch').addEventListener('click', function () {
        document.getElementById('farmerSearch').value = '';
          document.querySelectorAll('#farmersTable tbody tr').forEach(row => {
        row.style.display = '';
          });
      });

    document.getElementById('resetProductSearch').addEventListener('click', function () {
        document.getElementById('productSearch').value = '';
          document.querySelectorAll('#productsTable tbody tr').forEach(row => {
        row.style.display = '';
          });
      });

    // Form Submissions
    document.getElementById('farmerForm').addEventListener('submit', function (e) {
        e.preventDefault();
    addNewFarmer();
      });

    document.getElementById('productForm').addEventListener('submit', function (e) {
        e.preventDefault();
    addNewProduct();
      });

    // CRUD Operations
    function addNewFarmer() {
          const newId = farmers.length > 0 ? Math.max(...farmers.map(f => f.id)) + 1 : 1;

    const newFarmer = {
        id: newId,
    name: document.getElementById('farmerName').value,
    email: document.getElementById('farmerEmail').value,
    phone: document.getElementById('farmerPhone').value,
    location: document.getElementById('farmerLocation').value,
    farmSize: parseFloat(document.getElementById('farmerFarmSize').value),
    joinDate: document.getElementById('farmerJoinDate').value
          };

    farmers.push(newFarmer);
    renderFarmersTable();
    populateFarmerDropdown();
    document.getElementById('farmerForm').reset();
    alert('Farmer added successfully!');
      }

    function addNewProduct() {
          const newId = products.length > 0 ? Math.max(...products.map(p => p.id)) + 1 : 1;
    const farmerId = parseInt(document.getElementById('productFarmer').value);
          const farmer = farmers.find(f => f.id === farmerId);

    const newProduct = {
        id: newId,
    name: document.getElementById('productName').value,
    farmerId: farmerId,
    farmerName: farmer.name,
    category: document.getElementById('productCategory').value,
    quantity: parseInt(document.getElementById('productQuantity').value),
    price: parseFloat(document.getElementById('productPrice').value),
    description: document.getElementById('productDescription').value
          };

    products.push(newProduct);
    renderProductsTable();
    document.getElementById('productForm').reset();
    alert('Product added successfully!');
      }

    function editFarmer(id) {
          const farmer = farmers.find(f => f.id === id);
    if (!farmer) return;

    document.getElementById('editFarmerForm').innerHTML = `
    <form>
        <input type="hidden" id="editFarmerId" value="${farmer.id}">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="editFarmerName" class="form-label">Full Name</label>
                    <input type="text" class="form-control" id="editFarmerName" value="${farmer.name}" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="editFarmerEmail" class="form-label">Email</label>
                    <input type="email" class="form-control" id="editFarmerEmail" value="${farmer.email}" required>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="editFarmerPhone" class="form-label">Phone</label>
                    <input type="tel" class="form-control" id="editFarmerPhone" value="${farmer.phone}" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="editFarmerLocation" class="form-label">Location</label>
                    <input type="text" class="form-control" id="editFarmerLocation" value="${farmer.location}" required>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="editFarmerFarmSize" class="form-label">Farm Size (acres)</label>
                    <input type="number" class="form-control" id="editFarmerFarmSize" value="${farmer.farmSize}" min="0.1" step="0.1" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="editFarmerJoinDate" class="form-label">Join Date</label>
                    <input type="date" class="form-control" id="editFarmerJoinDate" value="${farmer.joinDate}" required>
                </div>
            </div>
    </form>
    `;

    new bootstrap.Modal(document.getElementById('editFarmerModal')).show();
      }

    function editProduct(id) {
          const product = products.find(p => p.id === id);
    if (!product) return;

    document.getElementById('editProductForm').innerHTML = `
    <form>
        <input type="hidden" id="editProductId" value="${product.id}">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="editProductName" class="form-label">Product Name</label>
                    <input type="text" class="form-control" id="editProductName" value="${product.name}" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="editProductFarmer" class="form-label">Farmer</label>
                    <select class="form-select" id="editProductFarmer" required>
                        ${farmers.map(f => `<option value="${f.id}" ${f.id === product.farmerId ? 'selected' : ''}>${f.name} (${f.location})</option>`).join('')}
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 mb-3">
                    <label for="editProductCategory" class="form-label">Category</label>
                    <select class="form-select" id="editProductCategory" required>
                        <option value="vegetables" ${product.category === 'vegetables' ? 'selected' : ''}>Vegetables</option>
                        <option value="fruits" ${product.category === 'fruits' ? 'selected' : ''}>Fruits</option>
                        <option value="grains" ${product.category === 'grains' ? 'selected' : ''}>Grains</option>
                        <option value="dairy" ${product.category === 'dairy' ? 'selected' : ''}>Dairy</option>
                    </select>
                </div>
                <div class="col-md-4 mb-3">
                    <label for="editProductQuantity" class="form-label">Quantity (kg)</label>
                    <input type="number" class="form-control" id="editProductQuantity" value="${product.quantity}" min="1" required>
                </div>
                <div class="col-md-4 mb-3">
                    <label for="editProductPrice" class="form-label">Price per kg ($)</label>
                    <input type="number" class="form-control" id="editProductPrice" value="${product.price}" min="0.01" step="0.01" required>
                </div>
            </div>
            <div class="mb-3">
                <label for="editProductDescription" class="form-label">Description</label>
                <textarea class="form-control" id="editProductDescription" rows="3">${product.description}</textarea>
            </div>
    </form>
    `;

    new bootstrap.Modal(document.getElementById('editProductModal')).show();
      }

    // Save Changes
    document.getElementById('saveFarmerChanges').addEventListener('click', function () {
          const id = parseInt(document.getElementById('editFarmerId').value);
          const farmer = farmers.find(f => f.id === id);

    if (farmer) {
        farmer.name = document.getElementById('editFarmerName').value;
    farmer.email = document.getElementById('editFarmerEmail').value;
    farmer.phone = document.getElementById('editFarmerPhone').value;
    farmer.location = document.getElementById('editFarmerLocation').value;
    farmer.farmSize = parseFloat(document.getElementById('editFarmerFarmSize').value);
    farmer.joinDate = document.getElementById('editFarmerJoinDate').value;

    renderFarmersTable();
    renderProductsTable(); // Update products that reference this farmer
    populateFarmerDropdown();
    bootstrap.Modal.getInstance(document.getElementById('editFarmerModal')).hide();
    alert('Farmer updated successfully!');
          }
      });

    document.getElementById('saveProductChanges').addEventListener('click', function () {
          const id = parseInt(document.getElementById('editProductId').value);
          const product = products.find(p => p.id === id);
    const farmerId = parseInt(document.getElementById('editProductFarmer').value);
          const farmer = farmers.find(f => f.id === farmerId);

    if (product && farmer) {
        product.name = document.getElementById('editProductName').value;
    product.farmerId = farmerId;
    product.farmerName = farmer.name;
    product.category = document.getElementById('editProductCategory').value;
    product.quantity = parseInt(document.getElementById('editProductQuantity').value);
    product.price = parseFloat(document.getElementById('editProductPrice').value);
    product.description = document.getElementById('editProductDescription').value;

    renderProductsTable();
    bootstrap.Modal.getInstance(document.getElementById('editProductModal')).hide();
    alert('Product updated successfully!');
          }
      });

    function deleteFarmer(id) {
          if (confirm('Are you sure you want to delete this farmer? This will also delete all their products.')) {
        farmers = farmers.filter(f => f.id !== id);
              products = products.filter(p => p.farmerId !== id);
    renderFarmersTable();
    renderProductsTable();
    populateFarmerDropdown();
    alert('Farmer and associated products deleted successfully!');
          }
      }

    function deleteProduct(id) {
          if (confirm('Are you sure you want to delete this product?')) {
        products = products.filter(p => p.id !== id);
    renderProductsTable();
    alert('Product deleted successfully!');
          }
      }

    // Initialize with dashboard section
    sections.dashboard.classList.remove('d-none');
    document.querySelector('.nav-link[data-section="dashboard"]').classList.add('active');
    // Farmer Category Filter
    document.getElementById('farmerCategoryFilter').addEventListener('change', function () {
        applyFarmerFilters();
      });

    // Farmer Date Filter
    document.getElementById('farmerDateFilter').addEventListener('change', function () {
        applyFarmerFilters();
      });

    function applyFarmerFilters() {
          const searchTerm = document.getElementById('farmerSearch').value.toLowerCase();
    const categoryFilter = document.getElementById('farmerCategoryFilter').value;
    const dateFilter = document.getElementById('farmerDateFilter').value;

    const rows = document.querySelectorAll('#farmersTable tbody tr');

          rows.forEach(row => {
              const name = row.cells[1].textContent.toLowerCase();
    const email = row.cells[2].textContent.toLowerCase();
    const location = row.cells[4].textContent.toLowerCase();
    const farmSize = parseFloat(row.cells[5].textContent);
    const joinDate = row.cells[6].textContent;

    // Search term filter
    const searchMatch = name.includes(searchTerm) ||
    email.includes(searchTerm) ||
    location.includes(searchTerm);

    // Category filter
    let categoryMatch = true;
    if (categoryFilter) {
                  if (categoryFilter === 'small') {
        categoryMatch = farmSize < 5;
                  } else if (categoryFilter === 'medium') {
        categoryMatch = farmSize >= 5 && farmSize <= 20;
                  } else if (categoryFilter === 'large') {
        categoryMatch = farmSize > 20;
                  }
              }

    // Date filter
    let dateMatch = true;
    if (dateFilter) {
                  const rowDate = new Date(joinDate).toISOString().split('T')[0];
    dateMatch = rowDate === dateFilter;
              }

    row.style.display = searchMatch && categoryMatch && dateMatch ? '' : 'none';
          });
      }

    // Update reset function to clear all filters
    document.getElementById('resetFarmerSearch').addEventListener('click', function () {
        document.getElementById('farmerSearch').value = '';
    document.getElementById('farmerCategoryFilter').value = '';
    document.getElementById('farmerDateFilter').value = '';
          document.querySelectorAll('#farmersTable tbody tr').forEach(row => {
        row.style.display = '';
          });
      });
