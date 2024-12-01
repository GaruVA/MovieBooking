<!-- Include header with parameters -->
<!-- activePage: pass an empty string if the page isn't listed in navbar-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="css" value="style.css" />
    <jsp:param name="activePage" value="home" />   
</jsp:include>

<!-- Your page-specific content goes here -->
<div id="carouselExample" class="carousel slide">

    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="./images/cimg1.jpg" class="d-block w-100" alt="..." height="550px" width="1525px">
        </div>

        <div class="carousel-item">
            <img src="./images/cimg2.jpg" class="d-block w-100" alt="..." height="550px" width="1525px" >
        </div>

        <div class="carousel-item">
            <img src="./images/cimg3.jpg" class="d-block w-100" alt="..." height="550px" width="1525px" >
        </div>
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

<br>
<h1>WELCOME TO ABC CINEMA</h1>

<br>

<H2><center>NOW SHOWING</center></h2>
<br>

<div class="container mt-4">
    <div class="row">
        <!-- Card 1 -->
        <c:forEach var="movie" items="${nowshow}">
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

        <c:if test="${empty nowshow}">
            <p>No movies currently showing.</p>
        </c:if>
    </div>

</div>

<br>

<H2><center>COMING SOON</center></h2>
<br>



<div class="container mt-4">
    <div class="row">
        <!-- Card 1 -->
        <c:forEach var="movieone" items="${comingsoon}">
            <div class="col-md-3">
                <div class="card">
                    <img src="${empty movieone.image_path ? './images/ABC.png' : movieone.image_path}" class="card-img-top" alt="Card 1">
                    <div class="card-body">
                        <h5 class="card-title">${movieone.title}</h5>
                        <p class="card-text">${movieone.description}</p>
                        <a href="./Informations?id=${movie.id}" class="btn btn-primary">More Info</a>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty comingSoon}">
            <p>No movies currently showing.</p>
        </c:if>
    </div>

</div>

<!-- Include footer with parameters -->
<jsp:include page="jsp/footer.jsp">
    <jsp:param name="js" value="index.js" />
</jsp:include>