package com.mycompany.moviebooking.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SeatBooking {
    private int id;
    private String seatNumber;
    private int showtimeId;
    private String seatStatus;

    public SeatBooking(String seatNumber, int showtimeId, String seatStatus) {
        this.seatNumber = seatNumber;
        this.showtimeId = showtimeId;
        this.seatStatus = seatStatus;
    }
}
