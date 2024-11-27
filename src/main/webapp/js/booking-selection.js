const contextPath = window.location.pathname.split('/')[1];
const BASE_URL = '/' + contextPath;

// Set today's date as default and minimum date
const today = new Date().toISOString().split('T')[0];
document.getElementById('dateSelect').value = today;
document.getElementById('dateSelect').setAttribute('min', today);

// Function to get URL parameters
function getUrlParameter(name) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
}

// Load movies and theatres on page load
document.addEventListener('DOMContentLoaded', async () => {
    await Promise.all([loadMovies(), loadTheatres()]);
    loadShowtimes();
});

// Load movies
async function loadMovies() {
    try {
        const response = await fetch(BASE_URL + '/movies');
        if (!response.ok) {
            throw new Error('Movies API Error: ' + response.status);
        }
        const movies = await response.json();
        const select = document.getElementById('movieSelect');
        select.innerHTML = '<option value="">All Movies</option>';

        movies.forEach(movie => {
            const option = new Option(movie.title, movie.id);
            select.add(option);
        });

        // Set selected movie if movie_id is in URL
        const selectedMovieId = getUrlParameter('movie_id');
        if (selectedMovieId) {
            select.value = selectedMovieId;
        }
    } catch (error) {
        console.error('Error loading movies:', error);
        const select = document.getElementById('movieSelect');
        select.innerHTML = '<option value="">Error loading movies</option>';
    }
}

// Load theatres
async function loadTheatres() {
    try {
        const response = await fetch(BASE_URL + '/theatres');
        if (!response.ok) {
            throw new Error('Theatres API Error: ' + response.status);
        }
        const theatres = await response.json();
        const select = document.getElementById('theatreSelect');
        select.innerHTML = '<option value="">All Theatres</option>';

        theatres.forEach(theatre => {
            const option = new Option(theatre.name, theatre.id);
            select.add(option);
        });
        
        const selectedTheatreId = getUrlParameter('theatre_id');
        if (selectedTheatreId) {
            select.value = selectedTheatreId;
        }
    } catch (error) {
        console.error('Error loading theatres:', error);
        const select = document.getElementById('theatreSelect');
        select.innerHTML = '<option value="">Error loading theatres</option>';
    }
}

// Load showtimes
async function loadShowtimes() {
    const movieId = document.getElementById('movieSelect').value;
    const theatreId = document.getElementById('theatreSelect').value;
    const showDate = document.getElementById('dateSelect').value;

    // Show loading state
    document.getElementById('showtimesList').innerHTML = `
                    <div class="loading">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </div>
                `;

    try {
        let url = BASE_URL + '/showtimes?show_date=' + encodeURIComponent(showDate);

        // Explicitly add parameters only if they are non-empty
        if (movieId && movieId !== '') {
            url += '&movie_id=' + encodeURIComponent(movieId);
        }

        if (theatreId && theatreId !== '') {
            url += '&theatre_id=' + encodeURIComponent(theatreId);
        }

        const response = await fetch(url);
        if (!response.ok) {
            throw new Error('Showtimes API Error: ' + response.status);
        }
        const showtimes = await response.json();

        // Group showtimes by movie and theatre
        const movieMap = new Map();

        showtimes.forEach(showtime => {
            if (!movieMap.has(showtime.movie.id)) {
                movieMap.set(showtime.movie.id, {
                    movie: showtime.movie,
                    theatres: new Map()
                });
            }

            const movieData = movieMap.get(showtime.movie.id);
            if (!movieData.theatres.has(showtime.theatre.id)) {
                movieData.theatres.set(showtime.theatre.id, {
                    theatre: showtime.theatre,
                    showtimes: []
                });
            }

            movieData.theatres.get(showtime.theatre.id).showtimes.push(showtime);
        });

        // Generate HTML
        const container = document.getElementById('showtimesList');
        container.innerHTML = '';

        if (movieMap.size === 0) {
            container.innerHTML = `
                            <div class="alert alert-info" role="alert">
                                No showtimes available for the selected criteria.
                            </div>
                        `;
            return;
        }

        movieMap.forEach((movieData) => {
            const movieDiv = document.createElement('div');
            movieDiv.className = 'movie-section mb-3';

            const movieContent = document.createElement('div');
            movieContent.className = 'movie-content p-3';

            const movieHeader = document.createElement('div');
            movieHeader.className = 'movie-header p-3 bg-light rounded d-flex justify-content-between align-items-center';
            movieHeader.innerHTML =
                    '<h5 class="mb-0">' + movieData.movie.title + '</h5>' +
                    '<i class="bi bi-chevron-down"></i>';

            movieData.theatres.forEach(function (theatreData) {
                const theatreDiv = document.createElement('div');
                theatreDiv.innerHTML =
                        '<div class="theatre-name">' + theatreData.theatre.name + '</div>' +
                        '<div class="showtime-grid">' +
                        theatreData.showtimes.map(function (showtime) {
                            return '<button class="btn btn-outline-primary showtime-button" ' +
                                    'onclick="bookShowtime( ' + showtime.id + ' )">' +
                                    new Date('1970-01-01T' + showtime.showTime).toLocaleTimeString([], {
                                hour: '2-digit',
                                minute: '2-digit'
                            }) +
                                    '</button>';
                        }).join('') +
                        '</div>';
                movieContent.appendChild(theatreDiv);
            });


            movieHeader.addEventListener('click', () => {
                const isHidden = movieContent.style.display === 'none';
                movieContent.style.display = isHidden ? 'block' : 'none';
                movieHeader.querySelector('i').classList.toggle('bi-chevron-up');
                movieHeader.querySelector('i').classList.toggle('bi-chevron-down');
            });

            movieDiv.appendChild(movieHeader);
            movieDiv.appendChild(movieContent);
            container.appendChild(movieDiv);
        });

    } catch (error) {
        console.error('Error loading showtimes:', error);
        document.getElementById('showtimesList').innerHTML = `
                        <div class="alert alert-danger" role="alert">
                            Error loading showtimes. Please try again later.
                        </div>
                    `;
    }
}

// Booking function (placeholder)
function bookShowtime(showtimeId) {
    alert('Booking showtime ' + showtimeId);
    // Add your booking logic here
}

// Add event listeners for filters
document.getElementById('movieSelect').addEventListener('change', loadShowtimes);
document.getElementById('theatreSelect').addEventListener('change', loadShowtimes);
document.getElementById('dateSelect').addEventListener('change', loadShowtimes);

