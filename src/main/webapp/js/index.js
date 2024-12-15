document.addEventListener('DOMContentLoaded', () => {
    const stars = document.querySelectorAll('.rating-stars .star');
    const movieId = 1; // Replace with dynamic movie ID
    const userId = 123; // Replace with logged-in user ID

    // Fetch and fill stars based on user rating
    fetch(`/getUserRating?movieId=${movieId}&userId=${userId}`)
        .then(response => response.text())
        .then(rating => {
            if (rating > 0) {
                fillStars(parseInt(rating));
            }
        });

    // Add click event to each star
    stars.forEach(star => {
        star.addEventListener('click', () => {
            const rating = parseInt(star.getAttribute('data-value'));
            fillStars(rating);

            // Submit rating to the backend
            fetch('/submitRating', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `movieId=${movieId}&userId=${userId}&rating=${rating}`
            }).then(response => {
                if (!response.ok) {
                    console.error("Failed to submit rating");
                }
            });
        });
    });

    // Function to fill stars
    function fillStars(rating) {
        stars.forEach((star, index) => {
            star.classList.toggle('filled', index < rating);
        });
    }
});
