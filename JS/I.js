
    // Add to cart functionality
    document.querySelectorAll('.add-to-cart').forEach(button => {
        button.addEventListener('click', function () {
            const productName = this.closest('.card-body').querySelector('.card-title').textContent;
            alert(`Successfully added ${productName} to your cart!`);
        });
    });

