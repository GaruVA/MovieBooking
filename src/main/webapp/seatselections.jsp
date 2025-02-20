<%@ page import="com.mycompany.moviebooking.model.Seat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="css" value="seatselection.css" />
    <jsp:param name="activePage" value="seatCTL" />
</jsp:include>
<div class="container">
    <c:if test="${error != null && not empty error}">
        <div class="alert alert-danger mt-3">${error}</div>
    </c:if>
    <div class="theater bg-gray-800 text-gray-100">
        <h1>Select Your Seats</h1>
        <div class="ticket-info">
            <label for="adults">Adults:</label>
            <select id="adults" name="adults" class="bg-gray-700 text-gray-100 border-gray-600" onchange="handleDropdownChange()">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
            </select>
            <label for="children">Children:</label>
            <select id="children" name="children" class="bg-gray-700 text-gray-100 border-gray-600" onchange="handleDropdownChange()">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
            </select>
            <p>Ticket Price: $5 (Adult), $3 (Child)</p>
        </div>
        <div class="screen bg-gray-700">Screen</div>
        <div class="seats">
            <%
                int rows = 5;
                int cols = 5;
                Map<String, Object> seatStatusMap = new HashMap<>();
                if (request.getAttribute("seatDetails") != null) {
                    List<Seat> seatDetails = (List<Seat>) request.getAttribute("seatDetails");
                    if (!seatDetails.isEmpty()) {
                        for (Seat seat : seatDetails) {
                            seatStatusMap.put(seat.getSeatNumber(), seat);
                        }
                    }
                }
                for (int i = 1; i <= rows; i++) {
                    out.print("<div class='row'>");
                    for (int j = 1; j <= cols; j++) {
                        String seatNumber = "L" + i + "C" + j;
                        Seat details = (Seat) seatStatusMap.get(seatNumber);
                        if (details != null) {
                            if (details.getSeatNumber().equals(seatNumber) && (details.getSeatStatus().equals("Booked") || details.getSeatStatus().equals("Temp Booked"))) {
                                out.print("<div class='seat booked non-clickable' id='" + seatNumber + "'>");
                            } else {
                                out.print("<div class='seat' id='" + seatNumber + "' onclick='toggleSeat(this)'>");
                            }
                        } else {
                            out.print("<div class='seat' id='" + seatNumber + "' onclick='toggleSeat(this)'>");
                        }
                        out.print(seatNumber);
                        out.print("</div>");
                    }
                    out.print("<div class='staircase'></div>");
                    for (int j = 1; j <= cols; j++) {
                        String seatNumber = "R" + i + "C" + j;
                        Seat details = (Seat) seatStatusMap.get(seatNumber);
                        if (details != null) {
                            if (details.getSeatNumber().equals(seatNumber) && (details.getSeatStatus().equals("Booked") || details.getSeatStatus().equals("Temp Booked"))) {
                                out.print("<div class='seat booked non-clickable' id='" + seatNumber + "'>");
                            } else {
                                out.print("<div class='seat' id='" + seatNumber + "' onclick='toggleSeat(this)'>");
                            }
                        } else {
                            out.print("<div class='seat' id='" + seatNumber + "' onclick='toggleSeat(this)'>");
                        }
                        out.print(seatNumber);
                        out.print("</div>");
                    }
                    out.print("</div>");
                }
            %>
        </div>
        <p id="seatCount" class="seat-count">0 ticket(s) selected. Please select attendees.</p>
        <div class="buttons">
            <button class="btn btn-outline-secondary" onclick="history.back()">Back</button>
            <form id="seatForm" action="seat-selection" method="POST">
                <input type="hidden" id="selectedSeatsInput" name="selectedSeats" />
                <input type="hidden" id="totalPriceInput" name="totalPrice" />
                <input type="hidden" id="showtimeIdInput" name="showtime_id" value="<%= request.getParameter("showtime_id") %>" />
                <button type="submit" id="continueButton" class="btn btn-primary" onclick="submitSeats()" disabled>Continue</button>
            </form>
        </div>
    </div>
</div>
<jsp:include page="jsp/footer.jsp">
    <jsp:param name="js" value="seatselection.js" />
</jsp:include>