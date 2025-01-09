<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <jsp:include page="jsp/header.jsp">
            <jsp:param name="title" value="ABC Cinema" />
            <jsp:param name="css" value="theatres.css" />
            <jsp:param name="activePage" value="theatres" />
        </jsp:include>

        <div class="container">

            <!-- Admin Controls -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="text-gray-100">Theatres</h1>
                <c:if test="${sessionScope.role eq 'admin'}">
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addTheatreModal">Add New Theatre</button>
                </c:if>
            </div>

            <!-- Error Messages -->
            <c:if test="${not empty error}">
                <div class="col-12">
                    <div class="alert alert-danger">${error}</div>
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="col-12">
                    <div class="alert alert-success">${success}</div>
                </div>
            </c:if>

            <div class="row g-4">
                <c:if test="${empty theatres}">
                    <div class="col-12">
                        <p class="text-center">No theatres available.</p>
                    </div>
                </c:if>

                <c:forEach var="theatre" items="${theatres}">
                    <div class="col-md-4 col-sm-6">
                        <div class="rounded-lg border text-card-foreground shadow-sm w-full max-w-sm mx-auto bg-gray-800 border-gray-700 overflow-hidden transition-shadow duration-300 hover:shadow-lg hover:shadow-gray-700/50"
                            style="border: 1px solid #374151 !important;">
                            <div class="p-0 relative">
                                <img src="${empty theatre.imagePath ? './images/placeholder.png' : theatre.imagePath}"
                                    alt="${theatre.name}" class="w-full h-auto" style="color: transparent;">
                                <div class="absolute bottom-0 left-0 right-0 p-4"
                                    style="background: linear-gradient(to top, rgba(0, 0, 0, 0.9), rgba(0, 0, 0, 0.6));">
                                    <h3 class="text-lg font-semibold mb-1 text-gray-100">${theatre.name}</h3>
                                    <p class="text-sm text-gray-400">${theatre.location}</p>
                                </div>
                            </div>
                            <div class="flex justify-between items-center p-4 bg-gray-700">
                                <c:if test="${sessionScope.role eq 'admin'}">
                                    <div>
                                        <button class="btn btn-outline-secondary me-2"
                                            onclick="editTheatre(${theatre.id}, '${theatre.name}', '${theatre.location}', '${theatre.imagePath}')">
                                            Edit
                                        </button>
                                        <button class="btn btn-danger"
                                            onclick="deleteTheatre(${theatre.id})">
                                            Delete
                                        </button>
                                        </div>
                                </c:if>
                                <button class="btn btn-primary cs-button text-white"
                                    onclick="window.location.href = 'booking-selection?theatre_id=${theatre.id}'">
                                    Book Now
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Add Theatre Modal -->
        <c:if test="${sessionScope.role eq 'admin'}">
            <div class="modal fade" id="addTheatreModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Add New Theatre</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="theatres" method="POST" enctype="multipart/form-data">
                            <div class="modal-body">
                                <input type="hidden" name="action" value="add">
                                <div class="mb-3">
                                    <label class="form-label">Theatre Name</label>
                                    <input type="text" class="form-control" name="name" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Location</label>
                                    <input type="text" class="form-control" name="location" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Theatre Image</label>
                                    <input type="file" class="form-control" name="image" accept="image/*">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-outline-secondary"
                                    data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary">Add Theatre</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Edit Theatre Modal -->
            <div class="modal fade" id="editTheatreModal" tabindex="-1">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header bg-light">
                            <h5 class="modal-title">Edit Theatre</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="theatres" method="POST" enctype="multipart/form-data">
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <input type="hidden" name="action" value="edit">
                                        <input type="hidden" name="theatreId" id="editTheatreId">
                                        <div class="mb-3">
                                            <label class="form-label fw-bold">Theatre Name</label>
                                            <input type="text" class="form-control" name="name" id="editTheatreName"
                                                required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label fw-bold">Location</label>
                                            <input type="text" class="form-control" name="location"
                                                id="editTheatreLocation" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label fw-bold">Update Theatre Image</label>
                                            <input type="file" class="form-control" name="image" accept="image/*"
                                                id="editImageInput">
                                            <small class="text-muted">Leave empty to keep current image</small>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="text-center">
                                            <label class="form-label fw-bold">Current Image</label>
                                            <img id="currentTheatreImage" src="" class="img-fluid rounded shadow-sm"
                                                style="max-height: 200px; object-fit: cover;"
                                                alt="Current theatre image">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer bg-light">
                                <button type="button" class="btn btn-outline-secondary"
                                    data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Delete Confirmation Modal -->
            <div class="modal fade" id="deleteTheatreModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Confirm Delete</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            Are you sure you want to delete this theatre?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <form action="theatres" method="POST">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="theatreId" id="deleteTheatreId">
                                <button type="submit" class="btn btn-danger">Delete</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <jsp:include page="jsp/footer.jsp">
            <jsp:param name="js" value="theatres.js" />
        </jsp:include>