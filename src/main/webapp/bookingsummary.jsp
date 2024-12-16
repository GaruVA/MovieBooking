<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="css" value="bookingsummary.css" />
    <jsp:param name="activePage" value="bookingsummary" />   
</jsp:include>

<div class="booking-summary" id="bookingSummary">
    <div class="summary-header">
        <h1>Booking Summary</h1>
    </div>
    
    <div class="summary-body">
        <p>Your booking has been confirmed and an e-ticket has been sent to your email!</p>
        
        <p><strong>Booking ID:</strong> <span>${booking.bookingId}</span></p>
        <p><strong>Movie Name:</strong> <span>${booking.movieTitle}</span></p>
        <p><strong>Date:</strong> <span>${booking.showtime.split(" ")[0]}</span></p>
        <p><strong>Time:</strong> <span>${booking.showtime.split(" ")[1]}</span></p>
        <p><strong>Seat Numbers:</strong> <span>${booking.seatNumbers}</span></p>
        <p><strong>Amount Paid:</strong> <span>$${booking.amount}</span></p>
        <p><strong>Payment Method:</strong> <span>${booking.paymentMethod}</span></p>
        <p><strong>Status:</strong> <span>${booking.status}</span></p>
    </div>
    
    <div class="summary-footer">
        <p>Booking Date & Time: <span>${booking.paymentDate}</span></p>
        <p>An e-ticket has been sent to: <span>${userEmail}</span></p>
    </div>
</div>

<%@ include file="jsp/footer.jsp"%>
