<!DOCTYPE html>
<html>
    <head>
        <title>Test Showtimes</title>
        <meta charset="UTF-8">
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
            // Get the context path dynamically
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
                                const option = new Option(movie.title, movie.movieId);
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
                                const option = new Option(theatre.name, theatre.theatreId);
                                select.add(option);
                            });
                        })
                        .catch(error => console.error('Error loading theatres:', error));
            });

            function loadShowtimes() {
                const movieId = document.getElementById('movieSelect').value;
                const theatreId = document.getElementById('theatreSelect').value;
                const showDate = document.getElementById('dateSelect').value;

                let url = `${BASE_URL}/showtimes?show_date=${showDate}`;
                        if (movieId)
                            url += `&movie_id=${movieId}`;
                        if (theatreId)
                            url += `&theatre_id=${theatreId}`;

                        // Display the request URL
                        document.getElementById('requestUrl').textContent = url;

                        fetch(url)
                                .then(response => {
                                    if (!response.ok) {
                                        throw new Error('Showtimes API Error: ' + response.status);
                                    }
                                    return response.json();
                                })
                                .then(data => {
                                    // Display raw response
                                    document.getElementById('showtimesResponse').textContent =
                                            JSON.stringify(data, null, 2);

                                    // Format and display showtimes
                                    const formattedDiv = document.getElementById('formattedShowtimes');
                                    if (data.length === 0) {
                                        formattedDiv.innerHTML = '<div class="alert alert-info">No showtimes available for the selected criteria.</div>';
                                        return;
                                    }

                                    // Group showtimes by movie and theatre
                                    const groupedShowtimes = {};
                                    data.forEach(showtime => {
                                        const movieId = showtime.movieId;
                                        const theatreId = showtime.theatreId;

                                        if (!groupedShowtimes[movieId]) {
                                            groupedShowtimes[movieId] = {
                                                movie: showtime.movie,
                                                theatres: {}
                                            };
                                        }

                                        if (!groupedShowtimes[movieId].theatres[theatreId]) {
                                            groupedShowtimes[movieId].theatres[theatreId] = {
                                                theatre: showtime.theatre,
                                                times: []
                                            };
                                        }

                                        groupedShowtimes[movieId].theatres[theatreId].times.push(
                                                new Date(showtime.showTime).toLocaleTimeString([], {
                                            hour: '2-digit',
                                            minute: '2-digit'
                                        })
                                                );
                                    });

                                    // Generate HTML
                                    let html = '';
                                    for (const movieId in groupedShowtimes) {
                                        const movieData = groupedShowtimes[movieId];
                                        html += '<div class="movie-section mb-4">' +
                                                '<h4 class="mb-3">' + movieData.movie.title + '</h4>';

                                        for (const theatreId in movieData.theatres) {
                                            const theatreData = movieData.theatres[theatreId];
                                            html += '<div class="theatre-section mb-3">' +
                                                    '<h5 class="mb-2">' + theatreData.theatre.name + '</h5>' +
                                                    '<div class="d-flex flex-wrap gap-2">';

                                            html += theatreData.times.map(function (time) {
                                                return '<button class="btn btn-outline-primary">' + time + '</button>';
                                            }).join('');

                                            html += '</div>' +
                                                    '</div>';
                                        }

                                        html += '</div>';
                                    }

                                    formattedDiv.innerHTML = html;

                                })
                                .catch(error => {
                                    console.error('Error loading showtimes:', error);
                                    document.getElementById('showtimesResponse').textContent =
                                            'Error: ' + error.message;
                                    document.getElementById('formattedShowtimes').innerHTML =
                                            '<div class="alert alert-danger">Error loading showtimes. Please try again.</div>';
                                });
                    }
        </script>
    </body>
</html>