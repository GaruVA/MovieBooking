<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="jsp/header.jsp">
        <jsp:param name="title" value="ABC Cinema - Payment Confirmation" />
        <jsp:param name="css" value="success.css" />
    </jsp:include>
    <title>Payment Success</title>
</head>
<body>
    <div class="container py-5 text-gray-100">
        <h1>Payment Successful!</h1>
        <p>Thank you for your booking. Your payment has been processed successfully.</p>
        
        <!-- Display booking details -->
        <div class="booking-summary bg-gray-800 text-gray-100" id="bookingSummary">            
            <div class="summary-body">
                <p>Your booking has been confirmed and an e-ticket has been sent to your email!</p>
                
                <table class="booking-details-table">
                    <tr>
                        <th>Booking ID:</th>
                        <td>${booking.bookingId}</td>
                    </tr>
                    <tr>
                        <th>Movie Name:</th>
                        <td>${booking.movieTitle}</td>
                    </tr>
                    <tr>
                        <th>Date:</th>
                        <td>${booking.showtime.split(" ")[0]}</td>
                    </tr>
                    <tr>
                        <th>Time:</th>
                        <td>${booking.showtime.split(" ")[1]}</td>
                    </tr>
                    <tr>
                        <th>Seat Numbers:</th>
                        <td>${booking.seatNumbers}</td>
                    </tr>
                    <tr>
                        <th>Amount Paid:</th>
                        <td>$${booking.amount}</td>
                    </tr>
                    <tr>
                        <th>Payment Method:</th>
                        <td>${booking.paymentMethod}</td>
                    </tr>
                    <tr>
                        <th>Status:</th>
                        <td>${booking.status}</td>
                    </tr>
                </table>
            </div>
            
            <div class="summary-footer">
                <p>Booking Date & Time: <span>${booking.paymentDate}</span></p>
                <p>An e-ticket has been sent to: <span>${booking.userEmail}</span></p>
            </div>
        </div>

        <!-- Back to home button -->
        <p>
            <a href="http://localhost:8080/moviebooking/" class="btn btn-primary">Back to Home</a>
        </p>
    </div>

    <!-- Include footer -->
    <jsp:include page="jsp/footer.jsp">
        <jsp:param name="js" value="booking-selection.js" />
    </jsp:include>
</body>
</html>
