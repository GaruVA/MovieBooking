<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .showtime-button {
            width: 120px;
            margin: 5px;
        }
        .movie-header {
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .movie-header:hover {
            background-color: rgba(0,0,0,0.05);
        }
        .theatre-name {
            font-weight: bold;
            margin-top: 15px;
            margin-bottom: 10px;
        }
        .showtime-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
            gap: 10px;
            margin-bottom: 15px;
        }
        .loading {
            text-align: center;
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="card">
            <div class="card-body">
                <h2 class="card-title text-center mb-4">Book Your Movie</h2>
                
                <div class="row g-3 mb-4">
                    <div class="col-md-4">
                        <label for="movieSelect" class="form-label">Select Movie</label>
                        <select class="form-select" id="movieSelect">
                            <option value="">Loading movies...</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="theatreSelect" class="form-label">Select Theatre</label>
                        <select class="form-select" id="theatreSelect">
                            <option value="">Loading theatres...</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="dateSelect" class="form-label">Select Date</label>
                        <input type="date" class="form-control" id="dateSelect">
                    </div>
                </div>
                
                <div id="showtimesList">
                    <div class="loading">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Get the context path dynamically
        const contextPath = window.location.pathname.split('/')[1];
        const BASE_URL = '/' + contextPath;
        
        // Get URL parameters
        const urlParams = new URLSearchParams(window.location.search);
        const urlMovieId = urlParams.get('movie_id');
        
        // Set today's date as default
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('dateSelect').value = today;
        
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
                    const option = new Option(movie.title, movie.movieId);
                    select.add(option);
                    
                    // Set selected movie if specified in URL
                    if (urlMovieId && urlMovieId == movie.movieId) {
                        select.value = movie.movieId;
                    }
                });
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
                    const option = new Option(theatre.name, theatre.theatreId);
                    select.add(option);
                });
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
                let url = BASE_URL + `/showtimes?show_date=${showDate}`;
                if (movieId) url += `&movie_id=${movieId}`;
                if (theatreId) url += `&theatre_id=${theatreId}`;
                
                const response = await fetch(url);
                if (!response.ok) {
                    throw new Error('Showtimes API Error: ' + response.status);
                }
                const showtimes = await response.json();
                
                // Group showtimes by movie and theatre
                const movieMap = new Map();
                
                showtimes.forEach(showtime => {
                    if (!movieMap.has(showtime.movieId)) {
                        movieMap.set(showtime.movieId, {
                            movie: showtime.movie,
                            theatres: new Map()
                        });
                    }
                    
                    const movieData = movieMap.get(showtime.movieId);
                    if (!movieData.theatres.has(showtime.theatreId)) {
                        movieData.theatres.set(showtime.theatreId, {
                            theatre: showtime.theatre,
                            showtimes: []
                        });
                    }
                    
                    movieData.theatres.get(showtime.theatreId).showtimes.push(showtime);
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
                
                movieMap.forEach((movieData, movieId) => {
                    const movieDiv = document.createElement('div');
                    movieDiv.className = 'movie-section mb-3';
                    
                    const movieContent = document.createElement('div');
                    movieContent.className = 'movie-content p-3';
                    
                    const movieHeader = document.createElement('div');
                    movieHeader.className = 'movie-header p-3 bg-light rounded d-flex justify-content-between align-items-center';
                    movieHeader.innerHTML = `
                        <h5 class="mb-0">${movieData.movie.title}</h5>
                        <i class="bi bi-chevron-down"></i>
                    `;
                    
                    movieData.theatres.forEach((theatreData, theatreId) => {
                        const theatreDiv = document.createElement('div');
                        theatreDiv.innerHTML = `
                            <div class="theatre-name">${theatreData.theatre.name}</div>
                            <div class="showtime-grid">
                        theatreData.showtimes.map(showtime => 
    '<button class="btn btn-outline-primary showtime-button" ' +
    'onclick="bookShowtime(' + showtime.showtimeId + ')">' +
    new Date('1970-01-01T' + showtime.showTime).toLocaleTimeString([], {
        hour: '2-digit',
        minute: '2-digit'
    }) +
    '</button>'
).join('')

                            </div>
                        `;
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
            alert(`Booking showtime ${showtimeId}`);
            // Add your booking logic here
        }
        
        // Add event listeners for filters
        document.getElementById('movieSelect').addEventListener('change', loadShowtimes);
        document.getElementById('theatreSelect').addEventListener('change', loadShowtimes);
        document.getElementById('dateSelect').addEventListener('change', loadShowtimes);
    </script>
</body>
</html>