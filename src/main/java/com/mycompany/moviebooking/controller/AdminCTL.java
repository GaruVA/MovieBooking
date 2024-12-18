package com.mycompany.moviebooking.controller;

import com.google.gson.Gson;
import com.mycompany.moviebooking.utility.JDBCDataSource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "AdminCTL", urlPatterns = {"/admin"})
public class AdminCTL extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AdminCTL.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("./");
            return;
        }

        try (Connection conn = JDBCDataSource.getConnection()) {
            // Fetch number of movies
            String movieCountQuery = "SELECT COUNT(*) AS movie_count FROM movies";
            try (PreparedStatement stmt = conn.prepareStatement(movieCountQuery)) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    request.setAttribute("movieCount", rs.getInt("movie_count"));
                }
            }

            // Fetch number of theatres
            String theatreCountQuery = "SELECT COUNT(*) AS theatre_count FROM theatres";
            try (PreparedStatement stmt = conn.prepareStatement(theatreCountQuery)) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    request.setAttribute("theatreCount", rs.getInt("theatre_count"));
                }
            }

            // Fetch customer feedbacks
            String feedbackQuery = "SELECT rating, comment FROM feedback";
            try (PreparedStatement stmt = conn.prepareStatement(feedbackQuery)) {
                ResultSet rs = stmt.executeQuery();
                List<String> feedbacks = new ArrayList<>();
                int totalFeedbacks = 0;
                int totalRating = 0;
                while (rs.next()) {
                    feedbacks.add(rs.getInt("rating") + " - " + rs.getString("comment"));
                    totalFeedbacks++;
                    totalRating += rs.getInt("rating");
                }
                request.setAttribute("feedbacks", feedbacks);
                request.setAttribute("totalFeedbacks", totalFeedbacks);
                request.setAttribute("averageRating", totalFeedbacks > 0 ? (double) totalRating / totalFeedbacks : 0);
            }

            // Fetch sales data
            String salesQuery = "SELECT DATE(payment_date) AS date, SUM(amount) AS total_sales FROM bookings GROUP BY DATE(payment_date)";
            try (PreparedStatement stmt = conn.prepareStatement(salesQuery)) {
                ResultSet rs = stmt.executeQuery();
                List<SalesData> salesData = new ArrayList<>();
                double totalSales = 0;
                while (rs.next()) {
                    SalesData data = new SalesData();
                    data.setDate(rs.getString("date"));
                    data.setTotalSales(rs.getDouble("total_sales"));
                    totalSales += rs.getDouble("total_sales");
                    salesData.add(data);
                }
                request.setAttribute("totalSales", totalSales);
                Gson gson = new Gson();
                String salesDataJson = gson.toJson(salesData);
                request.setAttribute("salesDataJson", salesDataJson);
                LOGGER.log(Level.INFO, "Sales Data JSON: {0}", salesDataJson);
            }

            // Fetch most selected theatre
            String mostSelectedTheatreQuery = "SELECT t.name, COUNT(b.booking_id) AS count FROM bookings b " +
                                              "JOIN showtimes s ON b.showtime_id = s.showtime_id " +
                                              "JOIN theatres t ON s.theatre_id = t.theatre_id " +
                                              "GROUP BY t.name ORDER BY count DESC LIMIT 1";
            try (PreparedStatement stmt = conn.prepareStatement(mostSelectedTheatreQuery)) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    request.setAttribute("mostSelectedTheatre", rs.getString("name"));
                }
            }

            // Fetch most selected movie
            String mostSelectedMovieQuery = "SELECT m.title, COUNT(b.booking_id) AS count FROM bookings b " +
                                            "JOIN showtimes s ON b.showtime_id = s.showtime_id " +
                                            "JOIN movies m ON s.movie_id = m.movie_id " +
                                            "GROUP BY m.title ORDER BY count DESC LIMIT 1";
            try (PreparedStatement stmt = conn.prepareStatement(mostSelectedMovieQuery)) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    request.setAttribute("mostSelectedMovie", rs.getString("title"));
                }
            }

            // Fetch preferred time slots
            String preferredTimeSlotsQuery = "SELECT s.show_time, COUNT(b.booking_id) AS count FROM bookings b " +
                                             "JOIN showtimes s ON b.showtime_id = s.showtime_id " +
                                             "GROUP BY s.show_time ORDER BY count DESC LIMIT 1";
            try (PreparedStatement stmt = conn.prepareStatement(preferredTimeSlotsQuery)) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    request.setAttribute("preferredTimeSlot", rs.getString("show_time"));
                }
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error fetching admin data", e);
            request.setAttribute("error", "Error fetching admin data: " + e.getMessage());
        }

        request.getRequestDispatcher("/admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle admin panel form submissions or actions here
    }

    private class SalesData {
        private String date;
        private double totalSales;

        public String getDate() {
            return date;
        }

        public void setDate(String date) {
            this.date = date;
        }

        public double getTotalSales() {
            return totalSales;
        }

        public void setTotalSales(double totalSales) {
            this.totalSales = totalSales;
        }
    }
}
