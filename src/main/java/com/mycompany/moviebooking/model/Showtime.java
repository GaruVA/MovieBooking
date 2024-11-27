package com.mycompany.moviebooking.model;

public class Showtime {
    private int id;
    private Movie movie; // Reference to Movie object
    private Theatre theatre; // Reference to Theatre object
    private String showDate;
    private String showTime;

    // Constructor
    public Showtime(int id, Movie movie, Theatre theatre, String showDate, String showTime) {
        this.id = id;
        this.movie = movie;
        this.theatre = theatre;
        this.showDate = showDate;
        this.showTime = showTime;
    }

    // Getters
    public int getId() {
        return id;
    }

    public Movie getMovie() {
        return movie;
    }

    public Theatre getTheatre() {
        return theatre;
    }

    public String getShowDate() {
        return showDate;
    }

    public String getShowTime() {
        return showTime;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }

    public void setTheatre(Theatre theatre) {
        this.theatre = theatre;
    }

    public void setShowDate(String showDate) {
        this.showDate = showDate;
    }

    public void setShowTime(String showTime) {
        this.showTime = showTime;
    }
}