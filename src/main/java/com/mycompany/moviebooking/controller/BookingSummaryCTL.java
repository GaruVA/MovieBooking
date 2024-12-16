package com.mycompany.moviebooking.controller;

import com.mycompany.moviebooking.model.Booking;
import com.mycompany.moviebooking.utility.JDBCDataSource;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "bookingsummary", urlPatterns = {"/bookingsummary"})
public class BookingSummaryCTL extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingID = request.getParameter("booking_id");

        try (Connection conn = JDBCDataSource.getConnection()) {
            String sql = "SELECT b.*, u.email, m.title as movie_name, s.show_date, s.show_time " +
                        "FROM bookings b " +
                        "INNER JOIN users u ON b.user_id = u.user_id " +
                        "INNER JOIN showtimes s ON b.showtime_id = s.showtime_id " +
                        "INNER JOIN movies m ON s.movie_id = m.movie_id " +
                        "WHERE b.booking_id = ?";
                        
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(bookingID));

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                // Create Booking object and set its properties
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setMovieTitle(rs.getString("movie_name"));
                booking.setShowtime(rs.getString("show_date") + " " + rs.getString("show_time"));
                booking.setSeatNumbers(rs.getString("seat_numbers"));
                booking.setStatus(rs.getString("status"));
                booking.setAmount(rs.getDouble("amount"));
                booking.setPaymentMethod(rs.getString("payment_method"));
                booking.setPaymentDate(rs.getString("payment_date"));

                String userEmail = rs.getString("email");

                // Send email
                String emailContent = createEmailContent(booking);
                EmailSenderCTL.sendEmailWithHtml(
                    userEmail,
                    "Your Booking Confirmation - ABC Cinema",
                    emailContent
                );

                // Set attributes and forward to JSP
                request.setAttribute("booking", booking);
                request.setAttribute("userEmail", userEmail);
                request.getRequestDispatcher("/bookingsummary.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Booking not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing booking");
        }
    }

    private String createEmailContent(Booking booking) {
        return "<h1>Your E-Ticket Details</h1>"
                + "<p><strong>Booking ID:</strong> " + booking.getBookingId() + "</p>"
                + "<p><strong>Movie:</strong> " + booking.getMovieTitle() + "</p>"
                + "<p><strong>Show Date:</strong> " + booking.getShowtime().split(" ")[0] + "</p>"
                + "<p><strong>Show Time:</strong> " + booking.getShowtime().split(" ")[1] + "</p>"
                + "<p><strong>Seat Numbers:</strong> " + booking.getSeatNumbers() + "</p>"
                + "<p><strong>Amount Paid:</strong> $" + booking.getAmount() + "</p>"
                + "<p>Thank you for booking with us!</p>";
    }
}
