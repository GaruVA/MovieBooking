<!-- Include header with parameters -->
<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="Your Page Title" />
    <jsp:param name="css" value="style.css" />
</jsp:include>

<div class="card text-bg-dark">
    <img src="./images/i1.jpg" class="card-img" alt="Movie Poster" style="height: 675px; object-fit: cover;">
    <div class="card-img-overlay">
        <h5 class="card-title">The Wild Robot</h5>
        <p class="card-text">An inspiring story of survival and friendship on an uninhabited island.</p>
        <p class="card-text"><small>Last updated 3 mins ago</small></p>
    </div>
</div>

<div class="container text-center">
    <div class="row">
        <!-- Storyline Section -->
        <div class="col">
            <h5 class="card-title">STORY LINE</h5>
            <p>After a shipwreck, an intelligent robot called Roz is stranded on an uninhabited island. To survive the harsh environment, Roz bonds with the island's animals and cares for an orphaned baby goose.</p>

            <!-- Dynamic Star Rating System -->
            <div class="rating-stars">
                <div class="star-rating" data-movie-id="1">
                    <span data-value="1">&#9733;</span>  <!-- First Star -->
                    <span data-value="2">&#9733;</span>  <!-- Second Star -->
                    <span data-value="3">&#9733;</span>  <!-- Third Star -->
                    <span data-value="4">&#9733;</span>  <!-- Fourth Star -->
                    <span data-value="5">&#9733;</span>  <!-- Fifth Star -->
                </div>

            </div>

            <a href="#" class="btn btn-primary mt-3">Buy Ticket</a>
        </div>

        <!-- Cast Section -->
        <div class="col order-5">
            <h5 class="card-title">CAST</h5>
            <h6>Actor Name</h6>
            <p>Character details</p>
        </div>
    </div>
</div>


<!-- JavaScript for dynamic star rating -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const ratingElements = document.querySelectorAll('.star-rating');

        ratingElements.forEach(ratingElement => {
            const stars = Array.from(ratingElement.querySelectorAll('span'));  // Get all the star spans
            const movieId = ratingElement.getAttribute('data-movie-id');
            const ratingDisplay = document.getElementById('rating-value');
            let selectedRating = 0;  // Initialize the rating to 0

            // Highlight stars on hover
            stars.forEach(star => {
                star.addEventListener('mouseover', () => {
                    const hoveredValue = parseInt(star.getAttribute('data-value'));  // Get the hovered star's value

                    // Fill stars from t to right based on the hover
                    stars.forEach(s => {
                        const starValue = parseInt(s.getAttribute('data-value'));
                        s.style.color = starValue <= hoveredValue ? 'gold' : 'lightgray'; // Set color based on hovered value
                    });
                });

                // Reset stars when mouse leaves the rating area
                ratingElement.addEventListener('mouseleave', () => {
                    stars.forEach(s => {
                        const starValue = parseInt(s.getAttribute('data-value'));
                        s.style.color = starValue <= selectedRating ? 'gold' : 'lightgray'; // Reset to current rating
                    });
                });

                // Handle click to set the rating
                star.addEventListener('click', () => {
                    selectedRating = parseInt(star.getAttribute('data-value'));  // Get the clicked star's value

                    // Fill stars from left to right based on the clicked rating
                    stars.forEach(s => {
                        const starValue = parseInt(s.getAttribute('data-value'));
                        s.style.color = starValue <= selectedRating ? 'gold' : 'lightgray';  // Set color to gold if the star is selected
                    });

                    // Update the rating display text with the selected rating
                    if (ratingDisplay) {
                        // Update text to show the rating (e.g., "2 stars" or "1 star")
                        ratingDisplay.textContent = `${selectedRating} star${selectedRating > 1 ? 's' : ''}`;
                                            }

                                            // Send the selected rating to the server
                                            fetch('./submitRating.jsp', {
                                                method: 'POST',
                                                headers: {
                                                    'Content-Type': 'application/x-www-form-urlencoded',
                                                },
                                                body: `movieId=${movieId}&rating=${selectedRating}`,
                                            })
                                                    .then(response => response.text())
                                                    .then(data => {
                                                        console.log('Rating saved:', data);  // Confirm that the rating is saved
                                                    })
                                                    .catch(error => {
                                                        console.error('Error saving rating:', error);  // Error handling
                                                    });
                                        });
                                    });
                                });
                            });


</script>

<!-- Include footer with parameters -->
<jsp:include page="jsp/footer.jsp">
    <jsp:param name="js" value="index.js" />
</jsp:include>
