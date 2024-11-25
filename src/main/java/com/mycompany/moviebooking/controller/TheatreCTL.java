package com.mycompany.moviebooking.controller;

import com.google.gson.Gson;
import com.mycompany.moviebooking.model.Theatre;
import com.mycompany.moviebooking.utility.JDBCDataSource;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author User
 */
@WebServlet(name = "theatres", urlPatterns = {"/theatres"})
public class TheatreCTL extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TheatreCTL</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TheatreCTL at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // processRequest(request, response);
//        String movieId = request.getParameter("movie_id");
//        response.setContentType("application/json");
//
//        try {
//            // Fetch theatres using DAO
//            List<Theatre> theatres = TheatreDAO.getTheatresByMovie(Integer.parseInt(movieId));
//
//            // Convert to JSON
//            PrintWriter out = response.getWriter();
//            out.print("[");
//            boolean first = true;
//            for (Theatre theatre : theatres) {
//                if (!first) out.print(",");
//                out.print("{\"theatre_id\": " + theatre.getId() +
//                           ", \"name\": \"" + theatre.getName() + "\"" +
//                           ", \"location\": \"" + theatre.getLocation() + "\"}");
//                first = false;
//            }
//            out.print("]");
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
//        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

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
                    theatres.add(theatre);
                }
            }
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        } catch (Exception ex) {
            Logger.getLogger(TheatreCTL.class.getName()).log(Level.SEVERE, null, ex);
        }

        String json = new Gson().toJson(theatres);
        response.getWriter().write(json);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
