<!-- Include header with parameters -->
<!-- activePage: pass an empty string if the page isn't listed in navbar-->
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="css" value="home.css" />
    <jsp:param name="activePage" value="home" />   
</jsp:include>

<!-- carousel -->
<div id="carouselExample" class="carousel slide container">
    <div class="carousel-inner">
        <c:forEach var="movie" items="${nowshow}">
            <div class="carousel-item ${movie == nowshow[0] ? 'active' : ''}">
                <div class="hero-section"
                    style="background: linear-gradient(to bottom, transparent, black), url('${empty movie.image_path ? './images/placeholder.png' : movie.image_path}');">
                    <div class="carousel-caption d-none d-md-block text-white text-start">
                        <h1>${movie.title} <span class="imdb-rating"><i class="ri-star-s-fill"></i> ${movie.imdb_rating}</span></h1>
                        <p class="lead">Experience the mind-bending journey through time and space in this
                            sci-fi epic.</p>
                        <a href="./booking-selection?movie_id=${movie.id}" class="btn btn-light" style="
                    font-size: 14px;
                    padding: 8px 16px;
                ">Book Now</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>

<div class="container">
    <H2 class="text-gray-100" style="margin-bottom: 30px;">Upcoming Releases</H2>
    <div class="row g-4">
        <c:forEach var="movie" items="${comingsoon}">
            <div class="col-md-3 col-sm-6">
                <a href="./information?movie_id=${movie.id}">
                    <div class="rounded-lg border text-card-foreground shadow-sm w-full max-w-sm mx-auto bg-gray-800 border-gray-700 overflow-hidden transition-shadow duration-300 hover:shadow-lg" style="border-color: #374151 !important;">
                        <div class="p-0 relative">
                            <img alt="${movie.title}" loading="lazy" width="300" height="450" decoding="async" data-nimg="1" class="w-full h-auto" src="${empty movie.image_path ? './images/placeholder.png' : movie.image_path}" style="color: transparent;">
                            <div class="absolute bottom-0 left-0 right-0 p-4" style="background: linear-gradient(to top, rgba(0, 0, 0, 0.9), rgba(0, 0, 0, 0.6));">
                                <h3 class="text-lg font-semibold mb-1 text-white">${movie.title}</h3>
                                <p class="text-sm text-gray-300">Release: ${movie.release_date}</p>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>

        <c:if test="${empty comingsoon}">
            <p class="text-gray-100">No movies coming soon.</p>
        </c:if>
    </div>
</div>

<br>

<!-- Include footer with parameters -->
<%@ include file="jsp/footer.jsp"%>