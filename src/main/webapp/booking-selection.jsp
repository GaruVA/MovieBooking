<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!-- Include header with parameters -->
            <jsp:include page="jsp/header.jsp">
                <jsp:param name="title" value="ABC Cinema" />
                <jsp:param name="css" value="booking-selection.css" />
            </jsp:include>

            <div class="container py-5">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="text-gray-100">Book Movie Tickets</h1>
                    <c:if test="${sessionScope.role eq 'admin'}">
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addShowtimeModal">Add
                            Showtime</button>
                    </c:if>
                </div>
                <div class="card bg-gray-800 border-gray-700 text-gray-100">
                    <div class="card-body">

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                ${error}
                            </div>
                        </c:if>

                        <form id="bookingForm" action="booking-selection" method="get" class="row g-3 mb-4">
                            <div class="col-md-4">
                                <label for="movieSelect" class="form-label">Select Movie</label>
                                <select class="form-select bg-gray-700 text-gray-100 border-gray-600" id="movieSelect"
                                    name="movie_id" onchange="refreshShowtimes()">
                                    <option value="">All Movies</option>
                                    <c:forEach var="movie" items="${movies}">
                                        <option value="${movie.id}" ${param.movie_id==movie.id ? 'selected' : '' }>
                                            ${movie.title}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label for="theatreSelect" class="form-label">Select Theatre</label>
                                <select class="form-select bg-gray-700 text-gray-100 border-gray-600" id="theatreSelect"
                                    name="theatre_id" onchange="refreshShowtimes()">
                                    <option value="">All Theatres</option>
                                    <c:forEach var="theatre" items="${theatres}">
                                        <option value="${theatre.id}" ${param.theatre_id==theatre.id ? 'selected' : ''
                                            }>
                                            ${theatre.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label for="dateSelect" class="form-label">Select Date</label>
                                <input type="date" class="form-control bg-gray-700 text-gray-100 border-gray-600"
                                    id="dateSelect" name="show_date"
                                    value="${empty param.show_date ? todayDate : param.show_date}" min="${todayDate}"
                                    required onchange="refreshShowtimes()">
                            </div>
                        </form>

                        <div id="showtimesList">
                            <c:if test="${empty movieShowtimes}">
                                <div class="alert alert-info" role="alert">
                                    No showtimes available for the selected criteria.
                                </div>
                            </c:if>

                            <c:forEach var="movieEntry" items="${movieShowtimes}">
                                <div class="movie-section mb-3">
                                    <div class="movie-header p-3 bg-gray-700 rounded d-flex justify-content-between align-items-center"
                                        onclick="toggleContent('movie-${movieEntry.key}')">
                                        <h5 class="mb-0">${movieEntry.value.movie.title}</h5>
                                        <i class="bi bi-chevron-down"></i>
                                    </div>

                                    <div class="movie-content p-3 bg-gray-800 border-gray-700"
                                        id="movie-${movieEntry.key}">
                                        <c:forEach var="theatreEntry" items="${movieEntry.value.theatres}">
                                            <div class="theatre-name">${theatreEntry.value.theatre.name}</div>
                                            <c:choose>
                                                <c:when test="${sessionScope.role eq 'admin'}">
                                                    <div class="showtime-grid-admin">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="showtime-grid">
                                                </c:otherwise>
                                            </c:choose>
                                            <c:forEach var="showtime" items="${theatreEntry.value.showtimes}">
                                                <div class="showtime-wrapper">
                                                    <form action="seat-selection" method="get" style="display: inline;">
                                                        <input type="hidden" name="showtime_id" value="${showtime.id}">
                                                        <button type="submit"
                                                            class="btn btn-outline-primary showtime-button">
                                                            <fmt:formatDate value="${showtime.showTime}"
                                                                pattern="HH:mm" />
                                                        </button>
                                                    </form>
                                                    <c:if test="${sessionScope.role eq 'admin'}">
                                                        <button class="btn btn-outline-danger btn-sm ms-2"
                                                            onclick="deleteShowtime(${showtime.id})">
                                                            <i class="bi bi-x"></i>
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </c:forEach>
                                    </div>
                            </c:forEach>
                        </div>
                    </div>
                    </c:forEach>
                </div>
            </div>
            </div>
            </div>

            <!-- Add Showtime Modal -->
            <div class="modal fade" id="addShowtimeModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Add Showtime</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="booking-selection" method="POST">
                            <div class="modal-body">
                                <input type="hidden" name="action" value="add">
                                <div class="mb-3">
                                    <label class="form-label">Movie</label>
                                    <select class="form-select" name="movie_id" required>
                                        <c:forEach var="movie" items="${movies}">
                                            <option value="${movie.id}">${movie.title}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Theatre</label>
                                    <select class="form-select" name="theatre_id" required>
                                        <c:forEach var="theatre" items="${theatres}">
                                            <option value="${theatre.id}">${theatre.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Date</label>
                                    <input type="date" class="form-control" name="show_date" min="${todayDate}"
                                        required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Time</label>
                                    <input type="time" class="form-control" name="show_time" required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-outline-secondary"
                                    data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary">Add Showtime</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Delete Confirmation Modal -->
            <div class="modal fade" id="deleteShowtimeModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Confirm Delete</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            Are you sure you want to delete this showtime?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-secondary"
                                data-bs-dismiss="modal">Cancel</button>
                            <form action="booking-selection" method="POST">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="showtime_id" id="deleteShowtimeId">
                                <button type="submit" class="btn btn-danger">Delete</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Include footer -->
            <jsp:include page="jsp/footer.jsp">
                <jsp:param name="js" value="booking-selection.js" />
            </jsp:include>

            <script>
                function deleteShowtime(showtimeId) {
                    document.getElementById('deleteShowtimeId').value = showtimeId;
                    var deleteModal = new bootstrap.Modal(document.getElementById('deleteShowtimeModal'));
                    deleteModal.show();
                }
            </script>