package com.mycompany.moviebooking.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SeatBooking {
    private int id;
    private int orderId;
    private String seatNumber;
    private int theatreId;
    private int showtimeId;
    private int seatStatus;

    public SeatBooking(String seatNumber, int theatreId, int showtimeId, int seatStatus) {
        this.seatNumber = seatNumber;
        this.theatreId = theatreId;
        this.showtimeId = showtimeId;
        this.seatStatus = seatStatus;
    }
}
