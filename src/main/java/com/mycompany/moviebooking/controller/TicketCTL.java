package com.mycompany.moviebooking.controller;

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

@WebServlet(name = "TicketCTL", urlPatterns = {"/TicketCTL"})
public class TicketCTL extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId"); // Passed via query parameter
        String mode = request.getParameter("mode");

        if (bookingId == null || bookingId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing booking ID");
            return;
        }

        try (Connection conn = JDBCDataSource.getConnection()) {
            // SQL query to fetch booking and seat details
            String sql = "SELECT b.booking_id, b.movie_name, b.date, b.time, b.ticket_id, b.quantity, "
                    + "b.internet_fees, b.amount_paid, b.booking_date_time, b.payment_type, b.confirmation_number, u.email "
                    + "FROM booking b JOIN users u ON b.user_id = u.user_id "
                    + "WHERE b.booking_id = ?";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, bookingId);

                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {

                    // Pass data to the JSP
                    request.setAttribute("booking_id", rs.getString("booking_id"));
                    request.setAttribute("movie_name", rs.getString("movie_name"));
                    request.setAttribute("date", rs.getString("date"));
                    request.setAttribute("time", rs.getString("time"));
                    //   request.setAttribute("seat_number", rs.getString("seat_number"));
                    request.setAttribute("ticket_id", rs.getString("ticket_id"));
                    request.setAttribute("quantity", rs.getInt("quantity"));
                    request.setAttribute("internet_fees", rs.getDouble("internet_fees"));
                    request.setAttribute("amount_paid", rs.getDouble("amount_paid"));
                    request.setAttribute("booking_date_time", rs.getString("booking_date_time"));
                    request.setAttribute("payment_type", rs.getString("payment_type"));
                    request.setAttribute("confirmation_number", rs.getString("confirmation_number"));

                    String ticketLink = "http://localhost:8081/moviebooking/TicketCTL?bookingId=" + bookingId;

                    // Assuming the user's email is part of the booking record
                    String userEmail = "sniperdragon2003@outlook.com"; // Replace with actual field if available
                    if (rs.getString("email") != null) {
                        userEmail = rs.getString("email");
                    }

                    // Create the email content
                    String emailContent = "<h1>Your E-Ticket</h1>"
                            + "<p>Click the link below to view your e-ticket:</p>"
                            + "<a href='" + ticketLink + "'>" + ticketLink + "</a>";

                    // Send the email
                    TicketEmailCTL.sendEmailWithHtml(userEmail, "Your E-Ticket", emailContent);

                    // Respond with confirmation
                    response.getWriter().println("E-ticket link sent to: " + userEmail);

                } else {
                    request.setAttribute("error", "No booking found for ID: " + bookingId);
                }
                // Close resources
                rs.close();
            }
            conn.close();

            // Forward to JSP
            request.getRequestDispatcher("ticket.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving booking details");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


    
}