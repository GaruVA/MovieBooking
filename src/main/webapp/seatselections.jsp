<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="css" value="seatselection.css" />
    <jsp:param name="activePage" value="seatselection" />
</jsp:include>
<div class="theater">
    <h1>Select Your Seats</h1>
    <div class="ticket-info">
        <label for="adults">Adults:</label>
        <select id="adults" name="adults" onchange="handleDropdownChange()">
            <option value="0">0</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
        </select>
        <label for="children">Children:</label>
        <select id="children" name="children" onchange="handleDropdownChange()">
            <option value="0">0</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
        </select>
        <p>Ticket Price: Rs. 1250 (Adult), Rs. 750 (Child)</p>
    </div>
    <div class="screen">Screen</div>
    <div class="seats">
        <%
            int rows = 5;
            int cols = 5;
            for (int i = 1; i <= rows; i++) {
                out.print("<div class='row'>");
                for (int j = 1; j <= cols; j++) {
                    String seatNumber = "L" + i + "C" + j;
                    out.print("<div class='seat' id='" + seatNumber + "' onclick='toggleSeat(this)'>");
                    out.print(seatNumber);
                    out.print("</div>");
                }
                out.print("<div class='staircase'></div>");
                for (int j = 1; j <= cols; j++) {
                    String seatNumber = "R" + i + "C" + j;
                    out.print("<div class='seat' id='" + seatNumber + "' onclick='toggleSeat(this)'>");
                    out.print(seatNumber);
                    out.print("</div>");
                }
                out.print("</div>");
            }
        %>
    </div>
    <p id="seatCount" class="seat-count">0 ticket(s) selected. Please select attendees.</p>
    <div class="buttons">
        <button onclick="history.back()">Back</button>
        <button id="continueButton" disabled>Continue</button>
    </div>
</div>

<jsp:include page="jsp/footer.jsp">
    <jsp:param name="js" value="seatselection.js" />
</jsp:include>