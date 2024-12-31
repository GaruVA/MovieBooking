package com.mycompany.moviebooking.controller;

import com.google.gson.Gson;
import com.mycompany.moviebooking.model.Booking;
import com.mycompany.moviebooking.model.User;
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
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
                List<FeedbackData> feedbacks = new ArrayList<>();
                int totalFeedbacks = 0;
                int totalRating = 0;
                while (rs.next()) {
                    FeedbackData feedback = new FeedbackData();
                    feedback.setRating(rs.getInt("rating"));
                    feedback.setComment(rs.getString("comment"));
                    feedbacks.add(feedback);
                    totalFeedbacks++;
                    totalRating += rs.getInt("rating");
                }
                request.setAttribute("feedbacks", feedbacks);
                request.setAttribute("totalFeedbacks", totalFeedbacks);
                request.setAttribute("averageRating", totalFeedbacks > 0 ? (double) totalRating / totalFeedbacks : 0);
                Gson gson = new Gson();
                String feedbackDataJson = gson.toJson(feedbacks);
                request.setAttribute("feedbackDataJson", feedbackDataJson);
                LOGGER.log(Level.INFO, "Feedback Data JSON: {0}", feedbackDataJson);
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

            // Fetch bookings
            String bookingsQuery = "SELECT b.booking_id, b.user_id, m.title AS movie_title, t.name AS theatre_name, " +
                                   "CONCAT(s.show_date, ' ', s.show_time) AS showtime, b.seat_numbers, b.status " +
                                   "FROM bookings b " +
                                   "JOIN showtimes s ON b.showtime_id = s.showtime_id " +
                                   "JOIN movies m ON s.movie_id = m.movie_id " +
                                   "JOIN theatres t ON s.theatre_id = t.theatre_id " +
                                   "ORDER BY b.payment_date DESC";
            try (PreparedStatement stmt = conn.prepareStatement(bookingsQuery)) {
                ResultSet rs = stmt.executeQuery();
                List<Booking> bookings = new ArrayList<>();
                while (rs.next()) {
                    Booking booking = new Booking();
                    booking.setBookingId(rs.getInt("booking_id"));
                    booking.setUserId(rs.getInt("user_id"));
                    booking.setMovieTitle(rs.getString("movie_title"));
                    booking.setTheatreName(rs.getString("theatre_name"));
                    booking.setShowtime(rs.getString("showtime"));
                    booking.setSeatNumbers(rs.getString("seat_numbers"));
                    booking.setStatus(rs.getString("status"));
                    bookings.add(booking);
                }
                request.setAttribute("bookings", bookings);
                request.setAttribute("now", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            }

            // Fetch users
            String usersQuery = "SELECT user_id, username, email, role FROM users";
            try (PreparedStatement stmt = conn.prepareStatement(usersQuery)) {
                ResultSet rs = stmt.executeQuery();
                List<User> users = new ArrayList<>();
                while (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                    users.add(user);
                }
                request.setAttribute("users", users);
                request.setAttribute("currentUserId", session.getAttribute("user_id"));
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error fetching admin data", e);
            request.setAttribute("error", "Error fetching admin data: " + e.getMessage());
        }

        request.getRequestDispatcher("/admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("./");
            return;
        }

        String formType = request.getParameter("formType");
        String bookingId = request.getParameter("bookingId");
        String userId = request.getParameter("userId");

        try (Connection conn = JDBCDataSource.getConnection()) {
            // Handle booking cancellation
            if ("cancelBooking".equals(formType)) {
                cancelBooking(conn, Integer.parseInt(bookingId), request);
            } else if ("makeAdmin".equals(formType)) {
                updateUserRole(conn, Integer.parseInt(userId), "admin", request);
            } else if ("makeUser".equals(formType)) {
                updateUserRole(conn, Integer.parseInt(userId), "user", request);
            } else if ("deleteUser".equals(formType)) {
                deleteUser(conn, Integer.parseInt(userId), request);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error occurred");
        } catch (Exception ex) {
            request.setAttribute("error", "Something went wrong, please try again later.");
            LOGGER.log(Level.SEVERE, null, ex);
        }
        doGet(request, response);
    }

    private void cancelBooking(Connection conn, int bookingId, HttpServletRequest request) throws SQLException {
        String checkShowtimeQuery = "SELECT CONCAT(s.show_date, ' ', s.show_time) AS showtime FROM bookings b " +
                                    "JOIN showtimes s ON b.showtime_id = s.showtime_id " +
                                    "WHERE b.booking_id = ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkShowtimeQuery)) {
            checkStmt.setInt(1, bookingId);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                String showtimeStr = rs.getString("showtime");
                LocalDateTime showtime = LocalDateTime.parse(showtimeStr, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                if (showtime.isAfter(LocalDateTime.now())) {
                    String cancelQuery = "UPDATE bookings SET status = 'Cancelled' WHERE booking_id = ?";
                    try (PreparedStatement cancelStmt = conn.prepareStatement(cancelQuery)) {
                        cancelStmt.setInt(1, bookingId);
                        cancelStmt.executeUpdate();
                        request.setAttribute("success", "Booking cancelled successfully");
                    }
                } else {
                    request.setAttribute("error", "Cannot cancel booking as the showtime has already passed");
                }
            } else {
                request.setAttribute("error", "Booking not found or you do not have permission to cancel this booking");
            }
        }
    }

    private void updateUserRole(Connection conn, int userId, String role, HttpServletRequest request) throws SQLException {
        String updateRoleQuery = "UPDATE users SET role = ? WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(updateRoleQuery)) {
            stmt.setString(1, role);
            stmt.setInt(2, userId);
            stmt.executeUpdate();
            request.setAttribute("success", "User role updated successfully");
        }
    }

    private void deleteUser(Connection conn, int userId, HttpServletRequest request) throws SQLException {
        String deleteUserQuery = "DELETE FROM users WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(deleteUserQuery)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
            request.setAttribute("success", "User deleted successfully");
        }
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

    private class FeedbackData {
        private int rating;
        private String comment;

        public int getRating() {
            return rating;
        }

        public void setRating(int rating) {
            this.rating = rating;
        }

        public String getComment() {
            return comment;
        }

        public void setComment(String comment) {
            this.comment = comment;
        }
    }
}
