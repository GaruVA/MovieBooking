package com.mycompany.moviebooking.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "MoviesAdminLogin", urlPatterns = {"/movies-admin-login"})
public class MoviesAdminLoginCTL extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession();
        session.setAttribute("role", "admin");
        response.getWriter().println("Admin role set in session");
        response.getWriter().println("<a href='movies'>Go to Movies page</a>");
    }
}
