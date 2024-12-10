<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="Payment" />
</jsp:include>

<div class="container">
    <h1>Payment Details</h1>

    <form action="fetch_price" method="post">
        <label for="movieName">Select Movie:</label>
        <select name="movieName" required>
            <option value="Movie 1">Movie 1</option>
            <option value="Movie 2">Movie 2</option>
        </select>
        <button type="submit">Fetch Price</button>
    </form>

    <% if (request.getAttribute("total") != null) { %>
    <form action="authorize_payment" method="post">
        <p>Price: ${request.getAttribute("price")}</p>
        <p>Tax: ${request.getAttribute("tax")}</p>
        <p>Total: ${request.getAttribute("total")}</p>
        <input type="hidden" name="movieName" value="${request.getAttribute("movieName")}">
        <input type="hidden" name="subtotal" value="${request.getAttribute("price")}">
        <input type="hidden" name="tax" value="${request.getAttribute("tax")}">
        <input type="hidden" name="total" value="${request.getAttribute("total")}">
        <button type="submit">Proceed to PayPal</button>
    </form>
    <% } %>
</div>

<jsp:include page="jsp/footer.jsp" />
