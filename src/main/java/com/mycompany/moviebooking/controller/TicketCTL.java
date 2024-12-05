package com.mycompany.moviebooking.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


@WebServlet(name = "TicketCTL", urlPatterns = {"/TicketCTL"})
public class TicketCTL extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String bookingId = request.getParameter("bookingId"); // Passed via query parameter
    if (bookingId == null || bookingId.isEmpty()) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing booking ID");
        return;
    }

    try {
        // Database connection
        String url = "jdbc:mysql://localhost:3306/mysql?zeroDateTimeBehavior=CONVERT_TO_NULL";
        String username = "root";
        String password = "ReapER@1125";
        Connection connection = DriverManager.getConnection(url, username, password);

        // SQL query to fetch booking and seat details
        String sql = "SELECT b.booking_id, b.movie_name, b.date, b.time, s.seat_number, b.ticket_id, b.quantity, "
                   + "b.internet_fees, b.amount_paid, b.booking_date_time, b.payment_type, b.confirmation_number "
                   + "FROM booking b JOIN Seat s ON b.booking_id = s.booking_id WHERE b.booking_id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setString(1, bookingId);

        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            // Pass data to the JSP
            request.setAttribute("booking_id", rs.getString("booking_id"));
            request.setAttribute("movie_name", rs.getString("movie_name"));
            request.setAttribute("date", rs.getString("date"));
            request.setAttribute("time", rs.getString("time"));
            request.setAttribute("seat_number", rs.getString("seat_number"));
            request.setAttribute("ticket_id", rs.getString("ticket_id"));
            request.setAttribute("quantity", rs.getInt("quantity"));
            request.setAttribute("internet_fees", rs.getDouble("internet_fees"));
            request.setAttribute("amount_paid", rs.getDouble("amount_paid"));
            request.setAttribute("booking_date_time", rs.getString("booking_date_time"));
            request.setAttribute("payment_type", rs.getString("payment_type"));
            request.setAttribute("confirmation_number", rs.getString("confirmation_number"));
        } else {
            request.setAttribute("error", "No booking found for ID: " + bookingId);
        }

        // Close resources
        rs.close();
        stmt.close();
        connection.close();

        // Forward to JSP
        request.getRequestDispatcher("ticket.jsp").forward(request, response);

    } catch (Exception e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving booking details");
    }
}

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
