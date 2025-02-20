package com.mycompany.moviebooking.controller;

import com.mycompany.moviebooking.model.Movie;
import com.mycompany.moviebooking.model.Theatre;
import com.mycompany.moviebooking.model.Showtime;
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
import java.time.LocalDate;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "booking-selection", urlPatterns = {"/booking-selection"})
public class BookingSelectionCTL extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set today's date
        LocalDate today = LocalDate.now();
        request.setAttribute("todayDate", today.toString());

        try {
            // Load initial data
            loadMovies(request);
            loadTheatres(request);

            // Load showtimes if date is provided
            String showDate = request.getParameter("show_date");
            if (showDate == null || showDate.isEmpty()) {
                showDate = today.toString();
            }

            String movieId = request.getParameter("movie_id");
            String theatreId = request.getParameter("theatre_id");

            loadShowtimes(request, showDate, movieId, theatreId);

        } catch (SQLException e) {
            Logger.getLogger(BookingSelectionCTL.class.getName()).log(Level.SEVERE, "Error loading data", e);
            request.setAttribute("error", "Failed to load data. Please try again later.");
        }

        request.getRequestDispatcher("/booking-selection.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try (Connection conn = JDBCDataSource.getConnection()) {
            if ("add".equals(action)) {
                addShowtime(request, conn);
                request.setAttribute("success", "Showtime added successfully.");
            } else if ("delete".equals(action)) {
                deleteShowtime(request, conn);
                request.setAttribute("success", "Showtime deleted successfully.");
            }
        } catch (SQLException e) {
            Logger.getLogger(BookingSelectionCTL.class.getName()).log(Level.SEVERE, "Error managing showtimes", e);
            request.setAttribute("error", "Failed to manage showtimes. Please try again later.");
        } catch (Exception ex) {
            Logger.getLogger(BookingSelectionCTL.class.getName()).log(Level.SEVERE, null, ex);
        }

        doGet(request, response);
    }

    private void addShowtime(HttpServletRequest request, Connection conn) throws SQLException {
        String sql = "INSERT INTO showtimes (movie_id, theatre_id, show_date, show_time) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, Integer.parseInt(request.getParameter("movie_id")));
            stmt.setInt(2, Integer.parseInt(request.getParameter("theatre_id")));
            stmt.setString(3, request.getParameter("show_date"));
            stmt.setString(4, request.getParameter("show_time"));
            stmt.executeUpdate();
        }
    }

    private void deleteShowtime(HttpServletRequest request, Connection conn) throws SQLException {
        String sql = "DELETE FROM showtimes WHERE showtime_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, Integer.parseInt(request.getParameter("showtime_id")));
            stmt.executeUpdate();
        }
    }

    private void loadMovies(HttpServletRequest request) throws SQLException {
        List<Movie> movies = new ArrayList<>();
        String sql = "SELECT movie_id, title FROM movies WHERE status='Now Showing' ORDER BY title";

        try (Connection conn = JDBCDataSource.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Movie movie = new Movie();
                movie.setId(rs.getInt("movie_id"));
                movie.setTitle(rs.getString("title"));
                movies.add(movie);
            }
        } catch (Exception ex) {
            Logger.getLogger(BookingSelectionCTL.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("movies", movies);
    }

    private void loadTheatres(HttpServletRequest request) throws SQLException {
        List<Theatre> theatres = new ArrayList<>();
        String sql = "SELECT theatre_id, name FROM theatres ORDER BY name";

        try (Connection conn = JDBCDataSource.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Theatre theatre = new Theatre();
                theatre.setId(rs.getInt("theatre_id"));
                theatre.setName(rs.getString("name"));
                theatres.add(theatre);
            }
        } catch (Exception ex) {
            Logger.getLogger(BookingSelectionCTL.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("theatres", theatres);
    }

    private void loadShowtimes(HttpServletRequest request, String showDate, String movieId, String theatreId)
            throws SQLException {

        StringBuilder sql = new StringBuilder(
                "SELECT s.showtime_id, s.movie_id, m.title AS movie_title, "
                + "s.theatre_id, t.name AS theatre_name, s.show_date, s.show_time "
                + "FROM showtimes s "
                + "JOIN movies m ON s.movie_id = m.movie_id "
                + "JOIN theatres t ON s.theatre_id = t.theatre_id "
                + "WHERE s.show_date = ?"
        );

        List<Object> params = new ArrayList<>();
        params.add(showDate);

        if (movieId != null && !movieId.isEmpty()) {
            sql.append(" AND s.movie_id = ?");
            params.add(Integer.parseInt(movieId));
        }

        if (theatreId != null && !theatreId.isEmpty()) {
            sql.append(" AND s.theatre_id = ?");
            params.add(Integer.parseInt(theatreId));
        }

        sql.append(" ORDER BY m.title, t.name, s.show_time");

        Map<Integer, MovieShowtimes> movieShowtimes = new HashMap<>();

        try (Connection conn = JDBCDataSource.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Movie movie = new Movie();
                movie.setId(rs.getInt("movie_id"));
                movie.setTitle(rs.getString("movie_title"));

                Theatre theatre = new Theatre();
                theatre.setId(rs.getInt("theatre_id"));
                theatre.setName(rs.getString("theatre_name"));

                Showtime showtime = new Showtime(
                        rs.getInt("showtime_id"),
                        movie,
                        theatre,
                        rs.getString("show_date"),
                        rs.getString("show_time")
                );

                movieShowtimes.computeIfAbsent(movie.getId(), k -> new MovieShowtimes(movie))
                        .addShowtime(theatre, showtime);
            }
        } catch (Exception ex) {
            Logger.getLogger(BookingSelectionCTL.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("movieShowtimes", movieShowtimes);
    }

    // Helper classes for organizing showtimes
    public static class MovieShowtimes {

        private final Movie movie;
        private final Map<Integer, TheatreShowtimes> theatres = new HashMap<>();

        public MovieShowtimes(Movie movie) {
            this.movie = movie;
        }

        public void addShowtime(Theatre theatre, Showtime showtime) {
            theatres.computeIfAbsent(theatre.getId(), k -> new TheatreShowtimes(theatre))
                    .addShowtime(showtime);
        }

        public Movie getMovie() {
            return movie;
        }

        public Map<Integer, TheatreShowtimes> getTheatres() {
            return theatres;
        }
    }

    public static class TheatreShowtimes {

        private final Theatre theatre;
        private final List<Showtime> showtimes = new ArrayList<>();

        public TheatreShowtimes(Theatre theatre) {
            this.theatre = theatre;
        }

        public void addShowtime(Showtime showtime) {
            showtimes.add(showtime);
        }

        public Theatre getTheatre() {
            return theatre;
        }

        public List<Showtime> getShowtimes() {
            return showtimes;
        }
    }
}
