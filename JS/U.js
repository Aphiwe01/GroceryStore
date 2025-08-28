$(window).scroll(function () {
    if ($(this).scrollTop() > 100) {
        $('.nav').addClass('sticky')
    } else {
        $('.nav').removeClass('sticky')
    }
});

document.addEventListener('DOMContentLoaded', function () {
    const searchInput = document.getElementById('navSearchInput');
    const searchButton = document.getElementById('navSearchButton');

    // Function to handle search navigation
    function handleSearch() {
        const searchTerm = searchInput.value.trim().toLowerCase();
        let targetPage = 'search.html'; // Default page

        // Map search terms to pages
        const pageMap = {
            'admin': 'Admin.html',
            'userregistration': 'UserRegistration.html',
            'farmer': 'Farmer.html',
            'home': 'index.html'
        };

        // Check for direct matches
        if (pageMap[searchTerm]) {
            window.location.href = pageMap[searchTerm];
            return;
        }

        // Check for partial matches
        for (const [term, page] of Object.entries(pageMap)) {
            if (searchTerm.includes(term)) {
                window.location.href = page;
                return;
            }
        }

        // If no match found, go to search page with query
        window.location.href = `search.html?q=${encodeURIComponent(searchTerm)}`;
    }

    // Add event listeners
    searchButton.addEventListener('click', handleSearch);
    searchInput.addEventListener('keypress', function (e) {
        if (e.key === 'Enter') {
            handleSearch();
        }
    });
});