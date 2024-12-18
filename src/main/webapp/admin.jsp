<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="Admin Panel" />
    <jsp:param name="css" value="admin.css" />
    <jsp:param name="activePage" value="admin" />
</jsp:include>

<div class="container py-5">
    <h2 class="title mb-3">ANALYTICS</h2>
    <div class="row">
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Number of Movies</h5>
                    <p class="card-text">${movieCount}</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Number of Theatres</h5>
                    <p class="card-text">${theatreCount}</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Total Sales</h5>
                    <p class="card-text">$${totalSales}</p>
                </div>
            </div>
        </div>
    </div>
    <div class="row mt-4">
        <div class="col-md-12">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Sales Data</h5>
                    <canvas id="salesChart"></canvas>
                </div>
            </div>
        </div>
    </div>
    <div class="row mt-4">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Customer Feedbacks</h5>
                    <ul class="list-group">
                        <c:forEach var="feedback" items="${feedbacks}">
                            <li class="list-group-item">${feedback}</li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-body">
                    <table class="table table-striped table-bordered shadow-sm">
                        <thead class="table-dark">
                            <tr>
                                <th>Metric</th>
                                <th>Value</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Average Rating</td>
                                <td>${averageRating}</td>
                            </tr>
                            <tr>
                                <td>Most Selected Theatre</td>
                                <td>${mostSelectedTheatre}</td>
                            </tr>
                            <tr>
                                <td>Most Selected Movie</td>
                                <td>${mostSelectedMovie}</td>
                            </tr>
                            <tr>
                                <td>Preferred Time Slot</td>
                                <td>${preferredTimeSlot}</td>
                            </tr>
                            <!-- Add more analytics rows as needed -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Include Chart.js library -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        console.log('Admin panel loaded');

        // Sales data chart
        const salesData = ${salesDataJson}; // Pass sales data as JSON

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
    });
</script>
<jsp:include page="jsp/footer.jsp">
    <jsp:param name="js" value="admin.js" />
</jsp:include>
