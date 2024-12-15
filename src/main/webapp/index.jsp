<!-- Include header with parameters -->
<!-- activePage: pass an empty string if the page isn't listed in navbar-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="css" value="home.css" />
    <jsp:param name="activePage" value="home" />   
</jsp:include>

<!-- carousel -->
<div id="carouselExample" class="carousel slide">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="./images/carousel1.jpg" class="d-block w-100" alt="..." height="550px" width="1525px">
        </div>
        <div class="carousel-item">
            <img src="./images/carousel2.jpg" class="d-block w-100" alt="..." height="550px" width="1525px" >
        </div>
        <div class="carousel-item">
            <img src="./images/carousel3.jpg" class="d-block w-100" alt="..." height="550px" width="1525px" >
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next"></button>
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>

<div class="container mt-4">
    <H2>NOW SHOWING</h2>
    <div class="scroll-container">
        <!-- Card 1 -->
        <c:forEach var="movie" items="${nowshow}">
            <div class="col-md-3">
                <div class="card shadow-sm">
                    <img src="${empty movie.image_path ? './images/placeholder.png' : movie.image_path}" class="card-img-top" alt="${movie.title}">
                    <div class="card-body">
                        <h5 class="card-title">${movie.title}</h5>
                        <div class="movie-imdb">
                            <i class="ri-star-s-fill"></i>${movie.imdb_rating}
                        </div>
                        <!-- <p class="card-text">${movie.description}</p> -->
                        <center><a href="./information?movie_id=${movie.id}" class="btn btn-outline-light">More Info</a>
                            <a href="./booking-selection?movie_id=${movie.id}" class="btn btn-outline-light">Book Now</a></center>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty nowshow}">
            <p>No movies currently showing.</p>
        </c:if>
    </div>
</div>

<div class="container mt-4">
    <H2>COMING SOON</h2>
    <div class="scroll-container">
        <!-- Card 1 -->
        <c:forEach var="movie" items="${comingsoon}">
            <div class="col-md-3">
                <div class="card shadow-sm">
                    <img src="${empty movie.image_path ? './images/placeholder.png' : movie.image_path}" class="card-img-top" alt="${movie.title}">
                    <div class="card-body">
                        <h5 class="card-title">${movie.title}</h5>
                        <div class="movie-imdb">
                            <i class="ri-star-s-fill"></i>${movie.imdb_rating}
                        </div>
                        <!-- <p class="card-text">${movie.description}</p> -->
                        <center><a href="./information?movie_id=${movie.id}" class="btn btn-outline-light">More Info</a>
                            <a href="./booking-selection?movie_id=${movie.id}" class="btn btn-outline-light">Book Now</a></center>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty comingsoon}">
            <p>No movies coming soon.</p>
        </c:if>
    </div>
</div>

<br>

<style>
.scroll-container {
    display: flex; 
    flex-wrap: nowrap; 
    overflow-x: auto;
    gap: 0px; 
    padding: 10px 0; 
}

.scroll-container::-webkit-scrollbar {
    height: 3px; 
}

.scroll-container::-webkit-scrollbar-thumb {
    background: #888; 
    border-radius: 4px; 
}

.scroll-container::-webkit-scrollbar-track {
    background: #f1f1f1; 
}

.card {
    flex: 0 0 auto; 
    width: 200px; 
    border: 1px solid #ddd; 
    border-radius: 5px; 
    overflow: hidden; 
}
</style>


<!-- Include footer with parameters -->
<jsp:include page="jsp/footer.jsp">
    <jsp:param name="js" value="index.js" />
</jsp:include>