package com.mycompany.moviebooking.model;

public class Showtime {
    private int showtimeId;
    private int movieId;
    private String movieTitle;
    private int theatreId;
    private String theatreName;
    private String showDate;
    private String showTime;
    private int availableSeats;

    // Constructor
    public Showtime(int showtimeId, int movieId, String movieTitle, int theatreId, String theatreName,
                    String showDate, String showTime, int availableSeats) {
        this.showtimeId = showtimeId;
        this.movieId = movieId;
        this.movieTitle = movieTitle;
        this.theatreId = theatreId;
        this.theatreName = theatreName;
        this.showDate = showDate;
        this.showTime = showTime;
        this.availableSeats = availableSeats;
    }

    // Getters
    public int getShowtimeId() {
        return showtimeId;
    }

    public int getMovieId() {
        return movieId;
    }

    public String getMovieTitle() {
        return movieTitle;
    }

    public int getTheatreId() {
        return theatreId;
    }

    public String getTheatreName() {
        return theatreName;
    }

    public String getShowDate() {
        return showDate;
    }

    public String getShowTime() {
        return showTime;
    }

    public int getAvailableSeats() {
        return availableSeats;
    }

    // Setters
    public void setShowtimeId(int showtimeId) {
        this.showtimeId = showtimeId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }

    public void setTheatreId(int theatreId) {
        this.theatreId = theatreId;
    }

    public void setTheatreName(String theatreName) {
        this.theatreName = theatreName;
    }

    public void setShowDate(String showDate) {
        this.showDate = showDate;
    }

    public void setShowTime(String showTime) {
        this.showTime = showTime;
    }

    public void setAvailableSeats(int availableSeats) {
        this.availableSeats = availableSeats;
    }
}
