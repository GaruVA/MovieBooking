<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema - Feedback" />
    <jsp:param name="css" value="style.css" />
    <jsp:param name="activePage" value="feedback" />
</jsp:include>

<!-- Feedback Form Section -->
<div class="container mt-5">
    <h2 class="text-center">We Value Your Feedback!</h2>
    <form action="submitFeedback" method="POST">
        <div class="mb-3">
            <label for="rating" class="form-label">Rating (1-5)</label>
            <select class="form-select" id="rating" name="rating" required>
                <option value="1">1 - Poor</option>
                <option value="2">2 - Fair</option>
                <option value="3">3 - Good</option>
                <option value="4">4 - Very Good</option>
                <option value="5">5 - Excellent</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="comment" class="form-label">Additional Comments</label>
            <textarea class="form-control" id="comment" name="comment" rows="3" placeholder="Share your thoughts..."></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Submit Feedback</button>
    </form>
</div>

<jsp:include page="jsp/footer.jsp">
    <jsp:param name="js" value="feedback.js" />
</jsp:include>
