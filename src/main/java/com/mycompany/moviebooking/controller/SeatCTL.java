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
            System.out.println(req.getParameter("showtime_id"));

            req.setAttribute("seatDetails",getBookedSeats(req));
        } catch (Exception e) {
            throw new ServletException("error",e);
        }
        req.getRequestDispatcher("/seatselections.jsp").forward(req, resp);

    }


    public List<SeatBooking> getBookedSeats(HttpServletRequest req) throws Exception {
        int showtimeId = Integer.parseInt(req.getParameter("showtime_id"));


        List<SeatBooking> seats = new ArrayList<>();
        try (Connection conn = JDBCDataSource.getConnection()) {
            int theaterId = 1;
            String sqlShowTimeDetails ="SELECT theatre_id FROM showtimes WHERE showtime_id= "+showtimeId+";";
            try (PreparedStatement stmt = conn.prepareStatement(sqlShowTimeDetails);
                 ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    theaterId=rs.getInt(1);
                }
            }
            String sql = "SELECT * FROM seat_booked_details s WHERE s.theatre_id = "+theaterId+" AND s.showtime_id ="+showtimeId+" ORDER BY s.id;";
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    System.out.println("Seat Details "+new SeatBooking(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getInt(4), rs.getInt(5), rs.getInt(6)));
                    seats.add(new SeatBooking(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getInt(4), rs.getInt(5), rs.getInt(6)));
                }
            }
        }
        System.out.println(seats);
        return seats;
    }
    public boolean bookSeat(HttpServletRequest req)throws Exception{
        try(Connection conn=JDBCDataSource.getConnection()){
            String sql ="";
            try(PreparedStatement stmt=conn.prepareStatement(sql)){
                return stmt.executeUpdate()<0;
            }
        }
    }
}