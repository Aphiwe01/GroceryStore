
    // Search functionality
    document.querySelector('.search-btn').addEventListener('click', function() {
      const searchTerm = document.querySelector('.search-input').value.toLowerCase();

    // Define search mappings
    const searchMap = {
        'admin': 'Admin.html',
    'farmer': 'Farmer.html',
    'userregistration': 'UserRegistration.html',
    'home': 'index.html'
      };

    // Check if search term matches any page
    if (searchTerm in searchMap) {
        window.location.href = searchMap[searchTerm];
      } else {
        alert('No matching page found. Try: Admin, Farmer, UserRegistration, or Home');
      }
    });

    // Allow Enter key to trigger search
    document.querySelector('.search-input').addEventListener('keypress', function(e) {
      if (e.key === 'Enter') {
        document.querySelector('.search-btn').click();
      }
    });

    // Initialize carousel with auto-rotation
    document.addEventListener('DOMContentLoaded', function() {
      const myCarousel = new bootstrap.Carousel(document.getElementById('productsCarousel'), {
        interval: 5000,
    wrap: true
      });
    });
