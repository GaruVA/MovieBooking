<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="css" value="account.css" />
    <jsp:param name="activePage" value="account" />
</jsp:include>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <!-- Display success message -->
            <c:if test="${not empty success}">
                <div class="alert alert-success" role="alert">
                    ${success}
                </div>
            </c:if>
            <!-- Display error message -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>

            <!-- Card 1: User Information -->
            <h2 class="title mb-3">User Information</h2>
            <div class="card shadow-sm mb-4">

                <div class="card-body">
                    <form id="userInfoForm" method="post" action="account" class="needs-validation" novalidate="">
                        <input type="hidden" name="formType" value="userInfo">
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" value="${username}" disabled="">
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="${email}"
                                required="">
                            <div class="invalid-feedback">
                                Please provide a valid email.
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone</label>
                            <input type="tel" class="form-control" id="phone" name="phone" value="${phone}"
                                pattern="[0-9]{10}">
                            <div class="invalid-feedback">
                                Please provide a valid 10-digit phone number.
                            </div>
                        </div>

                        <button type="submit" class="btn btn-outline-primary cs-button">Update Info</button>
                    </form>
                </div>
            </div>

            <!-- Card 2: Password Update -->

            <div class="card shadow-sm mb-4">

                <div class="card-body">
                    <form id="passwordForm" method="post" action="account" class="needs-validation" novalidate="">
                        <input type="hidden" name="formType" value="password">
                        <div class="mb-3">
                            <label for="currentPassword" class="form-label">Current Password</label>
                            <input type="password" class="form-control" id="currentPassword" name="currentPassword">
                        </div>

                        <div class="mb-3">
                            <label for="newPassword" class="form-label">New Password</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword">
                        </div>

                        <button type="submit" class="btn btn-outline-primary cs-button">Update Password</button>
                    </form>
                </div>
            </div>

            

            <!-- Card 3: Booking History -->
            <h2 class="title mb-3">Booking History</h2>
            <div class="card shadow-sm mb-4">

                <div class="card-body card-table">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>BookingID</th>
                                <th>Movie Title</th>
                                <th>Theatre Name</th>
                                <th>Showtime Date Time</th>
                                <th>Tickets</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>12345</td>
                                <td>Inception</td>
                                <td>ABC Theatre</td>
                                <td>2023-10-01 19:00</td>
                                <td>2</td>
                                <td>Confirmed</td>
                            </tr>
                            <tr>
                                <td>67890</td>
                                <td>Interstellar</td>
                                <td>XYZ Theatre</td>
                                <td>2023-10-05 21:00</td>
                                <td>4</td>
                                <td>Cancelled</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- Add Delete Account and Logout buttons -->
            <div class="d-flex justify-content-between mb-4">
                <form method="post" action="account" class="needs-validation" novalidate="">
                    <input type="hidden" name="formType" value="deleteAccount">
                    <button type="submit" class="btn btn-outline-danger cs-button">Delete Account</button>
                </form>
                <form method="post" action="logout" class="needs-validation" novalidate="">
                    <button type="submit" class="btn btn-outline-secondary cs-button">Logout</button>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="jsp/footer.jsp">
    <jsp:param name="js" value="account.js" />
</jsp:include>