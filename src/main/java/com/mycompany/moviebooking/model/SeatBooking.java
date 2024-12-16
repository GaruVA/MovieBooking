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

    public SeatBooking(int id,String seatNumber, int showtimeId, String seatStatus) {
        this.id=id;
        this.seatNumber = seatNumber;
        this.showtimeId = showtimeId;
        this.seatStatus = seatStatus;
    }
    
    public SeatBooking(String seatNumber, String seatStatus) {
        this.seatNumber = seatNumber;
        this.seatStatus = seatStatus;
    }

    // Getter for seatNumber
    public String getSeatNumber() {
        return seatNumber;
    }

    // Getter for seatStatus
    public String getSeatStatus() {
        return seatStatus;
    }
}

