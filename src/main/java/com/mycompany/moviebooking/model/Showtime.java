package com.mycompany.moviebooking.model;

import java.util.Date;
import java.sql.Time;

public class Showtime {
    private int id;
    private int movieId;
    private int theatreId;
    private Date showDate;
    private Time showTime;
    private int availableSeats;
    private Movie movie;
    private Theatre theatre;

    // Getters and Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getMovieId() {
        return movieId;
    }
    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }
    public int getTheatreId() {
        return theatreId;
    }
    public void setTheatreId(int theatreId) {
        this.theatreId = theatreId;
    }
    public Date getShowDate() {
        return showDate;
    }
    public void setShowDate(Date showDate) {
        this.showDate = showDate;
    }
    public Time getShowTime() {
        return showTime;
    }
    public void setShowTime(Time showTime) {
        this.showTime = showTime;
    }
    public int getAvailableSeats() {
        return availableSeats;
    }
    public void setAvailableSeats(int availableSeats) {
        this.availableSeats = availableSeats;
    }

    public void setTheatre(Theatre theatre) {
        this.theatre = theatre;    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }

    public void setShowtimeId(int id) {
        this.id = id;
    }
}
