<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                    <img src="${movieImagePath}" alt="Movie Image" class="img-fluid movie-image">
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
                    <h1 class="movie-title">${movieTitle}</h1>
                    <div class="movie-imdb">
                        IMDB RATING <i class="ri-star-s-fill"></i>${imdb}/10
                    </div>
                    <!-- Horizontal line-->
                    <hr class="custom-hr">

                </div>
                <br>

                <!-- Movie Description -->
                <h4>STORY LINE</h4>
                <p>${movieDescription}</p>
                <h6>GENRES</h6> <p>${movieGenre}</p>
                <!-- Horizontal line-->
                <hr class="custom-hr">

                <h4>CAST</h4>

                <div class="row">
                    <div class="col-md-6">
                        <h6>Actors</h6>
                        <ul>
                            ${movieActor1}<br>
                            ${movieActor2}<br>
                            ${movieActor3}
                        </ul>
                    </div>

                    <div class="col-md-6">
                        <h6>Characters</h6>
                        <ul>
                            ${movieCharacter1}<br>
                            ${movieCharacter2}<br>
                            ${movieCharacter3}
                        </ul>
                    </div>
                </div>

                <h4>TEAM</h4>
                <h6>Directed by</h6> ${movieDirector}
                <h6>Produced by</h6> ${movieProduce}
                <h6>Written by</h6> ${movieWriter}
                <h6>Music by</h6> ${movieMusic}
            </div>
        </div>
    </c:if>

    <!-- Include footer -->
    <jsp:include page="jsp/footer.jsp" />
</div>