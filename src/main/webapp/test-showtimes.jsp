<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Showtimes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Test Showtimes</h2>

        <div class="row mt-4">
            <div class="col-md-4">
                <div class="mb-3">
                    <label for="movieSelect" class="form-label">Select Movie:</label>
                    <select class="form-select" id="movieSelect">
                        <option value="">All Movies</option>
                    </select>
                </div>
            </div>

            <div class="col-md-4">
                <div class="mb-3">
                    <label for="theatreSelect" class="form-label">Select Theatre:</label>
                    <select class="form-select" id="theatreSelect">
                        <option value="">All Theatres</option>
                    </select>
                </div>
            </div>

            <div class="col-md-4">
                <div class="mb-3">
                    <label for="dateSelect" class="form-label">Select Date:</label>
                    <input type="date" class="form-control" id="dateSelect">
                </div>
            </div>
        </div>

        <div class="row mt-3">
            <div class="col-12">
                <button class="btn btn-primary" onclick="loadShowtimes()">Load Showtimes</button>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        API Response Data (for debugging)
                    </div>
                    <div class="card-body">
                        <h5>Current Request URL:</h5>
                        <pre id="requestUrl" style="background: #f8f9fa; padding: 10px;"></pre>

                        <h5 class="mt-3">Showtimes Response:</h5>
                        <pre id="showtimesResponse" style="background: #f8f9fa; padding: 10px;"></pre>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        Formatted Showtimes Display
                    </div>
                    <div class="card-body" id="formattedShowtimes">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        const contextPath = window.location.pathname.split('/')[1];
        const BASE_URL = '/' + contextPath;

        // Set today's date as default
        document.getElementById('dateSelect').valueAsDate = new Date();

        document.addEventListener('DOMContentLoaded', function () {
            // Load Movies
            fetch(BASE_URL + '/movies')
                .then(response => response.json())
                .then(data => {
                    const select = document.getElementById('movieSelect');
                    data.forEach(movie => {
                        const option = new Option(movie.title, movie.id);
                        select.add(option);
                    });
                })
                .catch(error => console.error('Error loading movies:', error));

            // Load Theatres
            fetch(BASE_URL + '/theatres')
                .then(response => response.json())
                .then(data => {
                    const select = document.getElementById('theatreSelect');
                    data.forEach(theatre => {
                        const option = new Option(theatre.name, theatre.id);
                        select.add(option);
                    });
                })
                .catch(error => console.error('Error loading theatres:', error));
        });

        function loadShowtimes() {
    // Get values directly and convert to strings
    var movieId = document.getElementById('movieSelect').value || '';
    var theatreId = document.getElementById('theatreSelect').value || '';
    var showDate = document.getElementById('dateSelect').value;

    // Detailed logging
    console.log('Movie ID:', movieId);
    console.log('Theatre ID:', theatreId);
    console.log('Show Date:', showDate);

    // Validate date
    if (!showDate) {
        alert("Please select a date.");
        return;
    }

    // Create URL manually using string concatenation
    var url = BASE_URL + '/showtimes?show_date=' + encodeURIComponent(showDate);
    
    // Explicitly add parameters only if they are non-empty
    if (movieId && movieId !== '') {
        url += '&movie_id=' + encodeURIComponent(movieId);
    }
    
    if (theatreId && theatreId !== '') {
        url += '&theatre_id=' + encodeURIComponent(theatreId);
    }

    // Log the constructed URL
    console.log('Constructed URL:', url);
    document.getElementById('requestUrl').textContent = url;

    // Fetch showtimes
    fetch(url)
        .then(function(response) {
            if (!response.ok) {
                throw new Error('Showtimes API Error: ' + response.status);
            }
            return response.json();
        })
        .then(function(data) {
            // Log raw response data
            console.log('Raw Response Data:', data);

            // Process response
            document.getElementById('showtimesResponse').textContent =
                JSON.stringify(data, null, 2);

            var formattedDiv = document.getElementById('formattedShowtimes');
            if (!data || data.length === 0) {
                formattedDiv.innerHTML = '<div class="alert alert-info">No showtimes available for the selected criteria.</div>';
                return;
            }

            // Group showtimes
            var groupedShowtimes = {};
            data.forEach(function(showtime) {
                // Add defensive checks
                if (!showtime || typeof showtime !== 'object') {
                    console.warn('Invalid showtime entry:', showtime);
                    return;
                }

                var movieId = showtime.movieId || 'unknown';
                var theatreId = showtime.theatreId || 'unknown';

                if (!groupedShowtimes[movieId]) {
                    groupedShowtimes[movieId] = {
                        movieTitle: showtime.movieTitle || 'Unknown Movie',
                        theatres: {}
                    };
                }

                if (!groupedShowtimes[movieId].theatres[theatreId]) {
                    groupedShowtimes[movieId].theatres[theatreId] = {
                        theatreName: showtime.theatreName || 'Unknown Theatre',
                        times: []
                    };
                }

                // Parse time
                var formattedTime = showtime.showTime ? 
                    formatTime(showtime.showTime) : 
                    'Invalid Time';

                groupedShowtimes[movieId].theatres[theatreId].times.push(formattedTime);
            });

            // Generate HTML
            var html = '';
            for (var movieId in groupedShowtimes) {
                var movieData = groupedShowtimes[movieId];
                html += '<div class="movie-section mb-4">' +
                    '<h4 class="mb-3">' + movieData.movieTitle + '</h4>';

                for (var theatreId in movieData.theatres) {
                    var theatreData = movieData.theatres[theatreId];
                    html += '<div class="theatre-section mb-3">' +
                        '<h5 class="mb-2">' + theatreData.theatreName + '</h5>' +
                        '<div class="d-flex flex-wrap gap-2">';

                    html += theatreData.times.map(function(time) {
                        return '<button class="btn btn-outline-primary">' + time + '</button>';
                    }).join('');

                    html += '</div></div>';
                }

                html += '</div>';
            }

            // Only set innerHTML if we have content
            if (html) {
                formattedDiv.innerHTML = html;
            } else {
                formattedDiv.innerHTML = '<div class="alert alert-info">No showtimes found.</div>';
            }
        })
        .catch(function(error) {
            console.error('Error loading showtimes:', error);
            document.getElementById('showtimesResponse').textContent =
                'Error: ' + error.message;
            document.getElementById('formattedShowtimes').innerHTML =
                '<div class="alert alert-danger">Error loading showtimes. Please try again.</div>';
        });
}

// Helper function to format time
function formatTime(timeString) {
    // If timeString is already in a readable format, return it
    if (!timeString) return 'Invalid Time';

    try {
        // Attempt to parse the time string
        var timeParts = timeString.split(':');
        if (timeParts.length >= 2) {
            var hours = parseInt(timeParts[0], 10);
            var minutes = parseInt(timeParts[1], 10);
            
            // Convert to 12-hour format
            var period = hours >= 12 ? 'PM' : 'AM';
            hours = hours % 12;
            hours = hours ? hours : 12; // the hour '0' should be '12'
            
            // Pad minutes with zero if needed
            minutes = minutes < 10 ? '0' + minutes : minutes;
            
            return hours + ':' + minutes + ' ' + period;
        }
        return timeString;
    } catch (error) {
        console.error('Error formatting time:', error);
        return 'Invalid Time';
    }
}
    </script>
</body>
</html>