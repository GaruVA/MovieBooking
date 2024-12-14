<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Include header with parameters -->
<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="css" value="home.css" />
    <jsp:param name="activePage" value="movies" />
</jsp:include>

<div class="container mt-4 mb-4">
    <h2 class="title mb-4">Movies</h2>

    <nav aria-label="breadcrumb" class="d-flex justify-content-end">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="./index.jsp">HOME</a></li>
            <li class="breadcrumb-item active" aria-current="page">MOVIES</li>
        </ol>
    </nav>

    <!-- Admin Controls -->
    <div class="row mb-4">
        <div class="col-12">

            <c:if test="${sessionScope.role eq 'admin'}">
                <button type="button" class="btn btn-outline-primary cs-button" data-bs-toggle="modal" data-bs-target="#addMovieModal">
                    Add New Movie
                </button>
            </c:if>
        </div>
    </div>

    <div class="row">
        <!-- Card 1 -->
        <c:if test="${not empty error}">
            <div class="col-12">
                <p class="text-center text-danger">${error}</p>
            </div>
        </c:if>

        <c:if test="${empty movies}">
            <div class="col-12">
                <p class="text-center">No Movies Available.</p>
            </div>
        </c:if>
        <c:forEach var="movie" items="${movies}">
            <div class="col-md-3">
                <div class="card">
                    <img src="${empty movie.image_path ? './images/placeholder.png' : movie.image_path}" class="card-img-top" alt="${movie.title}">
                    <div class="card-body">
                        <h5 class="card-title">${movie.title}</h5>
                        <div class="movie-imdb">
                            <i class="ri-star-s-fill"></i>${movie.imdb_rating}
                        </div>
    <!--                        <p class="card-text">${movie.description}</p>-->
                        <center> <a href="./information?movie_id=${movie.id}" class="btn btn-outline-light"> More Info </a>
                            <a href="#" class="btn btn-outline-light"> Book Now </a></center>

                        <div class="admin-controls mt-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <c:if test="${sessionScope.role eq 'admin'}">
                                    <div>
                                        <button class="btn btn-outline-light btn-sm me-2" onclick="editMovie(${movie.id}, '${movie.title}', '${movie.genre}', '${movie.description}', '${movie.imdb_rating}', '${movie.duration}', '${movie.image_path}', '${movie.release_date}', '${movie.status}', '${movie.actor1}', '${movie.actor2}', '${movie.actor3}', '${movie.character1}', '${movie.character2}', '${movie.character3}', '${movie.director}', '${movie.produce}', '${movie.writer}', '${movie.music}')" >

                                            <i class="bi bi-pencil-square"></i> Edit
                                        </button>
                                        <button class="btn btn-outline-danger btn-sm" onclick="deleteMovie(${movie.id})">
                                            <i class="bi bi-trash"></i> Delete
                                        </button>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Add Movie Modal -->
<c:if test="${sessionScope.role eq 'admin'}">
    <div class="modal fade" id="addMovieModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Movie</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="movies" method="POST" enctype="multipart/form-data">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="add">
                        <div class="mb-3">
                            <label class="form-label">Movie Title</label>
                            <input type="text" class="form-control" name="title" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Genre</label>
                            <input type="text" class="form-control" name="genre" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <input type="text" class="form-control" name="description" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">IMDB Rating</label>
                            <input type="text" class="form-control" name="imdb_rating" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Duration</label>
                            <input type="text" class="form-control" name="duration" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Movie Image</label>
                            <input type="file" class="form-control" name="image" accept="image/*">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Release Date</label>
                            <input type="date" class="form-control" name="release_date" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Status</label>
                            <select class="form-select" name="status" required>
                                <option value="Now Showing">Now Showing</option>
                                <option value="Coming Soon">Coming Soon</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Actor 1</label>
                            <input type="text" class="form-control" name="actor1">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Actor 2</label>
                            <input type="text" class="form-control" name="actor2">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Actor 3</label>
                            <input type="text" class="form-control" name="actor3">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Character 1</label>
                            <input type="text" class="form-control" name="character1">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Character 2</label>
                            <input type="text" class="form-control" name="character2">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Character 3</label>
                            <input type="text" class="form-control" name="character3">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Director</label>
                            <input type="text" class="form-control" name="director">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Produce</label>
                            <input type="text" class="form-control" name="produce">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Writer</label>
                            <input type="text" class="form-control" name="writer">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Music</label>
                            <input type="text" class="form-control" name="music">
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add Movie</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Movie Modal -->
    <div class="modal fade" id="editMovieModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-light">
                    <h5 class="modal-title">Edit Movie</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="movies" method="POST" enctype="multipart/form-data">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="movieId" id="editMovieId">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Movie Title</label>
                                    <input type="text" class="form-control" name="title" id="editMovieTitle" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Genre</label>
                                    <input type="text" class="form-control" name="genre" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Description</label>
                                    <input type="text" class="form-control" name="description" id="editMovieDescription" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">IMDB Rating</label>
                                    <input type="text" class="form-control" name="imdb_rating" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Duration</label>
                                    <input type="text" class="form-control" name="duration" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Release Date</label>
                                    <input type="date" class="form-control" name="release_date" id="editMovieRelease_date" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Status</label>
                                    <select class="form-select" name="status" id="editMovieStatus" required>
                                        <option value="Now Showing">Now Showing</option>
                                        <option value="Coming Soon">Coming Soon</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Actor 1</label>
                                    <input type="text" class="form-control" name="actor1">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Actor 2</label>
                                    <input type="text" class="form-control" name="actor2">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Actor 3</label>
                                    <input type="text" class="form-control" name="actor3">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Character 1</label>
                                    <input type="text" class="form-control" name="character1">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Character 2</label>
                                    <input type="text" class="form-control" name="character2">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Character 3</label>
                                    <input type="text" class="form-control" name="character3">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Director</label>
                                    <input type="text" class="form-control" name="director">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Produce</label>
                                    <input type="text" class="form-control" name="produce">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Writer</label>
                                    <input type="text" class="form-control" name="writer">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Music</label>
                                    <input type="text" class="form-control" name="music">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Update Movie Image</label>
                                    <input type="file" class="form-control" name="image" accept="image/*" id="editImageInput">
                                    <small class="text-muted">Leave empty to keep current image</small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="text-center">
                                    <label class="form-label fw-bold">Current Image</label>
                                    <img id="currentMovieImage" src="" 
                                         class="img-fluid rounded shadow-sm" 
                                         style="max-height: 200px; object-fit: cover;"
                                         alt="Current movie image">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer bg-light">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteMovieModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirm Delete</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete this Movie?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form action="movies" method="POST">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="movieId" id="deleteMovieId">
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</c:if>

<jsp:include page="jsp/footer.jsp">
    <jsp:param name="js" value="movies.js" />
</jsp:include>