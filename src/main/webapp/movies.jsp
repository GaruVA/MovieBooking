<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Include header with parameters -->
<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="activePage" value="movies" />
</jsp:include>


<h1 class="text-center mt-1 mb-1">Movies</h1>

<div class="container mt-4 mb-4">
    <div class="row">
        <!-- Card 1 -->
        <c:if test="${not empty error}">
            <div class="col-12">
                <p class="text-center text-danger">${error}</p>
            </div>
        </c:if>

        <c:if test="${empty moviess}">
            <div class="col-12">
                <p class="text-center">No Movies Available.</p>
            </div>
        </c:if>

        <c:forEach var="movie" items="${moviess}">
            <div class="col-md-3">
                <div class="card">
                    <img src="${empty movie.image_path ? './images/ABC.png' : movie.image_path}" class="card-img-top" alt="Card 1">
                    <div class="card-body">
                        <h5 class="card-title">${movie.title}</h5>
                        <p class="card-text">${movie.description}</p>
                        <a href="./Informations?id=${movie.id}" class="btn btn-primary">More Info</a>
                    </div>
                </div>
            </div>
        </c:forEach>




        <!-- Include footer -->
        <jsp:include page="jsp/footer.jsp" />
    </div>