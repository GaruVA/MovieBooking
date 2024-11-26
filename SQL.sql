CREATE TABLE movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    release_date DATE NOT NULL,
    status ENUM('Now Showing', 'Coming Soon') NOT NULL,
    genre VARCHAR(255),
    duration TIME,
    poster_path VARCHAR(255) NOT NULL,
    imdb_rating FLOAT(2, 1) DEFAULT NULL,
    last_updated DATETIME
);

CREATE TABLE theatres (
    theatre_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255)
);

CREATE TABLE showtimes (
    showtime_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    theatre_id INT,
    show_date DATE,
    show_time TIME,
    available_seats INT,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (theatre_id) REFERENCES theatres(theatre_id)
);


SELECT * FROM movies;

SELECT * FROM theatres;

SELECT * FROM showtimes;


INSERT INTO movies (movie_id, title, description, release_date, status, genre, duration, poster_path, imdb_rating, last_updated) VALUES 
(1, 'Inception', 'A thief who enters the dreams of others to steal their secrets gets a chance to regain his old life in exchange for planting an idea in a CEO\'s mind.', '2010-07-16', 'Now Showing', 'Sci-Fi/Action', '02:28:00', '/images/inception.jpg', 8.8, NOW()),
(2, 'The Dark Knight', 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.', '2008-07-18', 'Now Showing', 'Action/Crime/Drama', '02:32:00', '/images/dark_knight.jpg', 9.0, NOW()),
(3, 'Interstellar', 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.', '2014-11-07', 'Now Showing', 'Sci-Fi/Adventure', '02:49:00', '/images/interstellar.jpg', 8.6, NOW());

INSERT INTO theatres (theatre_id, name, location) VALUES
(1, 'Cinema City', '123 Main Street, Downtown'),
(2, 'Starlight Theatre', '456 Park Avenue, Uptown');

INSERT INTO showtimes (movie_id, theatre_id, show_date, show_time, available_seats)
VALUES
    -- Inception at Cinema City
    (1, 1, CURRENT_DATE, '10:00:00', 100),
    (1, 1, CURRENT_DATE, '13:00:00', 100),
    (1, 1, CURRENT_DATE + INTERVAL 1 DAY, '10:00:00', 100),
    (1, 1, CURRENT_DATE + INTERVAL 1 DAY, '13:00:00', 100),
    (1, 1, CURRENT_DATE + INTERVAL 1 DAY, '16:00:00', 100),
    (1, 1, CURRENT_DATE + INTERVAL 2 DAY, '10:00:00', 100),
    -- Inception at Starlight Theatre
    (1, 2, CURRENT_DATE, '11:00:00', 120),
    (1, 2, CURRENT_DATE, '14:00:00', 120),
    (1, 2, CURRENT_DATE + INTERVAL 1 DAY, '11:00:00', 120),
    (1, 2, CURRENT_DATE + INTERVAL 1 DAY, '14:00:00', 120),
    (1, 2, CURRENT_DATE + INTERVAL 2 DAY, '11:00:00', 120),
    (1, 2, CURRENT_DATE + INTERVAL 2 DAY, '14:00:00', 120),
    (1, 2, CURRENT_DATE + INTERVAL 2 DAY, '17:00:00', 120),
    -- The Dark Knight at Cinema City
    (2, 1, CURRENT_DATE, '11:30:00', 100),
    (2, 1, CURRENT_DATE + INTERVAL 1 DAY, '11:30:00', 100),
    (2, 1, CURRENT_DATE + INTERVAL 2 DAY, '11:30:00', 100),
    (2, 1, CURRENT_DATE + INTERVAL 2 DAY, '14:30:00', 100),
    -- The Dark Knight at Starlight Theatre
    (2, 2, CURRENT_DATE, '10:30:00', 120),
    (2, 2, CURRENT_DATE + INTERVAL 1 DAY, '10:30:00', 120),
    (2, 2, CURRENT_DATE + INTERVAL 1 DAY, '13:30:00', 120),
    (2, 2, CURRENT_DATE + INTERVAL 2 DAY, '10:30:00', 120),
    (2, 2, CURRENT_DATE + INTERVAL 2 DAY, '13:30:00', 120),
    (2, 2, CURRENT_DATE + INTERVAL 2 DAY, '16:30:00', 120),
    -- Interstellar at Cinema City
    (3, 1, CURRENT_DATE, '12:00:00', 100),
    (3, 1, CURRENT_DATE, '15:00:00', 100),
    (3, 1, CURRENT_DATE + INTERVAL 1 DAY, '12:00:00', 100),
    (3, 1, CURRENT_DATE + INTERVAL 1 DAY, '15:00:00', 100),
    (3, 1, CURRENT_DATE + INTERVAL 2 DAY, '12:00:00', 100),
    (3, 1, CURRENT_DATE + INTERVAL 2 DAY, '15:00:00', 100),
    (3, 1, CURRENT_DATE + INTERVAL 2 DAY, '18:00:00', 100),
    -- Interstellar at Starlight Theatre
    (3, 2, CURRENT_DATE, '11:00:00', 120),
    (3, 2, CURRENT_DATE, '14:00:00', 120),
    (3, 2, CURRENT_DATE + INTERVAL 1 DAY, '11:00:00', 120),
    (3, 2, CURRENT_DATE + INTERVAL 1 DAY, '14:00:00', 120),
    (3, 2, CURRENT_DATE + INTERVAL 2 DAY, '11:00:00', 120),
    (3, 2, CURRENT_DATE + INTERVAL 2 DAY, '14:00:00', 120);