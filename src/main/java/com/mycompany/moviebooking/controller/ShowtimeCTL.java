/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.moviebooking.controller;

import com.google.gson.Gson;
import com.mycompany.moviebooking.model.Showtime;
import com.mycompany.moviebooking.utility.JDBCDataSource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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

        // Retrieve parameters from the request
        String movieId = request.getParameter("movie_id");
        String theatreId = request.getParameter("theatre_id");
        String showDate = request.getParameter("show_date");

        // Validate `show_date` parameter
        if (showDate == null || showDate.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Missing required parameter: show_date\"}");
            return;
        }

        List<Showtime> showtimes = new ArrayList<>();


        try (Connection connection = JDBCDataSource.getConnection()) {
            StringBuilder query = new StringBuilder(
                "SELECT s.showtime_id, s.movie_id, m.title AS movie_title, s.theatre_id, t.name AS theatre_name, " +
                "s.show_date, s.show_time, s.available_seats " +
                "FROM showtimes s " +
                "JOIN movies m ON s.movie_id = m.movie_id " +
                "JOIN theatres t ON s.theatre_id = t.theatre_id " +
                "WHERE s.show_date = ?"
            );

            // Append conditions for optional parameters
            if (movieId != null && !movieId.isEmpty()) {
                query.append(" AND s.movie_id = ?");
            }
            if (theatreId != null && !theatreId.isEmpty()) {
                query.append(" AND s.theatre_id = ?");
            }

            PreparedStatement preparedStatement = connection.prepareStatement(query.toString());
            preparedStatement.setString(1, showDate);

            int paramIndex = 2;
            if (movieId != null && !movieId.isEmpty()) {
                preparedStatement.setInt(paramIndex++, Integer.parseInt(movieId));
            }
            if (theatreId != null && !theatreId.isEmpty()) {
                preparedStatement.setInt(paramIndex++, Integer.parseInt(theatreId));
            }

            ResultSet resultSet = preparedStatement.executeQuery();

            // Process the results
            while (resultSet.next()) {
                Showtime showtime = new Showtime(
                    resultSet.getInt("showtime_id"),
                    resultSet.getInt("movie_id"),
                    resultSet.getString("movie_title"),
                    resultSet.getInt("theatre_id"),
                    resultSet.getString("theatre_name"),
                    resultSet.getString("show_date"),
                    resultSet.getString("show_time"),
                    resultSet.getInt("available_seats")
                );
                showtimes.add(showtime);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Internal server error\"}");
            return;
        }

        // Convert the showtimes to JSON and write to response
        PrintWriter out = response.getWriter();
        out.write(new Gson().toJson(showtimes));
        out.flush();
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
