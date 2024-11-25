<!-- Include header with parameters -->
<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="css" value="booking-selection.css" />
</jsp:include>

<!-- Your page-specific content goes here -->
<div class="container py-5">
    <div class="card">
        <div class="card-body">
            <h2 class="card-title text-center mb-4">Book Your Movie</h2>

            <div class="row g-3 mb-4">
                <div class="col-md-4">
                    <label for="movieSelect" class="form-label">Select Movie</label>
                    <select class="form-select" id="movieSelect">
                        <option value="">Loading movies...</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="theatreSelect" class="form-label">Select Theatre</label>
                    <select class="form-select" id="theatreSelect">
                        <option value="">Loading theatres...</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="dateSelect" class="form-label">Select Date</label>
                    <input type="date" class="form-control" id="dateSelect">
                </div>
            </div>

            <div id="showtimesList">
                <div class="loading">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Include footer with parameters -->
<jsp:include page="jsp/footer.jsp">
    <jsp:param name="js" value="booking-selection.js" />
</jsp:include>