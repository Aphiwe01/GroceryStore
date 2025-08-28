<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="GroceryStore.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>FreshMart Grocery</title>
  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <link href="CSS/II.css" rel="stylesheet" type="text/css" />
<link href="CSS/I.css" rel="stylesheet" type="text/css" />
<script src="JS/I.js" type="text/javascript"></script>
  
  <style>
    /* Additional styles for grocery store */
    .product-card {
      transition: transform 0.3s;
    }
    .product-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    }
    .cart-count {
      position: absolute;
      top: -5px;
      right: -5px;
      background: #ff6b6b;
      color: white;
      border-radius: 50%;
      width: 20px;
      height: 20px;
      font-size: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .cart-icon {
      position: relative;
    }
    .modal-body label {
      font-weight: 500;
      margin-bottom: 5px;
    }
  </style>
</head>
<body>
  <!-- Navbar -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-success">
    <div class="container">
      <a class="navbar-brand" href="index.aspx">
        <i class="fas fa-shopping-basket me-2"></i>FreshMart Grocery
      </a>
      
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
        <span class="navbar-toggler-icon"></span>
      </button>
      
      <div class="collapse navbar-collapse" id="navbarContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link" href="index.aspx">Home</a>
          </li>
         <li class="nav-item">
  <a class="nav-link" href="Admin.aspx" onclick="return warnNonAdmins()">Admin</a>
</li>
          <li class="nav-item">
            <a class="nav-link" href="UserRegistration.aspx">UserRegistration</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="Customer.aspx">Customer</a>
          </li>
        </ul>
        
        <div class="d-flex align-items-center">
          <div class="search-box me-3">
            <input type="text" class="form-control search-input" placeholder="Search products...">
            <button class="search-btn">
              <i class="fas fa-search"></i>
            </button>
          </div>
          <a href="#" class="text-white me-3 cart-icon" id="cartIcon">
            <i class="fas fa-shopping-cart fa-lg"></i>
            <span class="cart-count d-none">0</span>
          </a>
        </div>
      </div>
    </div>
  </nav>

  <!-- Hero Section -->
  <section class="hero-section bg-light">
    <div class="container">
      <h1 class="display-4 fw-bold mb-4">Fresh Groceries Delivered to Your Door</h1>
      <p class="lead mb-5">Quality products at affordable prices with convenient delivery options</p>
      <a href="#products" class="btn btn-success btn-lg px-4 me-2">Shop Now</a>
      <a href="#" class="btn btn-success btn-lg px-4 me-2">Weekly Specials</a>
    </div>
  </section>

   <!-- Featured Products -->
    <section id="products" class="py-5">
        <div class="container">
            <h2 class="text-center mb-5">Our Fresh Products</h2>
            <div class="row">
                <!-- Product Card 1 -->
                <div class="col-md-4 mb-4">
                    <div class="card product-card">
                        <img src="images/maize-meal.jpg" class="card-img-top" alt="Maize Meal" style="height: 200px">
                        <div class="card-body">
                            <h5 class="card-title">Maize Meal</h5>
                            <p class="card-text">Our premium maize meal is stone-ground to preserve nutrients and natural flavor. Perfect for making traditional porridge, pap, and baked goods. Sourced from non-GMO, sustainably farmed maize.</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="text-success fw-bold">R45.50</span>
                                <div class="quantity-selector">
                                    <button class="btn btn-sm btn-outline-secondary minus-btn">-</button>
                                    <span class="mx-2 quantity">1</span>
                                    <button class="btn btn-sm btn-outline-secondary plus-btn">+</button>
                                </div>
                            </div>
                            <button class="btn btn-success btn-sm w-100 mt-2 add-to-cart" data-name="Maize Meal" data-price="45.50">Add to Cart</button>
                        </div>
                    </div>
                </div>
                
                <!-- Product Card 2 -->
                <div class="col-md-4 mb-4">
                    <div class="card product-card">
                        <img src="images/spinach.jpg" class="card-img-top" alt="Fresh Spinach" style="height: 200px">
                        <div class="card-body">
                            <h5 class="card-title">Spinach</h5>
                            <p class="card-text">Crisp, tender spinach leaves harvested at peak freshness. Packed with iron, vitamins A and C, and antioxidants. Perfect for salads, sautéing, or adding to smoothies. Grown locally without synthetic pesticides.</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="text-success fw-bold">R20.00</span>
                                <div class="quantity-selector">
                                    <button class="btn btn-sm btn-outline-secondary minus-btn">-</button>
                                    <span class="mx-2 quantity">1</span>
                                    <button class="btn btn-sm btn-outline-secondary plus-btn">+</button>
                                </div>
                            </div>
                            <button class="btn btn-success btn-sm w-100 mt-2 add-to-cart" data-name="Spinach" data-price="20.00">Add to Cart</button>
                        </div>
                    </div>
                </div>
                
                <!-- Product Card 3 -->
                <div class="col-md-4 mb-4">
                    <div class="card product-card">
                        <img src="images/apples.jpg" class="card-img-top" alt="Fresh Apples" style="height: 200px">
                        <div class="card-body">
                            <h5 class="card-title">Apples</h5>
                            <p class="card-text">Crisp, juicy South African apples with the perfect balance of sweetness and tartness. Each apple is hand-picked at optimal ripeness. Excellent source of fiber and vitamin C. Ideal for snacking, baking, or juicing.</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="text-success fw-bold">R30.00</span>
                                <div class="quantity-selector">
                                    <button class="btn btn-sm btn-outline-secondary minus-btn">-</button>
                                    <span class="mx-2 quantity">1</span>
                                    <button class="btn btn-sm btn-outline-secondary plus-btn">+</button>
                                </div>
                            </div>
                            <button class="btn btn-success btn-sm w-100 mt-2 add-to-cart" data-name="Apples" data-price="30.00">Add to Cart</button>
                        </div>
                    </div>
                </div>
        
                <!-- Product Card 4 -->
                <div class="col-md-4 mb-4">
                    <div class="card product-card">
                        <img src="images/cheese.jpg" class="card-img-top" alt="Aged Cheddar Cheese" style="height: 200px">
                        <div class="card-body">
                            <h5 class="card-title">Cheddar Cheese</h5>
                            <p class="card-text">Our artisanal cheddar cheese is aged for 12 months to develop a rich, complex flavor with a slightly crumbly texture. Made from the milk of grass-fed cows, it's perfect for cheeseboards, melting, or enjoying on its own.</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="text-success fw-bold">R80.00</span>
                                <div class="quantity-selector">
                                    <button class="btn btn-sm btn-outline-secondary minus-btn">-</button>
                                    <span class="mx-2 quantity">1</span>
                                    <button class="btn btn-sm btn-outline-secondary plus-btn">+</button>
                                </div>
                            </div>
                            <button class="btn btn-success btn-sm w-100 mt-2 add-to-cart" data-name="Cheddar Cheese" data-price="80.00">Add to Cart</button>
                        </div>
                    </div>
                </div>
        
                <!-- Product Card 5 -->
                <div class="col-md-4 mb-4">
                    <div class="card product-card">
                        <img src="images/tomatoes.jpg" class="card-img-top" alt="Fresh Farm Tomatoes" style="height: 200px">
                        <div class="card-body">
                            <h5 class="card-title">Tomatoes</h5>
                            <p class="card-text">Vine-ripened tomatoes bursting with flavor and nutrients. Grown in nutrient-rich soil and harvested at peak ripeness. Rich in lycopene, vitamin C, and antioxidants. Perfect for salads, sauces, sandwiches, or simply eating fresh.</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="text-success fw-bold">R25.00</span>
                                <div class="quantity-selector">
                                    <button class="btn btn-sm btn-outline-secondary minus-btn">-</button>
                                    <span class="mx-2 quantity">1</span>
                                    <button class="btn btn-sm btn-outline-secondary plus-btn">+</button>
                                </div>
                            </div>
                            <button class="btn btn-success btn-sm w-100 mt-2 add-to-cart" data-name="Tomatoes" data-price="25.00">Add to Cart</button>
                        </div>
                    </div>
                </div>
        
                <!-- Product Card 6 -->
                <div class="col-md-4 mb-4">
                    <div class="card product-card">
                        <img src="images/milk.jpg" class="card-img-top" alt="Fresh Whole Milk"style="height: 200px">
                        <div class="card-body">
                            <h5 class="card-title">Fresh Whole Milk (1L)</h5>
                            <p class="card-text">Creamy, wholesome milk from grass-fed cows that are never treated with hormones. Our milk is pasteurized for safety but not homogenized, allowing the cream to rise naturally. Rich in calcium, protein, and essential vitamins.</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="text-success fw-bold">R32.00</span>
                                <div class="quantity-selector">
                                    <button class="btn btn-sm btn-outline-secondary minus-btn">-</button>
                                    <span class="mx-2 quantity">1</span>
                                    <button class="btn btn-sm btn-outline-secondary plus-btn">+</button>
                                </div>
                            </div>
                            <button class="btn btn-success btn-sm w-100 mt-2 add-to-cart" data-name="Fresh Whole Milk (1L)" data-price="32.00">Add to Cart</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="text-center mt-4">
                <a href="#" class="btn btn-success btn-lg">View All Products</a>
            </div>
        </div>
    </section>
  <!-- Special Offers Carousel -->
  <section class="bg-light py-5">
    <div class="container">
      <h2 class="text-center mb-5">Weekly Special Offers</h2>
      <div id="offersCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
          <div class="carousel-item active">
            <img src="https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80" class="d-block w-100" alt="Grocery Special">
            <div class="carousel-caption d-none d-md-block bg-dark bg-opacity-75 rounded">
              <h5>Buy 2 Get 1 Free</h5>
              <p>This week only - select fresh produce items</p>
              <a href="#products" class="btn btn-success">Shop Now</a>
            </div>
          </div>
          <div class="carousel-item">
            <img src="https://images.unsplash.com/photo-1606787366850-de6330128bfc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" class="d-block w-100" alt="Dairy Special">
            <div class="carousel-caption d-none d-md-block bg-dark bg-opacity-75 rounded">
              <h5>Dairy Discount Week</h5>
              <p>20% off all dairy products including milk, cheese and yogurt</p>
              <a href="#products" class="btn btn-success">Shop Now</a>
            </div>
          </div>
          <div class="carousel-item">
            <img src="https://images.unsplash.com/photo-1518843025960-d60217f226f5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" class="d-block w-100" alt="Bakery Special">
            <div class="carousel-caption d-none d-md-block bg-dark bg-opacity-75 rounded">
              <h5>Fresh Bakery Deals</h5>
              <p>Half price on all bakery items after 6pm daily</p>
              <a href="#products" class="btn btn-success">Shop Now</a>
            </div>
          </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#offersCarousel" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#offersCarousel" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
        </button>
      </div>
    </div>
  </section>

  <!-- News Section -->
  <section class="news-section py-5">
    <div class="container">
      <h2 class="text-center mb-5">Grocery News & Tips</h2>
      <div class="row">
        <div class="col-md-4 mb-4">
          <div class="card h-100">
            <img src="https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80" class="card-img-top" alt="Healthy Eating">
            <div class="card-body">
              <h5 class="card-title">5 Ways to Eat Healthier This Week</h5>
              <p class="card-text">Simple tips to incorporate more fresh produce into your meals...</p>
              <a href="#" class="btn btn-outline-success">Read More</a>
            </div>
            <div class="card-footer text-muted">
              Posted 3 days ago
            </div>
          </div>
        </div>
        
        <div class="col-md-4 mb-4">
          <div class="card h-100">
            <img src="https://images.unsplash.com/photo-1606787366850-de6330128bfc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" class="card-img-top" alt="Storage Tips">
            <div class="card-body">
              <h5 class="card-title">How to Store Fresh Produce to Last Longer</h5>
              <p class="card-text">Expert advice on keeping your fruits and vegetables fresh...</p>
              <a href="#" class="btn btn-outline-success">Read More</a>
            </div>
            <div class="card-footer text-muted">
              Posted 1 week ago
            </div>
          </div>
        </div>
        
        <div class="col-md-4 mb-4">
          <div class="card h-100">
            <img src="https://images.unsplash.com/photo-1490645935967-10de6ba17061?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1453&q=80" class="card-img-top" alt="Seasonal Produce">
            <div class="card-body">
              <h5 class="card-title">What's In Season This Month</h5>
              <p class="card-text">Discover which fruits and vegetables are at their peak right now...</p>
              <a href="#" class="btn btn-outline-success">Read More</a>
            </div>
            <div class="card-footer text-muted">
              Posted 2 weeks ago
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Checkout Modal -->
  <div class="modal fade" id="checkoutModal" tabindex="-1" aria-labelledby="checkoutModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header bg-success text-white">
          <h5 class="modal-title" id="checkoutModalLabel">Checkout</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form id="checkoutForm">
            <div class="mb-3">
              <label for="fullName" class="form-label">Full Name</label>
              <input type="text" class="form-control" id="fullName" required>
            </div>
            <div class="mb-3">
              <label for="email" class="form-label">Email Address</label>
              <input type="email" class="form-control" id="email" required>
            </div>
            <div class="mb-3">
              <label for="phone" class="form-label">Phone Number</label>
              <input type="tel" class="form-control" id="phone" required>
            </div>
            <div class="mb-3">
              <label for="address" class="form-label">Delivery Address</label>
              <textarea class="form-control" id="address" rows="3" required></textarea>
            </div>
            <div class="mb-3">
              <label for="paymentMethod" class="form-label">Payment Method</label>
              <select class="form-select" id="paymentMethod" required>
                <option value="">Select payment method</option>
                <option value="credit">Credit Card</option>
                <option value="debit">Debit Card</option>
                <option value="cash">Cash on Delivery</option>
              </select>
            </div>
            <div class="mb-3">
              <label class="form-label">Order Summary</label>
              <div id="orderSummary" class="border p-2">
                <!-- Order items will be displayed here -->
              </div>
              <div class="d-flex justify-content-between mt-2">
                <strong>Total:</strong>
                <strong id="orderTotal">R0.00</strong>
              </div>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Continue Shopping</button>
          <button type="button" class="btn btn-success" id="confirmOrder">Place Order</button>
        </div>
      </div>
    </div>
  </div>
      <!-- Customer Testimonials -->
  <section class="py-5 bg-light">
    <div class="container">
      <h2 class="text-center mb-5">What Our Customers Say</h2>
      <div class="row">
        <!-- Testimonial 1 -->
        <div class="col-md-4 mb-4">
          <div class="card h-100">
            <div class="card-body text-center">
              <div class="mb-3">
                <i class="fas fa-quote-left fa-2x text-muted"></i>
              </div>
              <p class="card-text">"FreshMart has the freshest produce in town! I've been shopping here for years and the quality never disappoints."</p>
              <div class="rating mb-3">
                <i class="fas fa-star text-warning"></i>
                <i class="fas fa-star text-warning"></i>
                <i class="fas fa-star text-warning"></i>
                <i class="fas fa-star text-warning"></i>
                <i class="fas fa-star text-warning"></i>
              </div>
              <img src="https://randomuser.me/api/portraits/women/32.jpg" class="rounded-circle mb-2" width="80" alt="Customer">
              <h5 class="card-title mb-1">Sarah Johnson</h5>
              <p class="text-muted small">Regular Customer</p>
            </div>
          </div>
        </div>
        
        <!-- Testimonial 2 -->
        <div class="col-md-4 mb-4">
          <div class="card h-100">
            <div class="card-body text-center">
              <div class="mb-3">
                <i class="fas fa-quote-left fa-2x text-muted"></i>
              </div>
              <p class="card-text">"The delivery service is fantastic! My groceries always arrive on time and in perfect condition. Highly recommend!"</p>
              <div class="rating mb-3">
                <i class="fas fa-star text-warning"></i>
                <i class="fas fa-star text-warning"></i>
                <i class="fas fa-star text-warning"></i>
                <i class="fas fa-star text-warning"></i>
                <i class="fas fa-star-half-alt text-warning"></i>
              </div>
              <img src="https://randomuser.me/api/portraits/men/54.jpg" class="rounded-circle mb-2" width="80" alt="Customer">
              <h5 class="card-title mb-1">Michael Brown</h5>
              <p class="text-muted small">Delivery Customer</p>
            </div>
          </div>
        </div>
        
        <!-- Testimonial 3 -->
        <div class="col-md-4 mb-4">
          <div class="card h-100">
            <div class="card-body text-center">
              <div class="mb-3">
                <i class="fas fa-quote-left fa-2x text-muted"></i>
              </div>
              <p class="card-text">"Love the weekly specials and the friendly staff. FreshMart is my one-stop shop for all my grocery needs!"</p>
              <div class="rating mb-3">
                <i class="fas fa-star text-warning"></i>
                <i class="fas fa-star text-warning"></i>
                <i class="fas fa-star text-warning"></i>
                <i class="fas fa-star text-warning"></i>
                <i class="fas fa-star text-warning"></i>
              </div>
              <img src="https://randomuser.me/api/portraits/women/68.jpg" class="rounded-circle mb-2" width="80" alt="Customer">
              <h5 class="card-title mb-1">Lisa Williams</h5>
              <p class="text-muted small">Loyal Customer</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <!-- Footer -->
  <footer class="bg-dark text-white pt-5 pb-4">
    <div class="container">
      <div class="row">
        <div class="col-md-4 mb-4">
          <h5>About FreshMart</h5>
          <p>Your neighborhood grocery store providing fresh, quality products at affordable prices with convenient delivery options.</p>
          <div class="social-icons mt-3">
            <a href="#" class="text-white me-3"><i class="fab fa-facebook-f"></i></a>
            <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
            <a href="#" class="text-white me-3"><i class="fab fa-instagram"></i></a>
            <a href="#" class="text-white"><i class="fab fa-linkedin-in"></i></a>
          </div>
        </div>
        
        <div class="col-md-2 mb-4">
          <h5>Quick Links</h5>
          <ul class="list-unstyled">
            <li><a href="UserRegistration.aspx" class="text-white">Log Out</a></li>
            <li><a href="Customer.aspx" class="text-white">Customer Portal</a></li>
          </ul>
        </div>
        
        <div class="col-md-3 mb-4">
          <h5>Contact Us</h5>
          <ul class="list-unstyled">
            <li><i class="fas fa-map-marker-alt me-2"></i> 45 dawn rd ,Sandton,Gauteng province</li>
            <li><i class="fas fa-phone me-2"></i> (031 456 7890</li>
            <li><i class="fas fa-envelope me-2"></i> info@freshmart.com</li>
          </ul>
        </div>
        
        <div class="col-md-3 mb-4">
          <h5>Newsletter</h5>
          <p>Subscribe to get updates on weekly specials and new products.</p>
          <div class="input-group mb-3">
            <input type="email" class="form-control" placeholder="Your Email">
            <button class="btn btn-success" type="button">Subscribe</button>
          </div>
        </div>
      </div>
      
      <hr class="mt-4 mb-4" style="border-color: #495057;">
      
      <div class="row">
        <div class="col-md-6 text-center text-md-start">
          <p class="mb-0">&copy; 2025 FreshMart Grocery. All rights reserved.</p>
        </div>
        <div class="col-md-6 text-center text-md-end">
          <a href="#" class="text-white me-3">Privacy Policy</a>
          <a href="#" class="text-white me-3">Terms of Service</a>
          <a href="#" class="text-white">FAQ</a>
        </div>
      </div>
    </div>
  </footer>

  <!-- Bootstrap 5 JS Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
 
    <script>
        // Shopping cart functionality
        let cart = [];
        const checkoutModal = new bootstrap.Modal(document.getElementById('checkoutModal'));

        // Update cart count in navbar
        function updateCartCount() {
            const count = cart.reduce((total, item) => total + item.quantity, 0);
            const cartCount = document.querySelector('.cart-count');
            cartCount.textContent = count;
            count > 0 ? cartCount.classList.remove('d-none') : cartCount.classList.add('d-none');
        }

        // Add to cart button handler
        document.querySelectorAll('.add-to-cart').forEach(button => {
            button.addEventListener('click', function () {
                const productName = this.getAttribute('data-name');
                const productPrice = parseFloat(this.getAttribute('data-price'));
                const quantity = parseInt(this.closest('.card-body').querySelector('.quantity').textContent);

                // Check if product already in cart
                const existingItem = cart.find(item => item.name === productName);

                if (existingItem) {
                    existingItem.quantity += quantity;
                } else {
                    cart.push({
                        name: productName,
                        price: productPrice,
                        quantity: quantity
                    });
                }

                updateCartCount();

                // Display customer info and form entries
                const customerInfo = "Your Order Has been Successfully Captured";
                const formEntries = `
    Product: ${productName}
    Price: R${productPrice.toFixed(2)}
    Quantity: ${quantity}
    Subtotal: R${(productPrice * quantity).toFixed(2)}
            `;

                alert(`${customerInfo}\n\nAdded to Cart:\n${formEntries}`);

                showCheckoutModal();
            });
        });

        // Quantity buttons
        document.querySelectorAll('.plus-btn').forEach(button => {
            button.addEventListener('click', function () {
                const quantityElement = this.parentElement.querySelector('.quantity');
                quantityElement.textContent = parseInt(quantityElement.textContent) + 1;
            });
        });

        document.querySelectorAll('.minus-btn').forEach(button => {
            button.addEventListener('click', function () {
                const quantityElement = this.parentElement.querySelector('.quantity');
                const currentValue = parseInt(quantityElement.textContent);
                if (currentValue > 1) {
                    quantityElement.textContent = currentValue - 1;
                }
            });
        });

        // Show checkout modal with order summary
        function showCheckoutModal() {
            const orderSummary = document.getElementById('orderSummary');
            const orderTotal = document.getElementById('orderTotal');
            let total = 0;

            orderSummary.innerHTML = '';
            cart.forEach(item => {
                const itemTotal = item.price * item.quantity;
                total += itemTotal;

                const itemElement = document.createElement('div');
                itemElement.className = 'd-flex justify-content-between mb-2';
                itemElement.innerHTML = `
      <span>${item.name} x${item.quantity}</span>
      <span>R${itemTotal.toFixed(2)}</span>
    `;
                orderSummary.appendChild(itemElement);
            });

            orderTotal.textContent = `R${total.toFixed(2)}`;
            checkoutModal.show();
        }

        // Cart icon click handler
        document.getElementById('cartIcon').addEventListener('click', function (e) {
            e.preventDefault();
            if (cart.length > 0) {
                showCheckoutModal();
            } else {
                alert('Your cart is empty. Add some products first!');
            }
        });

        // Confirm order button handler
        document.getElementById("confirmOrder").addEventListener("click", function () {
            const name = document.getElementById("fullName").value.trim();
            const email = document.getElementById("email").value.trim();
            const phone = document.getElementById("phone").value.trim();
            const address = document.getElementById("address").value.trim();
            const payment = document.getElementById("paymentMethod").value;
            const total = document.getElementById("orderTotal").innerText;

            if (!name || !email || !phone || !address || !payment) {
                alert("Please fill in all required fields.");
                return;
            }

            let message = `CUST_6 : ${name}\n`;
            message += `Email: ${email}\n`;
            message += `Phone: ${phone}\n`;
            message += `Address: ${address}\n`;
            message += `Payment Method: ${payment}\n`;
            message += `Total: ${total}\n\n`;
            message += `(Thank you for your order!\nYour order reference number is: ORD-776547)`;

            alert(message);
            checkoutModal.hide();
        });

        function warnNonAdmins() {
            const isAdmin = false; // Replace with actual admin check (e.g., JWT, session)

            if (!isAdmin) {
                alert("Admins only. customer, use UserRegistration.");
                return false; // Block navigation
            }
            return true; // Allow navigation
        }

        document.querySelector('a[href="Admin.aspx"]').addEventListener("click", function (e) {
            // Get the user's role (replace with your actual role check)
            const userRole = localStorage.getItem("userRole"); // or sessionStorage

            // Block farmers
            if (userRole === "customer") {
                e.preventDefault(); // Stop navigation
                alert("Access denied. Admins only.");
                window.location.href = "index.aspx"; // Redirect to home
            }
            // Admins proceed to Admin.aspx automatically
        });
    </script>
</body>
</html>