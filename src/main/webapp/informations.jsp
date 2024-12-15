<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Include header with parameters -->
<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="css" value="info.css" />
    <jsp:param name="activePage" value="informations" />
</jsp:include>

<div class="container mt-4 mb-4">
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:if test="${empty error}">
        <!-- Movie Info Section -->
        <div class="row">
            <!-- Movie Image -->
            <div class="col-md-6">
                <div class="position-relative">
                    <img src="${movie.image_path}" alt="Movie Image" class="img-fluid movie-image">
                    <!-- Button under the image -->
                    <div class="text-center">
                        <br>
                        <a href="#" class="btn btn-primary">Book Now</a>
                    </div>
                </div>
            </div>

            <!-- Movie Description Section -->
            <div class="col-md-6 movie-description">
                <!-- Movie Title and IMDb Rating -->
                <div class="movie-title-rating">
                    <h1 class="movie-title">${movie.title}</h1>
                    <div class="movie-imdb">
                        IMDB RATING <i class="ri-star-s-fill"></i>${movie.imdb_rating}/10
                    </div>
                    <!-- Horizontal line-->
                    <hr class="custom-hr">
                </div>
                <br>

                <!-- Movie Description -->
                <h3>STORY LINE</h3>
                <p>${movie.description}</p>
                <h6>GENRES</h6> <p style="font-size: 0.8rem; margin: 0; padding: 0; list-style: none;">${movie.genre}</p>
                <!-- Horizontal line-->
                <hr class="custom-hr">

                <h4>CAST</h4>
                <div class="row">
                    <div class="col-md-6">
                        <h6>Actors</h6>
                        <ul style="font-size: 0.8rem; margin: 0; padding: 0; list-style: none;">
                            <c:forEach var="actor" items="${fn:split(movie.actors, ',')}">
                                <li>${actor}</li>
                            </c:forEach>
                        </ul>
                    </div>

                    <div class="col-md-6">
                        <h6>Characters</h6>
                        <ul style="font-size: 0.8rem; margin: 0; padding: 0; list-style: none;">
                            <c:forEach var="character" items="${fn:split(movie.characters, ',')}">
                                <li>${character}</li>
                            </c:forEach>
                        </ul>
                    </div>
                </div><br>

                <h4>TEAM</h4>
                <div style="display: flex; flex-direction: column; gap: 10px;">
                    <div style="display: flex; justify-content: flex-start; gap: 10px; font-size: 0.9rem;">
                        <h6 style="margin: 0; font-size: 0.9rem;">Directed by</h6> 
                        <span style="font-size: 0.9rem;">${movie.director}</span>
                    </div>
                    <div style="display: flex; justify-content: flex-start; gap: 10px; font-size: 0.9rem;">
                        <h6 style="margin: 0; font-size: 0.9rem;">Produced by</h6> 
                        <span style="font-size: 0.9rem;">${movie.produce}</span>
                    </div>
                    <div style="display: flex; justify-content: flex-start; gap: 10px; font-size: 0.9rem;">
                        <h6 style="margin: 0; font-size: 0.9rem;">Written by</h6> 
                        <span style="font-size: 0.9rem;">${movie.writer}</span>
                    </div>
                    <div style="display: flex; justify-content: flex-start; gap: 10px; font-size: 0.9rem;">
                        <h6 style="margin: 0; font-size: 0.9rem;">Music by</h6> 
                        <span style="font-size: 0.9rem;">${movie.music}</span>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</div>

<!-- Include footer -->
<jsp:include page="jsp/footer.jsp" />