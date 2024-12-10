/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/fetch_price")
public class MoviePriceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String movieName = request.getParameter("movieName");
        float price = 0.0f;
        float tax = 0.0f;
        float total = 0.0f;

        // Fetch movie price from the database
        try (Connection connection = JDBCDataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(
                     "SELECT price FROM bookings WHERE movie_name = ?")) {
            stmt.setString(1, movieName);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    price = rs.getFloat("price");
                } else {
                    request.setAttribute("errorMessage", "Movie not found.");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                    return;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error occurred.");
        } catch (Exception ex) {
            Logger.getLogger(MoviePriceServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Calculate tax and total
        tax = price * 0.05f; // 5% tax
        total = price + tax;

        // Set attributes to display on JSP
        request.setAttribute("movieName", movieName);
        request.setAttribute("price", price);
        request.setAttribute("tax", tax);
        request.setAttribute("total", total);

        // Forward to payment.jsp
        request.getRequestDispatcher("payment_form.jsp").forward(request, response);
    }
}
