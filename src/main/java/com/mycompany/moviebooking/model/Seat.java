package com.mycompany.moviebooking.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Seat {
    private String seatNumber;
    private int showtimeId;
    private String seatStatus;
}
