<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="Movies" />
    <jsp:param name="css" value="movies.css" />
    <jsp:param name="activePage" value="movies" />
</jsp:include>

<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="text-gray-100">Movies</h1>
        <c:if test="${sessionScope.role eq 'admin'}">
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addMovieModal">Add New Movie</button>
        </c:if>
    </div>
    <div class="row g-4">
        <c:forEach var="movie" items="${movies}">
            <div class="col-md-3 col-sm-6">
                <a href="./information?movie_id=${movie.id}">
                    <div class="rounded-lg border text-card-foreground shadow-sm w-full max-w-sm mx-auto bg-gray-800 border-gray-700 overflow-hidden transition-shadow duration-300 hover:shadow-lg" style="border-color: #374151 !important;">
                        <div class="p-0 relative">
                            <img alt="${movie.title}" loading="lazy" width="300" height="450" decoding="async" data-nimg="1" class="w-full h-auto" src="${empty movie.image_path ? './images/placeholder.png' : movie.image_path}" style="color: transparent;">
                            <div class="absolute bottom-0 left-0 right-0 p-4" style="background: linear-gradient(to top, rgba(0, 0, 0, 0.9), rgba(0, 0, 0, 0.6));">
                                <h3 class="text-lg font-semibold mb-1 text-white">${movie.title}</h3>
                                <p class="text-sm text-gray-300">Release: ${movie.release_date}</p>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>

        <c:if test="${empty movies}">
            <p class="text-gray-100">No movies available.</p>
        </c:if>
    </div>
</div>

<!-- Add New Movie Modal -->
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
                            <label class="form-label">Actors</label>
                            <input type="text" class="form-control" name="actors">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Characters</label>
                            <input type="text" class="form-control" name="characters">
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
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add Movie</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</c:if>

<br>

<!-- Include footer with parameters -->
<%@ include file="jsp/footer.jsp"%>

<script>
    document.getElementById('addMovieModal').addEventListener('hidden.bs.modal', function () {
        document.querySelector('.modal-backdrop').remove();
    });
</script>