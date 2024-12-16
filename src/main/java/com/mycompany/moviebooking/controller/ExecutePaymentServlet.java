package com.mycompany.moviebooking.controller;

import com.mycompany.moviebooking.utility.PayPalConfig;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.PaymentExecution;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.mycompany.moviebooking.utility.JDBCDataSource;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ExecutePaymentServlet", urlPatterns = {"/execute"})
public class ExecutePaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get PayPal parameters from the request
        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");

        // Obtain PayPal API context
        APIContext apiContext = PayPalConfig.getAPIContext();

        try {
            // Execute the payment using PayPal API
            Payment payment = new Payment();
            payment.setId(paymentId);

            PaymentExecution paymentExecution = new PaymentExecution();
            paymentExecution.setPayerId(payerId);

            // Execute payment
            Payment executedPayment = payment.execute(apiContext, paymentExecution);

            // Retrieve session attributes
            String seatNumbers = (String) request.getSession().getAttribute("selectedSeats");
            Double amount = (Double) request.getSession().getAttribute("totalPrice");
            Integer showtimeId = (Integer) request.getSession().getAttribute("showtime_id");
            Integer userId = (Integer) request.getSession().getAttribute("user_id");

            // Null check for session attributes
            if (seatNumbers == null || amount == null || showtimeId == null || userId == null) {
                System.err.println("Missing session attributes: seatNumbers, amount, showtimeId, or userId");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Session attributes are missing or invalid.");
                return;
            }

            // Extract payment method and status from executed payment
            String paymentMethod = executedPayment.getPayer().getPaymentMethod(); // e.g., "paypal"
            String paymentStatus = executedPayment.getState(); // e.g., "approved"

            // Save booking details to the database
            saveBooking(userId, seatNumbers, amount, showtimeId, paymentMethod, paymentStatus);

            // Pass attributes to success.jsp
            request.setAttribute("seatNumbers", seatNumbers);
            request.setAttribute("amount", amount);
            request.setAttribute("showtime_id", showtimeId);
            request.setAttribute("paymentMethod", paymentMethod);
            request.setAttribute("paymentStatus", paymentStatus);

            // Forward the request to success.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("success.jsp");
            dispatcher.forward(request, response);
        } catch (PayPalRESTException e) {
            e.printStackTrace();
            throw new ServletException("Error executing PayPal payment", e);
        }
    }

    // Updated method to save booking details in the bookings table
    private void saveBooking(Integer userId, String seatNumbers, Double amount, int showtimeId, String paymentMethod, String paymentStatus) {
        // Assuming you have a JDBC utility class to manage database connections
        try (Connection connection = JDBCDataSource.getConnection()) {
            String query = "INSERT INTO bookings (user_id, showtime_id, seat_numbers, amount, payment_date, payment_method, status) "
                         + "VALUES (?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement ps = connection.prepareStatement(query)) {
                ps.setInt(1, userId);  // Set user ID
                ps.setInt(2, showtimeId);  // Set showtime ID
                ps.setString(3, seatNumbers);  // Set seat numbers
                ps.setDouble(4, amount);  // Set amount
                ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));  // Set payment date
                ps.setString(6, paymentMethod);  // Set payment method (e.g., 'PayPal')
                ps.setString(7, paymentStatus);  // Set status (e.g., 'approved')

                ps.executeUpdate();
                System.out.println("Booking saved successfully with payment method: " + paymentMethod);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error saving booking", e);
        } catch (Exception ex) {
            Logger.getLogger(ExecutePaymentServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
