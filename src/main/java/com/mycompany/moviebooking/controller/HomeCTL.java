package com.mycompany.moviebooking.controller;

import com.mycompany.moviebooking.model.Movie;
import com.mycompany.moviebooking.utility.JDBCDataSource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "index.jsp", urlPatterns = {"/index"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 15 // 15MB
)
public class HomeCTL extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "images";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Movie> nowShowMovies = new ArrayList<>();
        List<Movie> comingSoonMovies = new ArrayList<>();

        try (Connection conn = JDBCDataSource.getConnection()) {
            String sqlNowShowing = "SELECT * FROM movies WHERE status='Now Showing'";
            try (PreparedStatement stmt = conn.prepareStatement(sqlNowShowing)) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Movie movie = new Movie();
                    movie.setId(rs.getInt("movie_id"));
                    movie.setTitle(rs.getString("title"));
                    movie.setDescription(rs.getString("description"));
//                    theatre.setId(rs.getInt("theatre_id"));
//                    theatre.setName(rs.getString("name"));
//                    theatre.setLocation(rs.getString("location"));
                    movie.setImage_path(rs.getString("image_path"));
//                    theatres.add(theatre);
                    nowShowMovies.add(movie);
                }
            }

            String sqlComingSoon = "SELECT * FROM movies WHERE status='Coming Soon'";
            try (PreparedStatement stmt = conn.prepareStatement(sqlComingSoon)) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Movie movie = new Movie();
                    movie.setId(rs.getInt("movie_id"));
                    movie.setTitle(rs.getString("title"));
                    movie.setDescription(rs.getString("description"));
//                    theatre.setId(rs.getInt("theatre_id"));
//                    theatre.setName(rs.getString("name"));
//                    theatre.setLocation(rs.getString("location"));
                    movie.setImage_path(rs.getString("image_path"));
//                    theatres.add(theatre);
                    comingSoonMovies.add(movie);
                }
            }

        } catch (SQLException e) {
            Logger.getLogger(MovieCTL.class.getName()).log(Level.SEVERE, "Error fetching movies", e);
            request.setAttribute("error", "Failed to load movies. Please try again later.");
        } catch (Exception ex) {
            Logger.getLogger(MovieCTL.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "An unexpected error occurred.");
        }

        // Set both lists as request attributes
        request.setAttribute("nowshow", nowShowMovies);         // All movies
        request.setAttribute("comingsoon", comingSoonMovies);

        // Forward to index.jsp once
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is admin
        String role = (String) request.getSession().getAttribute("role");
        if (!"admin".equals(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        String action = request.getParameter("action");
        try {
            switch (action) {
                case "add":
                    addMovie(request);
                    request.setAttribute("success", "Movie added successfully!");
                    break;
                case "edit":
                    updateMovie(request);
                    request.setAttribute("success", "Movie updated successfully!");
                    break;
                case "delete":
                    deleteMovie(request);
                    request.setAttribute("success", "Movie deleted successfully!");
                    break;
                default:
                    request.setAttribute("error", "Invalid action specified.");
            }
        } catch (Exception e) {
            Logger.getLogger(MovieCTL.class.getName()).log(Level.SEVERE, "Error processing Movie action", e);
            request.setAttribute("error", "Failed to process request: " + e.getMessage());
        }

        doGet(request, response);
    }

    private void addMovie(HttpServletRequest request) throws Exception {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String image_path = processImageUpload(request);

        try (Connection conn = JDBCDataSource.getConnection()) {
            String sql = "INSERT INTO movies (name, description, image_path) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, description);
                stmt.setString(3, image_path);
                stmt.executeUpdate();
            }
        }
    }

    private void updateMovie(HttpServletRequest request) throws Exception {
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        // First get the old image path
        String oldImagePath = null;
        try (Connection conn = JDBCDataSource.getConnection()) {
            String selectSql = "SELECT image_path FROM movies WHERE movie_id = ?";
            try (PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {
                selectStmt.setInt(1, movieId);
                ResultSet rs = selectStmt.executeQuery();
                if (rs.next()) {
                    oldImagePath = rs.getString("image_path");
                }
            }
        }

        // Process new image if uploaded
        String newImagePath = processImageUpload(request);

        try (Connection conn = JDBCDataSource.getConnection()) {
            String sql = newImagePath != null
                    ? "UPDATE movies SET name = ?, description = ?, image_path = ? WHERE movies_id = ?"
                    : "UPDATE moviess SET name = ?, description = ? WHERE movies_id = ?";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, description);
                if (newImagePath != null) {
                    stmt.setString(3, newImagePath);
                    stmt.setInt(4, movieId);
                    // Delete old image after successful update
                    if (oldImagePath != null) {
                        deleteImage(oldImagePath);
                    }
                } else {
                    stmt.setInt(3, movieId);
                }
                stmt.executeUpdate();
            }
        }
    }

    private void deleteMovie(HttpServletRequest request) throws Exception {
        int movieId = Integer.parseInt(request.getParameter("moviesId"));

        try (Connection conn = JDBCDataSource.getConnection()) {
            // First, get the image path to delete the file
            String selectSql = "SELECT image_path FROM movies WHERE movie_id = ?";
            try (PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {
                selectStmt.setInt(1, movieId);
                ResultSet rs = selectStmt.executeQuery();
                if (rs.next()) {
                    String image_path = rs.getString("image_path");
                    if (image_path != null) {
                        deleteImage(image_path);
                    }
                }
            }

            // Then delete the movie record
            String sql = "DELETE FROM movies WHERE movie_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, movieId);
                stmt.executeUpdate();
            }
        }
    }

    private String processImageUpload(HttpServletRequest request) throws Exception {
        Part filePart = request.getPart("image");
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        // Create upload directory if it doesn't exist
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Generate unique filename
        String fileName = UUID.randomUUID().toString() + getFileExtension(filePart);
        String filePath = uploadPath + File.separator + fileName;

        // Save file
        filePart.write(filePath);

        // Return relative path for database storage
        return "./" + UPLOAD_DIRECTORY + "/" + fileName;
    }

    private String getFileExtension(Part part) {
        String submittedFileName = part.getSubmittedFileName();
        return submittedFileName.substring(submittedFileName.lastIndexOf("."));
    }

    private void deleteImage(String image_path) {
        if (image_path != null && !image_path.isEmpty()) {
            String fullPath = getServletContext().getRealPath("") + image_path.substring(1);
            File imageFile = new File(fullPath);
            if (imageFile.exists()) {
                imageFile.delete();
            }
        }
    }
}
