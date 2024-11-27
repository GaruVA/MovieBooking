<!-- Include header with parameters -->
<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="css" value="theatres.css" />
    <jsp:param name="activePage" value="theatres" />
</jsp:include>

<!-- Your page-specific content goes here -->
<div class="container py-5">
    <div class="row g-4" id="theatre-container">
        <!-- Theatres will be dynamically inserted here -->
    </div>
</div>

<!-- Include footer with parameters -->
<jsp:include page="jsp/footer.jsp">
    <jsp:param name="js" value="theatres.js" />
</jsp:include>
