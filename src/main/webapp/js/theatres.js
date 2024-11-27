const contextPath = window.location.pathname.split('/')[1];
const BASE_URL = '/' + contextPath;

document.addEventListener("DOMContentLoaded", () => {
    const container = document.getElementById("theatre-container");
    const servletUrl = BASE_URL + "/theatres";

    // Fetch data from the servlet
    fetch(servletUrl)
            .then(response => {
                if (!response.ok) {
                    throw new Error("Failed to fetch theatres.");
                }
                return response.json(); // Parse the JSON response
            })
            .then(data => {
                if (data && data.length > 0) {
                    renderTheatres(data);
                } else {
                    container.innerHTML = "<p class='text-center'>No theatres available.</p>";
                }
            })
            .catch(error => {
                console.error("Error fetching theatres:", error);
                container.innerHTML = "<p class='text-center text-danger'>Error loading theatres. Please try again later.</p>";
            });

    // Function to render theatres
    function renderTheatres(theatres) {
        theatres.forEach(theatre => {
            const col = document.createElement("div");
            col.className = "col-md-4";

            const imageUrl = theatre.image_path || "./images/placeholder.png"; // Use default image if none provided
            col.innerHTML = `
            <div class="card theatre-card shadow-sm" onclick="redirectToTheatre(${theatre.id})">
                <img src="${theatre.image_path}" class="card-img-top" alt="${theatre.name}">
                <div class="card-body">
                    <h5 class="card-title">${theatre.name}</h5>
                    <p class="card-text">${theatre.location}</p>
                </div>
            </div>
        `;
            container.appendChild(col);
        });
    }
});
function redirectToTheatre(theatreId) {
    window.location.href = `booking-selection.jsp?theatre_id=${theatreId}`;
}
