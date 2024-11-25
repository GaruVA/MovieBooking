/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.moviebooking.controller;

import com.google.gson.Gson;
import com.mycompany.moviebooking.model.Movie;
import com.mycompany.moviebooking.model.Showtime;
import com.mycompany.moviebooking.model.Theatre;
import com.mycompany.moviebooking.utility.JDBCDataSource;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author User
 */
@WebServlet(name = "showtimes", urlPatterns = {"/showtimes"})
public class ShowtimeCTL extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ShowtimeCTL</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ShowtimeCTL at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // processRequest(request, response);
response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String movieId = request.getParameter("movie_id");
        String theatreId = request.getParameter("theatre_id");
        String showDate = request.getParameter("show_date");
        
        if (showDate == null || showDate.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        List<Showtime> showtimes = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT s.*, m.title, m.poster_url, t.name, t.location " +
            "FROM showtimes s " +
            "JOIN movies m ON s.movie_id = m.movie_id " +
            "JOIN theatres t ON s.theatre_id = t.theatre_id " +
            "WHERE s.show_date = ?"
        );
        
        List<Object> params = new ArrayList<>();
        params.add(showDate);
        
        if (movieId != null && !movieId.trim().isEmpty()) {
            sql.append(" AND s.movie_id = ?");
            params.add(Integer.parseInt(movieId));
        }
        
        if (theatreId != null && !theatreId.trim().isEmpty()) {
            sql.append(" AND s.theatre_id = ?");
            params.add(Integer.parseInt(theatreId));
        }
        
        try (Connection conn = JDBCDataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Showtime showtime = new Showtime();
                // Set showtime properties
                showtime.setShowtimeId(rs.getInt("showtime_id"));
                showtime.setMovieId(rs.getInt("movie_id"));
                showtime.setTheatreId(rs.getInt("theatre_id"));
                showtime.setShowDate(rs.getDate("show_date"));
                showtime.setShowTime(rs.getTime("show_time"));
                showtime.setAvailableSeats(rs.getInt("available_seats"));
                
                // Set movie and theatre properties
                Movie movie = new Movie();
                movie.setMovieId(rs.getInt("movie_id"));
                movie.setTitle(rs.getString("title"));
                movie.setPosterUrl(rs.getString("poster_url"));
                showtime.setMovie(movie);
                
                Theatre theatre = new Theatre();
                theatre.setTheatreId(rs.getInt("theatre_id"));
                theatre.setName(rs.getString("name"));
                theatre.setLocation(rs.getString("location"));
                showtime.setTheatre(theatre);
                
                showtimes.add(showtime);
            }
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        } catch (Exception ex) {
            Logger.getLogger(ShowtimeCTL.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String json = new Gson().toJson(showtimes);
        response.getWriter().write(json);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
