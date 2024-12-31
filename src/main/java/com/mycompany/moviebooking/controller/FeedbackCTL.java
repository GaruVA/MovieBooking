package com.mycompany.moviebooking.controller;

import com.mycompany.moviebooking.model.Feedback;
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

@WebServlet(name = "feedback", urlPatterns = {"/feedback"})
public class FeedbackCTL extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && "admin".equals(session.getAttribute("role"))) {
            try (Connection conn = JDBCDataSource.getConnection()) {
                String feedbackQuery = "SELECT rating, comment FROM feedback ORDER BY feedback_id DESC";
                try (PreparedStatement stmt = conn.prepareStatement(feedbackQuery)) {
                    ResultSet rs = stmt.executeQuery();
                    List<Feedback> feedbacks = new ArrayList<>();
                    while (rs.next()) {
                        Feedback feedback = new Feedback();
                        feedback.setRating(rs.getInt("rating"));
                        feedback.setComment(rs.getString("comment"));
                        feedbacks.add(feedback);
                    }
                    request.setAttribute("feedbacks", feedbacks);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        request.getRequestDispatcher("/feedback.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data
        String comment = request.getParameter("comment");
        String ratingStr = request.getParameter("rating");

        if (ratingStr == null || ratingStr.isEmpty()) {
            // Handle the error, e.g., redirect back to the form with an error message
            request.setAttribute("error", "Rating is required.");
            request.getRequestDispatcher("/feedback.jsp").forward(request, response);
            return;
        }

        int rating = Integer.parseInt(ratingStr); // Retrieve rating

        Feedback feedback = new Feedback();
        feedback.setComment(comment);
        feedback.setRating(rating); // Set rating

        // Database logic directly in the servlet
        String sql = "INSERT INTO feedback (comment, rating) VALUES (?, ?)";

        try (Connection con = JDBCDataSource.getConnection(); PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, comment);
            ps.setInt(2, rating); // Set rating

            boolean addFeedback = false;

            int rowsInserted = ps.executeUpdate();

            // Get the generated feedback_id (auto-incremented)
            if (rowsInserted > 0) {
                addFeedback = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Forward to feedback.jsp with success message
        request.setAttribute("success", "Thank you for your feedback!");
        request.getRequestDispatcher("/feedback.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for user feedback";
    }

}
