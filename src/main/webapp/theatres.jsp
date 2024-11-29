<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Include header with parameters -->
<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="css" value="theatres.css" />
    <jsp:param name="activePage" value="theatres" />
</jsp:include>

<!-- Page-specific content -->
<div class="container py-5">
    <div class="row g-4">
        <c:if test="${not empty error}">
            <div class="col-12">
                <p class="text-center text-danger">${error}</p>
            </div>
        </c:if>
        
        <c:if test="${empty theatres}">
            <div class="col-12">
                <p class="text-center">No theatres available.</p>
            </div>
        </c:if>
        
        <c:forEach var="theatre" items="${theatres}">
            <div class="col-md-4">
                <div class="card theatre-card shadow-sm" onclick="window.location.href='booking-selection.jsp?theatre_id=${theatre.id}'">
                    <img src="${empty theatre.imagePath ? './images/placeholder.png' : theatre.imagePath}" 
                         class="card-img-top" 
                         alt="${theatre.name}">
                    <div class="card-body">
                        <h5 class="card-title">${theatre.name}</h5>
                        <p class="card-text">${theatre.location}</p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Include footer -->
<jsp:include page="jsp/footer.jsp" />