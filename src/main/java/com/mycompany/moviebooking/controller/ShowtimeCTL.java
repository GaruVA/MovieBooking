package com.mycompany.moviebooking.controller;

import com.google.gson.Gson;
import com.mycompany.moviebooking.model.Movie;
import com.mycompany.moviebooking.model.Showtime;
import com.mycompany.moviebooking.model.Theatre;
import com.mycompany.moviebooking.utility.JDBCDataSource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "showtimes", urlPatterns = {"/showtimes"})
public class ShowtimeCTL extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Retrieve parameters from the request
        String movieId = request.getParameter("movie_id");
        String theatreId = request.getParameter("theatre_id");
        String showDate = request.getParameter("show_date");

        // Validate `show_date` parameter
        if (showDate == null || showDate.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Missing required parameter: show_date\"}");
            return;
        }

        List<Showtime> showtimes = new ArrayList<>();

        try (Connection connection = JDBCDataSource.getConnection()) {
            StringBuilder query = new StringBuilder(
                "SELECT s.showtime_id, s.movie_id, m.title AS movie_title, s.theatre_id, t.name AS theatre_name, " +
                "s.show_date, s.show_time " +
                "FROM showtimes s " +
                "JOIN movies m ON s.movie_id = m.movie_id " +
                "JOIN theatres t ON s.theatre_id = t.theatre_id " +
                "WHERE s.show_date = ?"
            );

            // Append conditions for optional parameters
            if (movieId != null && !movieId.isEmpty()) {
                query.append(" AND s.movie_id = ?");
            }
            if (theatreId != null && !theatreId.isEmpty()) {
                query.append(" AND s.theatre_id = ?");
            }

            PreparedStatement preparedStatement = connection.prepareStatement(query.toString());
            preparedStatement.setString(1, showDate);

            int paramIndex = 2;
            if (movieId != null && !movieId.isEmpty()) {
                preparedStatement.setInt(paramIndex++, Integer.parseInt(movieId));
            }
            if (theatreId != null && !theatreId.isEmpty()) {
                preparedStatement.setInt(paramIndex++, Integer.parseInt(theatreId));
            }

            ResultSet resultSet = preparedStatement.executeQuery();

            // Process the results
            while (resultSet.next()) {
                // Create Movie and Theatre objects
                Movie movie = new Movie();
                movie.setId(resultSet.getInt("movie_id"));
                movie.setTitle(resultSet.getString("movie_title"));

                Theatre theatre = new Theatre();
                theatre.setId(resultSet.getInt("theatre_id"));
                theatre.setName(resultSet.getString("theatre_name"));

                // Create Showtime object with Movie and Theatre references
                Showtime showtime = new Showtime(
                    resultSet.getInt("showtime_id"),
                    movie,
                    theatre,
                    resultSet.getString("show_date"),
                    resultSet.getString("show_time")
                );
                showtimes.add(showtime);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Internal server error\"}");
            return;
        }

        // Convert the showtimes to JSON and write to response
        PrintWriter out = response.getWriter();
        out.write(new Gson().toJson(showtimes));
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // For this example, we are not handling POST requests
        response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        response.getWriter().write("{\"error\":\"POST method not allowed\"}");
    }

    @Override
    public String getServletInfo() {
        return "Showtime Controller";
    }
}