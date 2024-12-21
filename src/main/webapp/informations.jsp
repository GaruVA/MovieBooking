<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Include header with parameters -->
<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="css" value="info.css" />
    <jsp:param name="activePage" value="informations" />
</jsp:include>

<div class="container my-5">
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:if test="${empty error}">
        <div class="row">
            <div class="col-md-4 mb-4">
                <img src="${movie.image_path}" alt="${movie.title}" class="img-fluid rounded shadow movie-image">
            </div>
            <div class="col-md-8">
                <h1 class="mb-3">${movie.title}</h1>
                <div class="d-flex align-items-center mb-3">
                    <i class="bi bi-star-fill text-warning me-2"></i>
                    <span class="fs-4">${movie.imdb_rating}/10</span>
                </div>
                <p class="lead">${movie.description}</p>
                
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-6 mb-3">
                                <h5>Status</h5>
                                <p>${movie.status}</p>
                            </div>
                            <div class="col-sm-6 mb-3">
                                <h5>Release Date</h5>
                                <p>${movie.release_date}</p>
                            </div>
                            <div class="col-sm-6 mb-3">
                                <h5>Genre</h5>
                                <p>${movie.genre}</p>
                            </div>
                            <div class="col-sm-6 mb-3">
                                <h5>Duration</h5>
                                <p>${movie.duration}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <h2 class="mb-3">Cast & Crew</h2>
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-6 mb-3">
                                <h5>Director</h5>
                                <p>${movie.director}</p>
                            </div>
                            <div class="col-sm-6 mb-3">
                                <h5>Producer</h5>
                                <p>${movie.produce}</p>
                            </div>
                            <div class="col-sm-6 mb-3">
                                <h5>Writer</h5>
                                <p>${movie.writer}</p>
                            </div>
                            <div class="col-sm-6 mb-3">
                                <h5>Music</h5>
                                <p>${movie.music}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <h5>Actors</h5>
                        <ul class="list-unstyled">
                            <c:forEach var="actor" items="${fn:split(movie.actors, ',')}">
                                <li>${actor}</li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <h5>Characters</h5>
                        <ul class="list-unstyled">
                            <c:forEach var="character" items="${fn:split(movie.characters, ',')}">
                                <li>${character}</li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>

                <div class="mt-4">
                    <a href="./booking-selection?movie_id=${movie.id}" class="btn btn-primary me-2">Book Tickets</a>
                    <c:if test="${sessionScope.role eq 'admin'}">
                        <button class="btn btn-outline-secondary me-2" data-bs-toggle="modal" data-bs-target="#editMovieModal"
                            onclick="populateEditModal(
                                '${movie.id}', 
                                '${movie.title}', 
                                '${movie.genre}', 
                                '${movie.description}', 
                                '${movie.imdb_rating}', 
                                '${movie.duration}', 
                                '${movie.release_date}', 
                                '${movie.status}', 
                                '${movie.actors}', 
                                '${movie.characters}', 
                                '${movie.director}', 
                                '${movie.produce}', 
                                '${movie.writer}', 
                                '${movie.music}', 
                                '${movie.image_path}'
                            )">Edit</button>
                        <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteMovieModal" onclick="setDeleteMovieId(${movie.id})">Delete</button>
                    </c:if>
                </div>
            </div>
        </div>
    </c:if>
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
                                <input type="text" class="form-control" name="genre" id="editMovieGenre" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold">Description</label>
                                <input type="text" class="form-control" name="description" id="editMovieDescription" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">IMDB Rating</label>
                                <input type="text" class="form-control" name="imdb_rating" id="editMovieImdb_Rating" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Duration</label>
                                <input type="text" class="form-control" name="duration" id="editMovieDuration" required>
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
                                <label class="form-label">Actors</label>
                                <input type="text" class="form-control" name="actors" id="editMovieActors">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Characters</label>
                                <input type="text" class="form-control" name="characters" id="editMovieCharacters">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Director</label>
                                <input type="text" class="form-control" name="director" id="editMovieDirector">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Produce</label>
                                <input type="text" class="form-control" name="produce" id="editMovieProduce">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Writer</label>
                                <input type="text" class="form-control" name="writer" id="editMovieWriter">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Music</label>
                                <input type="text" class="form-control" name="music" id="editMovieMusic">
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

<!-- Include footer -->
<jsp:include page="jsp/footer.jsp">
    <jsp:param name="js" value="info.js" />
</jsp:include>

<script>
    // Cleanup modal on hide
    $('#editMovieModal').on('hidden.bs.modal', function () {
        $(this).find('form')[0].reset();
        $('#currentMovieImage').attr('src', '');
    });

    $('#deleteMovieModal').on('hidden.bs.modal', function () {
        $('#deleteMovieId').val('');
    });
</script>
