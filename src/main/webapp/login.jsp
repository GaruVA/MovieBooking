<jsp:include page="jsp/header.jsp">
    <jsp:param name="title" value="ABC Cinema" />
    <jsp:param name="css" value="user-authentication.css" />
    <jsp:param name="activePage" value="login" />   
</jsp:include>

<div class="container">
    <div class="row justify-content-center bg-gray-800 p-4 rounded shadow">
        <div class="col-md-6">
            <h2 class="text-center mb-4 text-gray-100">Welcome Back!</h2>

            <!-- Error Message Display -->
            <%
                String error = request.getParameter("error");
                if ("true".equals(error)) {
            %>
            <div class="alert alert-danger" role="alert">
                Login failed. Please check your inputs and try again.
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
            <form action="login" method="post">
                <div class="mb-3">
                    <label for="identifier" class="form-label">Username or Email</label>
                    <input type="text" id="identifier" name="identifier" class="form-control bg-gray-700 text-gray-100 border-gray-600" placeholder="Username or Email" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" id="password" name="password" class="form-control bg-gray-700 text-gray-100 border-gray-600" placeholder="Password" required>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Login</button>
                </div>
            </form>

            <!-- Login Link -->
            <p class="mt-3 text-center text-gray-100">
                Don't have an account? <a href="register" class="text-primary">Register here</a>.
            </p> 
        </div>
    </div>
</div>

<%@ include file="jsp/footer.jsp"%>