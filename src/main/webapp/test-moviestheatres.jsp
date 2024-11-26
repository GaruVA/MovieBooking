<!DOCTYPE html>
<html>
<head>
    <title>Test Dropdowns</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Test Dropdowns</h2>
        
        <div class="row mt-4">
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="movieSelect" class="form-label">Select Movie:</label>
                    <select class="form-select" id="movieSelect">
                        <option value="">Loading movies...</option>
                    </select>
                </div>
                
                <div class="mb-3">
                    <label for="theatreSelect" class="form-label">Select Theatre:</label>
                    <select class="form-select" id="theatreSelect">
                        <option value="">Loading theatres...</option>
                    </select>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        Selected Values (for testing)
                    </div>
                    <div class="card-body">
                        <p>Selected Movie ID: <span id="selectedMovieId">none</span></p>
                        <p>Selected Theatre ID: <span id="selectedTheatreId">none</span></p>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row mt-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        API Response Data (for debugging)
                    </div>
                    <div class="card-body">
                        <h5>Movies API Response:</h5>
                        <pre id="moviesResponse" style="background: #f8f9fa; padding: 10px;"></pre>
                        
                        <h5 class="mt-3">Theatres API Response:</h5>
                        <pre id="theatresResponse" style="background: #f8f9fa; padding: 10px;"></pre>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Get the context path dynamically
        const contextPath = window.location.pathname.split('/')[1];
        const BASE_URL = '/' + contextPath;

        document.addEventListener('DOMContentLoaded', function() {
            // Function to update the selected values display
            function updateSelectedValues() {
                document.getElementById('selectedMovieId').textContent = 
                    document.getElementById('movieSelect').value || 'none';
                document.getElementById('selectedTheatreId').textContent = 
                    document.getElementById('theatreSelect').value || 'none';
            }

            console.log('Fetching movies from:', BASE_URL + '/movies'); // Debug log

            // Load Movies
            fetch(BASE_URL + '/movies')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Movies API Error: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    // Display raw API response
                    document.getElementById('moviesResponse').textContent = 
                        JSON.stringify(data, null, 2);

                    // Populate dropdown
                    const select = document.getElementById('movieSelect');
                    select.innerHTML = '<option value="">All Movies</option>';
                    
                    data.forEach(movie => {
                        const option = new Option(movie.title, movie.movieId);
                        select.add(option);
                    });
                })
                .catch(error => {
                    console.error('Error loading movies:', error);
                    document.getElementById('moviesResponse').textContent = 
                        'Error: ' + error.message;
                    document.getElementById('movieSelect').innerHTML = 
                        '<option value="">Error loading movies</option>';
                });

            console.log('Fetching theatres from:', BASE_URL + '/theatres'); // Debug log

            // Load Theatres
            fetch(BASE_URL + '/theatres')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Theatres API Error: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    // Display raw API response
                    document.getElementById('theatresResponse').textContent = 
                        JSON.stringify(data, null, 2);

                    // Populate dropdown
                    const select = document.getElementById('theatreSelect');
                    select.innerHTML = '<option value="">All Theatres</option>';
                    
                    data.forEach(theatre => {
                        const option = new Option(theatre.name, theatre.theatreId);
                        select.add(option);
                    });
                })
                .catch(error => {
                    console.error('Error loading theatres:', error);
                    document.getElementById('theatresResponse').textContent = 
                        'Error: ' + error.message;
                    document.getElementById('theatreSelect').innerHTML = 
                        '<option value="">Error loading theatres</option>';
                });

            // Add change event listeners
            document.getElementById('movieSelect').addEventListener('change', updateSelectedValues);
            document.getElementById('theatreSelect').addEventListener('change', updateSelectedValues);
        });
    </script>
</body>
</html>