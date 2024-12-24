package com.mycompany.moviebooking.controller;

import com.mycompany.moviebooking.model.User;
import com.mycompany.moviebooking.utility.EmailSenderUtility;
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

@WebServlet(name = "register", urlPatterns = {"/register"})
public class RegisterCTL extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        // Default role for new user
        String role = "user";

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(password);
        user.setRole(role);

        boolean isRegistered = false;

        // Database logic directly in the servlet
        String sql = "INSERT INTO users (username, email, phone, password, role) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = JDBCDataSource.getConnection(); PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, password); // Password should be hashed in production
            ps.setString(5, role);

            int rowsInserted = ps.executeUpdate();

            // Get the generated user_id (auto-incremented)
            if (rowsInserted > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    user.setUserId(generatedKeys.getInt(1));
                }
                isRegistered = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect based on the registration result
        if (isRegistered) {
            // Send welcome email
            sendWelcomeEmail(user);
            response.sendRedirect("login?success=true");
        } else {
            response.sendRedirect("register?error=true");
        }
    }

    private void sendWelcomeEmail(User user) {
        String subject = "Welcome to ABC Cinema!";
        String htmlContent = "<h1>Welcome to ABC Cinema, " + user.getUsername() + "!</h1>"
                + "<p>Thank you for registering with us. We are excited to have you as a part of our community.</p>"
                + "<p>At ABC Cinema, you can book tickets for the latest movies, check showtimes, and much more.</p>"
                + "<p>We hope you have a great experience with us!</p>"
                + "<p>Best Regards,<br>ABC Cinema Team</p>";

        EmailSenderUtility.sendEmailWithHtml(user.getEmail(), subject, htmlContent);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for user registration";
    }
}
