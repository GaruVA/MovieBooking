<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="jsp/header.jsp">
        <jsp:param name="title" value="ABC Cinema - Payment Confirmation" />
        <jsp:param name="css" value="booking-selection.css" />
    </jsp:include>
    <link rel="stylesheet" type="text/css" href="css/snowflakes.css">
    <link rel="stylesheet" type="text/css" href="css/payment.css"> <!-- Include your styles.css -->
</head>
<body>
    <div style="text-align: center;"> <!-- Centering content using CSS -->
        <h1>Order Summary</h1>
        <p>Selected Seats: ${selectedSeats}</p>
        <p>Total Price: $${totalPrice}</p>
        <p>Showtime ID: ${showtime_id}</p>

        <form action="pay" method="post">
            <input type="hidden" name="selectedSeats" value="${selectedSeats}">
            <input type="hidden" name="totalPrice" value="${totalPrice}">
            <input type="hidden" name="showtime_id" value="${showtime_id}">
            <button type="submit" class="pay-button">Pay with PayPal</button> <!-- Updated button -->
        </form>
    </div>

    <script src="js/snowflakes.js"></script> <!-- Adjust path as necessary -->

    <jsp:include page="jsp/footer.jsp">
        <jsp:param name="js" value="booking-selection.js" />
    </jsp:include>
</body>
</html>