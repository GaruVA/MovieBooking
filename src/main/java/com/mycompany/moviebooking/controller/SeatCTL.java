package com.mycompany.moviebooking.controller;


import com.mycompany.moviebooking.model.SeatBooking;
import com.mycompany.moviebooking.utility.JDBCDataSource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.security.sasl.SaslException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "SeatSelectionServlet", urlPatterns = {"/seat-selection"})
public class SeatCTL extends HttpServlet {
    private final static JDBCDataSource jdbcDataSource;

    static {
        try {
            jdbcDataSource = JDBCDataSource.getInstance();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setAttribute("seatDetails", getBookedSeats(req));
        } catch (Exception e) {
            throw new ServletException("error", e);
        }
        req.getRequestDispatcher("/seatselections.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String[] selectedSeats = req.getParameter("selectedSeats").split(",");
            int showtimeId = Integer.parseInt(req.getParameter("showtime_id"));
            tempBookSeats(selectedSeats, showtimeId);
            req.setAttribute("selectedSeats", req.getParameter("selectedSeats"));
            req.setAttribute("totalPrice", req.getParameter("totalPrice"));
            req.setAttribute("showtime_id", req.getParameter("showtime_id"));
        } catch (Exception e) {
            throw new ServletException("error", e);
        }
        req.getRequestDispatcher("next-servlet").forward(req, resp);
    }

    public List<SeatBooking> getBookedSeats(HttpServletRequest req) throws Exception {
        int showtimeId = Integer.parseInt(req.getParameter("showtime_id"));
        List<SeatBooking> seats = new ArrayList<>();
        try (Connection conn = JDBCDataSource.getConnection()) {
            String sql = "SELECT id, seat_number, showtime_id, seat_status FROM seat_booked_details WHERE showtime_id = ? ORDER BY id;";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, showtimeId);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        seats.add(new SeatBooking(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4)));
                    }
                }
            }
        }
        return seats;
    }

    public void tempBookSeats(String[] seatNumbers, int showtimeId) throws Exception {
        try (Connection conn = JDBCDataSource.getConnection()) {
            String sql = "INSERT INTO seat_booked_details (seat_number, showtime_id, seat_status) VALUES (?, ?, 'Temp Booked')";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                for (String seatNumber : seatNumbers) {
                    stmt.setString(1, seatNumber);
                    stmt.setInt(2, showtimeId);
                    stmt.addBatch();
                }
                stmt.executeBatch();
            }
        }
    }

    public void finalizeBooking(String[] seatNumbers, int showtimeId) throws Exception {
        try (Connection conn = JDBCDataSource.getConnection()) {
            String sql = "UPDATE seat_booked_details SET seat_status = 'Booked' WHERE seat_number = ? AND showtime_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                for (String seatNumber : seatNumbers) {
                    stmt.setString(1, seatNumber);
                    stmt.setInt(2, showtimeId);
                    stmt.addBatch();
                }
                stmt.executeBatch();
            }
        }
    }
}