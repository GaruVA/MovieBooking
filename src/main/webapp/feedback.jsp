<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema - Feedback" />
    <jsp:param name="css" value="feedback.css" />
    <jsp:param name="activePage" value="feedback" />
</jsp:include>
 
<!-- Feedback Form Section -->
<div class="container py-5">
    <h2 class="text-center mb-4">We Value Your Feedback!</h2>
    <form action="./feedback" method="POST" class="shadow p-4 rounded bg-gray-800 text-gray-100">
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <div class="mb-3">
            <label class="form-label">Rating</label>
            <div class="star-rating">
                <input type="radio" id="star5" name="rating" value="5" required />
                <label for="star5" title="5 stars">★</label>

                <input type="radio" id="star4" name="rating" value="4" />
                <label for="star4" title="4 stars">★</label>

                <input type="radio" id="star3" name="rating" value="3" />
                <label for="star3" title="3 stars">★</label>

                <input type="radio" id="star2" name="rating" value="2" />
                <label for="star2" title="2 stars">★</label>

                <input type="radio" id="star1" name="rating" value="1" />
                <label for="star1" title="1 star">★</label>
            </div>
        </div>

        <div class="mb-3">
            <label for="comment" class="form-label">Additional Comments</label>
            <textarea class="form-control bg-gray-700 text-gray-100 border-gray-600" id="comment" name="comment" rows="3" placeholder="Share your thoughts..."></textarea>
        </div>

        <button type="submit" class="btn btn-primary w-100">Submit Feedback</button>
    </form>

    <c:if test="${sessionScope.role eq 'admin'}">
        <div class="mt-5">
            <h2 class="text-center mb-4">Customer Feedbacks</h2>
            <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
                <table class="table table-striped table-dark">
                    <thead class="table-dark">
                        <tr>
                            <th>Rating</th>
                            <th>Comment</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="feedback" items="${feedbacks}" varStatus="status">
                            <tr>
                                <td>${feedback.rating}</td>
                                <td>${feedback.comment}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>
</div>

<jsp:include page="jsp/footer.jsp">
    <jsp:param name="js" value="feedback.js" />
</jsp:include>