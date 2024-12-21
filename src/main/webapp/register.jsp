<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="css" value="user-authentication.css" />
    <jsp:param name="activePage" value="register" />
</jsp:include>

<div class="container">
    <div class="row justify-content-center bg-gray-800 p-4 rounded shadow">
        <div class="col-md-6">
            <h2 class="text-center mb-4 text-gray-100">Create an Account</h2>

            <!-- Error Message Display -->
            <%
                String error = request.getParameter("error");
                if ("true".equals(error)) {
            %>
            <div class="alert alert-danger" role="alert">
                Registration failed. Please check your inputs and try again.
            </div>
            <% } else if ("exists".equals(error)) { %>
            <div class="alert alert-warning" role="alert">
                The username or email already exists. Please use a different one.
            </div>
            <% } else if ("internal".equals(error)) { %>
            <div class="alert alert-danger" role="alert">
                An internal error occurred. Please try again later.
            </div>
            <% }%>

            <!-- Registration Form -->
            <form action="register" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" id="username" name="username" class="form-control bg-gray-700 text-gray-100 border-gray-600" placeholder="Choose a username" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" id="email" name="email" class="form-control bg-gray-700 text-gray-100 border-gray-600" placeholder="Enter your email address" required>
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">Phone Number</label>
                    <input type="text" id="phone" name="phone" class="form-control bg-gray-700 text-gray-100 border-gray-600" placeholder="Enter your phone number">
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" id="password" name="password" class="form-control bg-gray-700 text-gray-100 border-gray-600" placeholder="Create a password" required>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Register</button>
                </div>
            </form>

            <!-- Login Link -->
            <p class="mt-3 text-center text-gray-100">
                Already have an account? <a href="login" class="text-primary">Login here</a>.
            </p>
        </div>
    </div>
</div>

<%@ include file="jsp/footer.jsp"%>

