<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Include header with parameters -->
<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="activePage" value="movies" />
</jsp:include>


<h1 class="text-center mt-1 mb-1">Movies</h1>

<!-- Admin Controls -->
<div class="row mb-4">
    <div class="col-12">
        <h2 class="title mb-4">Movies</h2>
        <c:if test="${sessionScope.role eq 'admin'}">
            <button type="button" class="btn btn-outline-primary cs-button" data-bs-toggle="modal" data-bs-target="#addMovieModal">
                Add New Movie
            </button>
        </c:if>
    </div>
</div>

<div class="container mt-4 mb-4">
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
                        <p class="card-text">${movie.description}</p>
                        <a href="./information?movie_id=${movie.id}" class="btn btn-primary">More Info</a>

                        <div class="admin-controls mt-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <c:if test="${sessionScope.role eq 'admin'}">
                                    <div>
                                        <button class="btn btn-outline-primary btn-sm me-2" onclick="editMovie(${movie.id}, '${movie.title}', '${movie.description}', '${movie.image_path}')" >
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
                            <input type="text" class="form-control" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <input type="text" class="form-control" name="description" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Movie Image</label>
                            <input type="file" class="form-control" name="image" accept="image/*">
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
                                    <input type="text" class="form-control" name="name" id="editMovieTitle" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Description</label>
                                    <input type="text" class="form-control" name="description" id="editMovieDescription" required>
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



<!-- Include footer -->
<jsp:include page="jsp/footer.jsp" />
</div>