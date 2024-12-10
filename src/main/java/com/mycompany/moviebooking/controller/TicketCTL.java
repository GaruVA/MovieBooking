package com.mycompany.moviebooking.controller;

import com.mycompany.moviebooking.utility.JDBCDataSource;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;


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
                    if ("email".equalsIgnoreCase(mode)) {
                        // Email sending logic
                        sendEmailNotification(rs.getString("email"), rs.getString("movie_name"), bookingId);
                        response.setStatus(HttpServletResponse.SC_OK); // Email sent successfully
                        return;
                    }
                                    
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

    private void sendEmailNotification(String recipientEmail, String movieName, String bookingId) {
        String host = "smtp.office365.com"; // Outlook SMTP server
        String from = "SniperDragon2003@outlook.com"; // Replace with your Outlook email
        String password = "Township@2003"; // Replace with your Outlook password

        // Email properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");

        try {
            // Session
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(from, password);
                }
            });

            // Construct the message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
            message.setSubject("Your Movie Ticket Confirmation");

            String ticketLink = "http://localhost:8081/moviebooking/TicketCTL?bookingId=" + bookingId;
            String emailBody = String.format(
                    "Dear Customer,\n\nYour ticket for '%s' has been successfully booked.\n"
                            + "You can view your ticket at the following link:\n%s\n\nThank you for booking with us!",
                    movieName, ticketLink);

            message.setText(emailBody);

            // Send the email
            Transport.send(message);
            System.out.println("Email sent successfully to " + recipientEmail);
        } catch (jakarta.mail.AuthenticationFailedException e) {
            System.err.println("Authentication failed: Please check your email credentials.");
            e.printStackTrace();
        } catch (jakarta.mail.MessagingException e) {
            System.err.println("Messaging error: Unable to send the email. Please check the recipient email address and SMTP server configuration.");
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("An unexpected error occurred while sending the email.");
            e.printStackTrace();
        }
    }
    
}