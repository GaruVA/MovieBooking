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
    <div class="container">
        <h1>Payment Successful!</h1>
        <p>Thank you for your booking. Your payment has been processed successfully.</p>
        
        <!-- Display booking details -->
        <div class="booking-details">
            <p><strong>Selected Seats:</strong> ${selectedSeats}</p>
            <p><strong>Total Price:</strong> $${totalPrice}</p>
            <p><strong>Showtime ID:</strong> ${showtime_id}</p>
            <p><strong>Payment Method:</strong> ${paymentMethod}</p>
            <p><strong>Payment Status:</strong> ${paymentStatus}</p>
        </div>

        <!-- Back to home button -->
        <p>
            <a href="http://localhost:8080/moviebooking/" class="button">Back to Home</a>
        </p>
    </div>

    <!-- Include footer -->
    <jsp:include page="jsp/footer.jsp">
        <jsp:param name="js" value="booking-selection.js" />
    </jsp:include>
</body>
</html>
