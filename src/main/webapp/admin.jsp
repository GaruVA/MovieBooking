<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <jsp:include page="jsp/header.jsp">
                <jsp:param name="title" value="Admin Panel" />
                <jsp:param name="css" value="admin.css" />
                <jsp:param name="activePage" value="admin" />
            </jsp:include>

            <div class="container py-5">
                <h2 class="title mb-3">ADMIN</h2>
                <div class="row">
                    <div class="col-md-4">
                        <div class="card shadow-sm bg-gray-800 text-gray-100">
                            <div class="card-body">
                                <h5 class="card-title">Number of Movies</h5>
                                <p class="card-text">${movieCount}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card shadow-sm bg-gray-800 text-gray-100">
                            <div class="card-body">
                                <h5 class="card-title">Number of Theatres</h5>
                                <p class="card-text">${theatreCount}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card shadow-sm bg-gray-800 text-gray-100">
                            <div class="card-body">
                                <h5 class="card-title">Total Sales</h5>
                                <p class="card-text">$${totalSales}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-md-6">
                        <div class="card shadow-sm bg-gray-800 text-gray-100">
                            <div class="card-body">
                                <h5 class="card-title">Sales Data</h5>
                                <canvas id="salesChart"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card shadow-sm bg-gray-800 text-gray-100">
                            <div class="card-body">
                                <h5 class="card-title">Customer Feedbacks</h5>
                                <canvas id="feedbackChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm bg-gray-800 text-gray-100">
                            <div class="card-body">
                                <h5 class="card-title">Bookings</h5>
                                <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
                                    <table class="table table-dark table-striped">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>Booking ID</th>
                                                <th>User ID</th>
                                                <th>Movie Title</th>
                                                <th>Theatre Name</th>
                                                <th>Showtime</th>
                                                <th>Seats</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="booking" items="${bookings}">
                                                <tr>
                                                    <td>${booking.bookingId}</td>
                                                    <td>${booking.userId}</td>
                                                    <td>${booking.movieTitle}</td>
                                                    <td>${booking.theatreName}</td>
                                                    <td>${booking.showtime}</td>
                                                    <td>${booking.seatNumbers}</td>
                                                    <td>${booking.status}</td>
                                                    <td>
                                                        <c:if
                                                            test="${booking.status != 'Cancelled' && booking.showtime > now}">
                                                            <form method="post" action="admin" class="d-inline">
                                                                <input type="hidden" name="formType"
                                                                    value="cancelBooking">
                                                                <input type="hidden" name="bookingId"
                                                                    value="${booking.bookingId}">
                                                                <button type="submit" class="btn btn-danger btn-sm">
                                                                    Cancel
                                                                </button>
                                                            </form>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm bg-gray-800 text-gray-100">
                            <div class="card-body">
                                <h5 class="card-title">Users</h5>
                                <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
                                    <table class="table table-dark table-users table-striped">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>User ID</th>
                                                <th>Username</th>
                                                <th>Email</th>
                                                <th>Role</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="user" items="${users}">
                                                <tr>
                                                    <td>${user.userId}</td>
                                                    <td>${user.username}</td>
                                                    <td>${user.email}</td>
                                                    <td>${user.role}</td>
                                                    <td>
                                                        <c:if test="${user.userId != currentUserId}">
                                                            <form method="post" action="admin" class="d-inline">
                                                                <input type="hidden" name="formType" value="makeAdmin">
                                                                <input type="hidden" name="userId"
                                                                    value="${user.userId}">
                                                                <button type="submit"
                                                                    class="btn btn-action make-admin">Make
                                                                    Admin</button>
                                                            </form>
                                                            <form method="post" action="admin" class="d-inline">
                                                                <input type="hidden" name="formType" value="makeUser">
                                                                <input type="hidden" name="userId"
                                                                    value="${user.userId}">
                                                                <button type="submit"
                                                                    class="btn btn-action make-user">Make User</button>
                                                            </form>
                                                            <form method="post" action="admin" class="d-inline">
                                                                <input type="hidden" name="formType" value="deleteUser">
                                                                <input type="hidden" name="userId"
                                                                    value="${user.userId}">
                                                                <button type="submit"
                                                                    class="btn btn-action delete-user">Delete</button>
                                                            </form>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Include Chart.js library -->
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    console.log('Admin panel loaded');

                    // Sales data chart
                    const salesData = ${ salesDataJson }; // Pass sales data as JSON

                    const labels = salesData.map(data => data.date);
                    const sales = salesData.map(data => data.totalSales);

                    const ctx = document.getElementById('salesChart').getContext('2d');
                    new Chart(ctx, {
                        type: 'line',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: 'Total Sales',
                                data: sales,
                                borderColor: 'rgba(75, 192, 192, 1)',
                                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                y: {
                                    beginAtZero: true
                                }
                            }
                        }
                    });

                    // Feedback data chart
                    const feedbackData = ${ feedbackDataJson }; // Pass feedback data as JSON

                    const feedbackLabels = ['5 Stars', '4 Stars', '3 Stars', '2 Stars', '1 Star'];
                    const feedbackCounts = [0, 0, 0, 0, 0];

                    feedbackData.forEach(data => {
                        feedbackCounts[5 - data.rating]++;
                    });

                    const feedbackCtx = document.getElementById('feedbackChart').getContext('2d');
                    new Chart(feedbackCtx, {
                        type: 'bar',
                        data: {
                            labels: feedbackLabels,
                            datasets: [{
                                label: 'Customer Ratings',
                                data: feedbackCounts.map(count => (count / feedbackData.length) * 100),
                                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                borderColor: 'rgba(75, 192, 192, 1)',
                                borderWidth: 1
                            }]
                        },
                        options: {
                            indexAxis: 'y',
                            scales: {
                                x: {
                                    beginAtZero: true,
                                    max: 100,
                                    ticks: {
                                        callback: function (value) {
                                            return value + '%';
                                        }
                                    }
                                }
                            }
                        }
                    });
                });
            </script>
            <jsp:include page="jsp/footer.jsp">
                <jsp:param name="js" value="admin.js" />
            </jsp:include>