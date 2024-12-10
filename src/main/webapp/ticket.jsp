<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="css" value="ticket.css" />
    <jsp:param name="activePage" value="ticket" />   
</jsp:include>

<div class="ticket" id="ticket">
    <div class="ticket-header">
        <h1>E-Ticket</h1>
    </div>
    
    <div class="ticket-body">
        <p>Valued Customer, Your Ticket(s) are Confirmed! </p>
        
        <p><strong>Booking ID:</strong> <span>${booking_id}</span></p>
        <p><strong>Movie Name:</strong> <span>${movie_name}</span></p>
        <p><strong>Date:</strong> <span>${date}</span></p>
        <p><strong>Time:</strong> <span>${time}</span></p>
<!--        <p><strong>Seat Number:</strong> <span>${seat_number}</span></p>-->
        <p><strong>Ticket ID:</strong> <span>${ticket_id}</span></p>
        <p><strong>Quantity:</strong> <span>${quantity}</span></p>
        <p><strong>Internet Handling Fees:</strong> <span>${internet_fees}</span></p>
        <p><strong>Amount Paid:</strong> <span>${amount_paid}</span></p>
    </div>
    
    <div class="ticket-footer">
        <p>BOOKING DATE & TIME: <span>${booking_date_time}</span></p>
        <p>PAYMENT TYPE: <span>${payment_type}</span></p>
        <p>CONFIRMATION NUMBER: <span>${confirmation_number}</span></p>
        <p>Thank you for your purchase!</p>

    </div>
</div>

<button id="generateTicket">Generate Ticket</button>

<script>
    document.getElementById('generateTicket').addEventListener('click', function () {
        const bookingId = '${booking_id}'; // Replace with your server-side value
        fetch(`/moviebooking/TicketCTL?bookingId=${booking_id}`, { method: 'POST' })
            .then(response => {
                if (response.ok) {
                    alert("E-Ticket link has been sent to your email!");
                } else {
                    alert("Failed to send the email. Please try again.");
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("An unexpected error occurred.");
            });
    });
</script>


<%@ include file="jsp/footer.jsp"%>