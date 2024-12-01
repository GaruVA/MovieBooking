package com.mycompany.moviebooking.controller;

import com.mycompany.moviebooking.model.Movie;
import com.mycompany.moviebooking.utility.JDBCDataSource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "movies", urlPatterns = {"/movies"})
public class MovieCTL extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Movie> movies = new ArrayList<>();
        List<Movie> nowShowMovies = new ArrayList<>();

        try (Connection conn = JDBCDataSource.getConnection()) {
            String sql = "SELECT * FROM movies";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
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
                    movies.add(movie);
                }
            }

        } catch (SQLException e) {
            Logger.getLogger(MovieCTL.class.getName()).log(Level.SEVERE, "Error fetching movies", e);
            request.setAttribute("error", "Failed to load movies. Please try again later.");
        } catch (Exception ex) {
            Logger.getLogger(MovieCTL.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "An unexpected error occurred.");
        }

//        request.setAttribute("moviess", movies);
//        request.getRequestDispatcher("/movies.jsp").forward(request, response);
//        
         // Set both lists as request attributes
        request.setAttribute("moviess", movies);         // All movies
     

        // Forward to index.jsp once
        request.getRequestDispatcher("/movies.jsp").forward(request, response);
    }

//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet MovieServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet MovieServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        // processRequest(request, response);
//        response.setContentType("application/json");
//        response.setCharacterEncoding("UTF-8");
//
//        List<Movie> movies = new ArrayList<>();
//
//        try (Connection conn = JDBCDataSource.getConnection()) {
//            String sql = "SELECT * FROM movies WHERE status='Now Showing'";
//            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
//                ResultSet rs = stmt.executeQuery();
//                while (rs.next()) {
//                    Movie movie = new Movie();
//                    movie.setId(rs.getInt("movie_id"));
//                    movie.setTitle(rs.getString("title"));
//                    // ... set other properties
//                    movies.add(movie);
//                }
//            }
//        } catch (SQLException e) {
//            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
//            return;
//        } catch (Exception ex) {
//            Logger.getLogger(MovieCTL.class.getName()).log(Level.SEVERE, null, ex);
//        }
//
//        String json = new Gson().toJson(movies);
//        response.getWriter().write(json);
//    }
}
