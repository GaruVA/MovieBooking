package com.mycompany.moviebooking.controller;

import com.mycompany.moviebooking.model.Theatre;
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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "theatres", urlPatterns = {"/theatres"})
public class TheatreCTL extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Theatre> theatres = new ArrayList<>();

        try (Connection conn = JDBCDataSource.getConnection()) {
            String sql = "SELECT * FROM theatres";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Theatre theatre = new Theatre();
                    theatre.setId(rs.getInt("theatre_id"));
                    theatre.setName(rs.getString("name"));
                    theatre.setLocation(rs.getString("location"));
                    theatre.setImagePath(rs.getString("image_path"));
                    theatres.add(theatre);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(TheatreCTL.class.getName()).log(Level.SEVERE, "Error fetching theatres", e);
            request.setAttribute("error", "Failed to load theatres. Please try again later.");
        } catch (Exception ex) {
            Logger.getLogger(TheatreCTL.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "An unexpected error occurred.");
        }

        request.setAttribute("theatres", theatres);
        request.getRequestDispatcher("/theatres.jsp").forward(request, response);
    }
}