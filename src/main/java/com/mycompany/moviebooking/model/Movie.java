package com.mycompany.moviebooking.model;

import java.sql.Date;
import java.sql.Time;

public class Movie {

    private int id;
    private String title;
    private String description;
    private Date release_date;
    private String status;
    private String genre;
    private Time duration;
    private String image_path;
    private Float imdb_rating;
    private String actor1;
    private String actor2;
    private String actor3;
    private String character1;
    private String character2;
    private String character3;
    private String director;
    private String produce;
    private String writer;
    private String music;
    private Date last_updated;

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getRelease_date() {
        return release_date;
    }

    public void setRelease_date(Date release_date) {
        this.release_date = release_date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public Time getDuration() {
        return duration;
    }

    public void setDuration(Time duration) {
        this.duration = duration;
    }

    public String getImage_path() {
        return image_path;
    }

    public void setImage_path(String image_path) {
        this.image_path = image_path;
    }

    public Float getImdb_rating() {
        return imdb_rating;
    }

    public void setImdb_rating(Float imdb_rating) {
        this.imdb_rating = imdb_rating;
    }
    
    public String getActor1() {
        return actor1;
    }

    public void setActor1(String actor1) {
        this.actor1 = actor1;
    }
    
    public String getActor2() {
        return actor2;
    }
    
     public void setActor2(String actor2) {
        this.title = actor2;
    }
     
     public String getActor3() {
        return actor3;
    }

    public void setActor3(String actor3) {
        this.title = actor3;
    }
    
    public String getCharacter1() {
        return character1;
    }

    public void setCharacter1(String character1) {
        this.character1 = character1;
    }
    
    public String getCharacter2() {
        return character2;
    }

    public void setCharacter2(String character2) {
        this.character2 = character2;
    }
    
    public String getCharacter3() {
        return character3;
    }

    public void setCharacter3(String character3) {
        this.character3 = character3;
    }
    
    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }
    
    public String getProduce() {
        return produce;
    }

    public void setProduce(String produce) {
        this.produce = produce;
    }
    
    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }
    
    public String getMusic() {
        return music;
    }

    public void setMusic(String music) {
        this.music = music;
    }
    
    public Date getLast_updated() {
        return last_updated;
    }

    public void setLast_updated(Date last_updated) {
        this.last_updated = last_updated;
    }
}
