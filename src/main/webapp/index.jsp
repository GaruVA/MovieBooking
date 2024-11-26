<!-- Include header with parameters -->
<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="Your Page Title" />
    <jsp:param name="css" value="style.css" />
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
        <div class="col-md-3">
            <div class="card">
                <img src="./images/image1.jpg" class="card-img-top" alt="Card 1">
                <div class="card-body">
                    <h5 class="card-title">The Wild Robot</h5>
                    <p class="card-text">Some quick example text for card 1.</p>
                    <a href="./TheWildRobot.jsp" class="btn btn-primary">More Info</a>
                </div>
            </div>
        </div>
        <!-- Card 2 -->
        <div class="col-md-3">
            <div class="card">
                <img src="./images/image2.jpg" class="card-img-top" alt="Card 2">
                <div class="card-body">
                    <h5 class="card-title">Smile 2</h5>
                    <p class="card-text">Some quick example text for card 2.</p>
                    <a href="#" class="btn btn-primary">More Info</a>
                </div>
            </div>
        </div>
        <!-- Card 3 -->
        <div class="col-md-3">
            <div class="card">
                <img src="./images/image3.jpg" class="card-img-top" alt="Card 3">
                <div class="card-body">
                    <h5 class="card-title">Red One</h5>
                    <p class="card-text">Some quick example text for card 3.</p>
                    <a href="#" class="btn btn-primary">More Info</a>
                </div>
            </div>
        </div>
        <!-- Card 4 -->
        <div class="col-md-3">
            <div class="card">
                <img src="./images/image4.jpg" class="card-img-top" alt="Card 4">
                <div class="card-body">
                    <h5 class="card-title">It Ends With Us</h5>
                    <p class="card-text">Some quick example text for card 4.</p>
                    <a href="#" class="btn btn-primary">More Info</a>
                </div>
            </div>
        </div>
    </div>

    <br>

    <div class="row">
        <!-- Card 5 -->
        <div class="col-md-3">
            <div class="card">
                <img src="./images/image5.jpg" class="card-img-top" alt="Card 5">
                <div class="card-body">
                    <h5 class="card-title">Mandara</h5>
                    <p class="card-text">Some quick example text for card 1.</p>
                    <a href="#" class="btn btn-primary">More Info</a>
                </div>
            </div>
        </div>
        <!-- Card 6 -->
        <div class="col-md-3">
            <div class="card">
                <img src="./images/image6.jpg" class="card-img-top" alt="Card 6">
                <div class="card-body">
                    <h5 class="card-title">Sri Siddha</h5>
                    <p class="card-text">Some quick example text for card 2.</p>
                    <a href="#" class="btn btn-primary">More Info</a>
                </div>
            </div>
        </div>
        <!-- Card 7 -->
        <div class="col-md-3">
            <div class="card">
                <img src="./images/image7.jpg" class="card-img-top" alt="Card 7">
                <div class="card-body">
                    <h5 class="card-title">Kanguva</h5>
                    <p class="card-text">Some quick example text for card 3.</p>
                    <a href="#" class="btn btn-primary">More Info</a>
                </div>
            </div>
        </div>
        <!-- Card 8 -->
        <div class="col-md-3">
            <div class="card">
                <img src="./images/image8.jpg" class="card-img-top" alt="Card 8">
                <div class="card-body">
                    <h5 class="card-title">The Lord Of The Rings</h5>
                    <p class="card-text">Some quick example text for card 4.</p>
                    <a href="#" class="btn btn-primary">More Info</a>
                </div>
            </div>
        </div>
    </div>

</div>


<br>

<H2><center>COMING SOON</center></h2>
<br>

<div class="container mt-4">
    <div class="row">
        <!-- Card 1 -->
        <div class="col-md-3">
            <div class="card">
                <img src="./images/image9.jpg" class="card-img-top" alt="Card 1">
                <div class="card-body">
                    <h5 class="card-title">Wicked</h5>
                    <p class="card-text">Some quick example text for card 1.</p>
                    <a href="#" class="btn btn-primary">More Info</a>
                </div>
            </div>
        </div>
        <!-- Card 2 -->
        <div class="col-md-3">
            <div class="card">
                <img src="./images/image10.jpg" class="card-img-top" alt="Card 2">
                <div class="card-body">
                    <h5 class="card-title">Gladiator 2</h5>
                    <p class="card-text">Some quick example text for card 2.</p>
                    <a href="#" class="btn btn-primary">More Info</a>
                </div>
            </div>
        </div>
        <!-- Card 3 -->
        <div class="col-md-3">
            <div class="card">
                <img src="./images/image11.jpg" class="card-img-top" alt="Card 3">
                <div class="card-body">
                    <h5 class="card-title">Moana 2</h5>
                    <p class="card-text">Some quick example text for card 3.</p>
                    <a href="#" class="btn btn-primary">More Info</a>
                </div>
            </div>
        </div>
        <!-- Card 4 -->
        <div class="col-md-3">
            <div class="card">
                <img src="./images/image12.jpg" class="card-img-top" alt="Card 4">
                <div class="card-body">
                    <h5 class="card-title">Kraven The Hunter</h5>
                    <p class="card-text">Some quick example text for card 4.</p>
                    <a href="#" class="btn btn-primary">More Info</a>
                </div>
            </div>
        </div>
    </div>

    <br>

    <div class="row">
        <!-- Card 5 -->
        <div class="col-md-3">
            <div class="card">
                <img src="./images/image13.jpg" class="card-img-top" alt="Card 5">
                <div class="card-body">
                    <h5 class="card-title">Sonic 3</h5>
                    <p class="card-text">Some quick example text for card 1.</p>
                    <a href="#" class="btn btn-primary">More Info</a>
                </div>
            </div>
        </div>
        <!-- Card 6 -->
        <div class="col-md-3">
            <div class="card">
                <img src="./images/image14.jpg" class="card-img-top" alt="Card 6">
                <div class="card-body">
                    <h5 class="card-title">Mufasa</h5>
                    <p class="card-text">Some quick example text for card 2.</p>
                    <a href="#" class="btn btn-primary">More Info</a>
                </div>
            </div>
        </div>
        <!-- Card 7 -->
        <div class="col-md-3">
            <div class="card">
                <img src="./images/image15.jpg" class="card-img-top" alt="Card 7">
                <div class="card-body">
                    <h5 class="card-title">Pushpa</h5>
                    <p class="card-text">Some quick example text for card 3.</p>
                    <a href="#" class="btn btn-primary">More Info</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Include footer with parameters -->
<jsp:include page="jsp/footer.jsp">
    <jsp:param name="js" value="index.js" />
</jsp:include>