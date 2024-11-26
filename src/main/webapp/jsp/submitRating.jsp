<%@ page import="java.sql.*, java.io.*" %>
<%
    String movieId = request.getParameter("movieId");
    String rating = request.getParameter("rating");

    if (movieId != null && rating != null) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/your_database_name";  // Replace with your database name
            String username = "root";  // Replace with your MySQL username
            String password = "password";  // Replace with your MySQL password
            conn = DriverManager.getConnection(url, username, password);

            // SQL query to insert rating into the database
            String sql = "INSERT INTO movie_ratings (movie_id, rating) VALUES (?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(movieId));  // Set movie_id from request
            stmt.setInt(2, Integer.parseInt(rating));  // Set rating from request

            // Execute the query
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                out.print("Rating saved successfully!");
            } else {
                out.print("Failed to save rating.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("Error: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        out.print("Invalid rating or movie ID.");
    }
%>

