
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- Include header with parameters -->
<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="activePage" value="informations" />
</jsp:include>

<div class="container mt-4 mb-4">
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:if test="${empty error}">
        <h1>${movieTitle}</h1>
        <h3>${imdb}</h3>
        <p>${movieDescription}</p>
        <img src="${movieImagePath}" alt="Movie Image" class="img-fluid" />
    </c:if>

    <!-- Include footer -->
    <jsp:include page="jsp/footer.jsp" />
</div>
