-- Select your database from the Connection drop-down above, usually it's "jdbc:mysql://localhost:3306/mysql?zeroDateTimeBehavior=CONVERT_TO_NULL [root on Default schema]"
-- Highlight the specific query or queries you want to execute
-- Right-click on the selected query and choose Run Selection

-- CREATE TABLE
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20)
);

CREATE TABLE movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    release_date DATE NOT NULL,
    status ENUM('Now Showing', 'Coming Soon') NOT NULL,
    genre VARCHAR(255),
    duration TIME,
    image_path VARCHAR(255) NOT NULL,
    imdb_rating FLOAT(2, 1) DEFAULT NULL,
    actors VARCHAR(255),
    characters VARCHAR(255),
    director VARCHAR(100),
    produce VARCHAR(100),
    writer VARCHAR(100),
    music VARCHAR(100),
    last_updated DATETIME
);

CREATE TABLE theatres (
    theatre_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    image_path VARCHAR(255) NOT NULL
);

CREATE TABLE showtimes (
    showtime_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    theatre_id INT,
    show_date DATE,
    show_time TIME,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (theatre_id) REFERENCES theatres(theatre_id)
);

CREATE TABLE temp_seats (
    id INT PRIMARY KEY AUTO_INCREMENT,
    seat_number VARCHAR(10),
    showtime_id INT,
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (showtime_id) REFERENCES showtimes(showtime_id)
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    showtime_id INT,
    seat_numbers VARCHAR(255),
    amount FLOAT,
    payment_date DATETIME,
    payment_method VARCHAR(50),
    status VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (showtime_id) REFERENCES showtimes(showtime_id)
);

CREATE TABLE feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,         
    rating INT CHECK (rating BETWEEN 1 AND 5),  
    comment VARCHAR(255),                             
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

-- Add trigger to remove "Temp Booked" seats after 5 minutes if not finalized
DELIMITER //

CREATE EVENT remove_temp_bookings
ON SCHEDULE EVERY 1 MINUTE
DO
BEGIN
    DELETE FROM temp_seats
    WHERE booking_time < NOW() - INTERVAL 5 MINUTE;
END //

DELIMITER ;

-- INSERT TEST DATA
INSERT INTO users (user_id, username, email, phone, password, role) VALUES
(1, 'admin', 'admin@example.com', '123-456-7890', 'password', 'admin'),
(2, 'user', 'user@example.com', '098-765-4321', 'password', 'user'),
(3, 'john_doe', 'john.doe@example.com', '111-222-3333', 'password', 'user'),
(4, 'jane_smith', 'jane.smith@example.com', '444-555-6666', 'password', 'user');

INSERT INTO movies (movie_id, title, description, release_date, status, genre, duration, image_path, imdb_rating, actors, characters, director, produce, writer, music, last_updated) VALUES 
(1, 'Inception', 'A thief who enters the dreams of others to steal their secrets gets a chance to regain his old life in exchange for planting an idea in a CEO’s mind.', '2010-07-16', 'Now Showing', 'Sci-Fi/Action', '02:28:00', './images/inception.jpg', 8.8, 'Leonardo DiCaprio,Joseph Gordon-Levitt,Elliot Page', 'Cobb,Arthur,Ariadne', 'Christopher Nolan', 'Emma Thomas', 'Christopher Nolan', 'Hans Zimmer', NOW()),
(2, 'The Dark Knight', 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.', '2008-07-18', 'Now Showing', 'Action/Crime/Drama', '02:32:00', './images/dark_knight.jpg', 9.0, 'Christian Bale,Heath Ledger,Aaron Eckhart', 'Bruce Wayne / Batman,Joker,Harvey Dent / Two-Face', 'Christopher Nolan', 'Emma Thomas', 'Jonathan Nolan', 'Hans Zimmer', NOW()),
(3, 'Interstellar', 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity’s survival.', '2014-11-07', 'Now Showing', 'Sci-Fi/Adventure', '02:49:00', './images/interstellar.jpg', 8.6, 'Matthew McConaughey,Anne Hathaway,Jessica Chastain', 'Cooper,Brand,Murph', 'Christopher Nolan', 'Emma Thomas', 'Jonathan Nolan', 'Hans Zimmer', NOW()),
(4, 'Dune: Part Two', 'A mythic and emotionally charged hero’s journey, Dune: Part Two will explore the mythic dimensions of Denis Villeneuve’s universe.', '2024-12-15', 'Coming Soon', 'Sci-Fi/Adventure', '02:30:00', './images/dune_part_two.jpg', 0.0, 'Timothée Chalamet,Zendaya,Rebecca Ferguson', 'Paul Atreides,Chani,Lady Jessica', 'Denis Villeneuve', 'Mary Parent', 'Jon Spaihts', 'Hans Zimmer', NOW()),
(5, 'Sonic 3', 'Sonic, Knuckles, and Tails reunite against a powerful new adversary, Shadow, a mysterious villain with powers unlike anything they have faced before. With their abilities outmatched, Team Sonic must seek out an unlikely alliance.', '2014-11-07', 'Coming Soon', 'Sci-Fi/Adventure', '02:30:00', './images/sonic3.jpg', 8.0, 'Jim Carrey,Ben Schwartz,Keanu Reeves', 'Ivo Robotnik/Gerald Robotnik,Sonic,Shadow', 'Jeff Fowler', 'Emma Thomas', 'Jonathan Nolan', 'Hans Zimmer', NOW()),
(6, 'The Nutcracker', 'Join Clara at a delightful Christmas Eve party that becomes a magical adventure once everyone else is tucked up in bed. Marvel at the brilliance of Tchaikovsky’s score, as Clara and her enchanted Nutcracker fight the Mouse King and visit the Sugar Plum Fairy in the glittering Kingdom of Sweets.', '2014-11-07', 'Coming Soon', 'Musical/Dance', '02:45:00', './images/theNutcracker.jpg', 5.6, 'The Prince,Anne Hathaway,Jessica Chastain', 'Leo Dixon,Marcelino Sambe,Murph', 'Christopher Nolan', 'Emma Thomas', 'Jonathan Nolan', 'Hans Zimmer', NOW()),
(7, 'The Wild Robot', 'After a shipwreck, an intelligent robot called Roz is stranded on an uninhabited island. To survive the harsh environment, Roz bonds with the island’s animals and cares for an orphaned baby goose.', '2014-11-07', 'Coming Soon', 'Sci-Fi/Adventure', '02:42:00', './images/theWildRobot.jpg', 0.0, 'Pedro Pascal,Kit Connor,Jessica Chastain', 'Roz/Rummagevoice),Fink(voice),Brightbill(voice)', 'Chris Sanders', 'Emma Thomas', 'Jonathan Nolan', 'Kris Bowers', NOW()),
(8, 'Wicked', 'Wicked tells the story of Elphaba, the future Wicked Witch of the West and her relationship with Glinda, the Good Witch of the North. Their friendship struggles through their opposing personalities and viewpoints, rivalry over the same love-interest, their reactions to the Wizard’s corrupt government, and, ultimately, Elphaba’s public fall from grace. ', '2014-12-28', 'Coming Soon', 'Fairy/Adventure', '02:40:00', './images/wicked.jpg', 7.6, 'Cynthia Erivo,Ariana Grande,Jonathan Bailey', 'Elphaba,Glinda,Fiyero', 'Jon M. Chu', 'Jared LeBoff', 'Jonathan Nolan', 'John Powell', NOW()),
(9, 'Red One', 'After Santa Claus (code name: Red One) is kidnapped, the North Pole’s Head of Security (Dwayne Johnson) must team up with the world’s most infamous bounty hunter (Chris Evans) in a globe-trotting, action-packed mission to save Christmas.', '2014-12-17', 'Now Showing', 'Sci-Fi/Comedy', '02:03:00', './images/redOne.jpg', 0.0, 'Dwayne Johnson,Chris Evans,Jessica Chastain', 'Callum Drift,Jack O’Malley,Zoe', 'Jake Kasdan', 'Emma Thomas', 'Jonathan Nolan', 'Henry Jackman', NOW());

INSERT INTO theatres (theatre_id, name, location, image_path) VALUES
(1, 'Cinema City', '123 Main Street, Downtown','./images/theatre1.jpg'),
(2, 'Starlight Theatre', '456 Park Avenue, Uptown','./images/theatre2.jpg'),
(3, 'Grand Cinema', '789 Broadway, Midtown','./images/theatre3.jpg');

INSERT INTO showtimes (showtime_id, movie_id, theatre_id, show_date, show_time)
VALUES
    (1, 1, 1, CURRENT_DATE, '10:00:00'),
    (2, 1, 1, CURRENT_DATE, '13:00:00'),
    (3, 1, 1, CURRENT_DATE + INTERVAL 1 DAY, '10:00:00'),
    (4, 1, 1, CURRENT_DATE + INTERVAL 1 DAY, '13:00:00'),
    (5, 1, 1, CURRENT_DATE + INTERVAL 1 DAY, '16:00:00'),
    (6, 1, 1, CURRENT_DATE + INTERVAL 2 DAY, '10:00:00'),
    (7, 1, 2, CURRENT_DATE, '11:00:00'),
    (8, 1, 2, CURRENT_DATE, '14:00:00'),
    (9, 1, 2, CURRENT_DATE + INTERVAL 1 DAY, '11:00:00'),
    (10, 1, 2, CURRENT_DATE + INTERVAL 1 DAY, '14:00:00'),
    (11, 1, 2, CURRENT_DATE + INTERVAL 2 DAY, '11:00:00'),
    (12, 1, 2, CURRENT_DATE + INTERVAL 2 DAY, '14:00:00'),
    (13, 1, 2, CURRENT_DATE + INTERVAL 2 DAY, '17:00:00'),
    (14, 2, 1, CURRENT_DATE, '11:30:00'),
    (15, 2, 1, CURRENT_DATE + INTERVAL 1 DAY, '11:30:00'),
    (16, 2, 1, CURRENT_DATE + INTERVAL 2 DAY, '11:30:00'),
    (17, 2, 1, CURRENT_DATE + INTERVAL 2 DAY, '14:30:00'),
    (18, 2, 2, CURRENT_DATE, '10:30:00'),
    (19, 2, 2, CURRENT_DATE + INTERVAL 1 DAY, '10:30:00'),
    (20, 2, 2, CURRENT_DATE + INTERVAL 1 DAY, '13:30:00'),
    (21, 2, 2, CURRENT_DATE + INTERVAL 2 DAY, '10:30:00'),
    (22, 2, 2, CURRENT_DATE + INTERVAL 2 DAY, '13:30:00'),
    (23, 2, 2, CURRENT_DATE + INTERVAL 2 DAY, '16:30:00'),
    (24, 3, 1, CURRENT_DATE, '12:00:00'),
    (25, 3, 1, CURRENT_DATE, '15:00:00'),
    (26, 3, 1, CURRENT_DATE + INTERVAL 1 DAY, '12:00:00'),
    (27, 3, 1, CURRENT_DATE + INTERVAL 1 DAY, '15:00:00'),
    (28, 3, 1, CURRENT_DATE + INTERVAL 2 DAY, '12:00:00'),
    (29, 3, 1, CURRENT_DATE + INTERVAL 2 DAY, '15:00:00'),
    (30, 3, 1, CURRENT_DATE + INTERVAL 2 DAY, '18:00:00'),
    (31, 3, 2, CURRENT_DATE, '11:00:00'),
    (32, 3, 2, CURRENT_DATE, '14:00:00'),
    (33, 3, 2, CURRENT_DATE + INTERVAL 1 DAY, '11:00:00'),
    (34, 3, 2, CURRENT_DATE + INTERVAL 1 DAY, '14:00:00'),
    (35, 3, 2, CURRENT_DATE + INTERVAL 2 DAY, '11:00:00'),
    (36, 3, 2, CURRENT_DATE + INTERVAL 2 DAY, '14:00:00'),
    (37, 4, 3, CURRENT_DATE, '10:00:00'),
    (38, 4, 3, CURRENT_DATE, '13:00:00'),
    (39, 4, 3, CURRENT_DATE + INTERVAL 1 DAY, '10:00:00'),
    (40, 4, 3, CURRENT_DATE + INTERVAL 1 DAY, '13:00:00'),
    (41, 4, 3, CURRENT_DATE + INTERVAL 1 DAY, '16:00:00'),
    (42, 4, 3, CURRENT_DATE + INTERVAL 2 DAY, '10:00:00');

INSERT INTO temp_seats (id, seat_number, showtime_id) VALUES
(1, 'L1C2', 1),
(2, 'R1C2', 2),
(3, 'L2C3', 3),
(4, 'R2C3', 4);

INSERT INTO bookings (booking_id, user_id, showtime_id, seat_numbers, amount, payment_date, payment_method, status) VALUES
(1, 2, 1, 'L1C1', 5.0, NOW() - INTERVAL 10 DAY, 'Credit Card', 'Booked'),
(2, 2, 2, 'R1C1', 5.0, NOW() - INTERVAL 9 DAY, 'Credit Card', 'Booked'),
(3, 3, 5, 'L2C1,L2C2', 10.0, NOW() - INTERVAL 8 DAY, 'Debit Card', 'Booked'),
(4, 4, 35, 'R2C1,R2C2', 10.0, NOW() - INTERVAL 7 DAY, 'PayPal', 'Booked'),
(5, 2, 30, 'L1C1', 5.0, NOW() - INTERVAL 6 DAY, 'Credit Card', 'Booked'),
(6, 2, 15, 'R1C1', 5.0, NOW() - INTERVAL 5 DAY, 'Credit Card', 'Cancelled'),
(7, 3, 10, 'L2C1,L2C2', 10.0, NOW() - INTERVAL 4 DAY, 'Debit Card', 'Booked'),
(8, 4, 40, 'R2C1,R2C2', 10.0, NOW() - INTERVAL 3 DAY, 'PayPal', 'Booked'),
(9, 2, 20, 'L1C1', 5.0, NOW() - INTERVAL 2 DAY, 'Credit Card', 'Cancelled'),
(10, 2, 25, 'R1C1', 5.0, NOW() - INTERVAL 1 DAY, 'Credit Card', 'Booked');

INSERT INTO feedback (feedback_id, rating, comment) VALUES
(1, 5, 'Amazing experience!'),
(2, 4, 'Great service, but the seats could be more comfortable.'),
(3, 3, 'Average experience, nothing special.'),
(4, 2, 'Not satisfied with the cleanliness.'),
(5, 1, 'Very poor service and rude staff.'),
(6, 5, 'Loved the movie and the atmosphere!'),
(7, 5, 'Good experience overall'),
(8, 3, 'It was okay, nothing extraordinary.'),
(9, 2, 'The sound system was too loud.'),
(10, 5, 'It was great');

-- DISPLAY TABLE
SELECT * FROM users;
SELECT * FROM movies;
SELECT * FROM theatres;
SELECT * FROM showtimes;
SELECT * FROM temp_seats;
SELECT * FROM bookings;
SELECT * FROM feedback;

-- DELETE TABLE
DROP EVENT remove_temp_bookings;
DROP TABLE feedback;
DROP TABLE bookings;
DROP TABLE temp_seats;
DROP TABLE showtimes;
DROP TABLE movies;
DROP TABLE theatres;
DROP TABLE users;

-- DELETE TABLE DATA
TRUNCATE TABLE users;
TRUNCATE TABLE movies;
TRUNCATE TABLE theatres;
TRUNCATE TABLE showtimes;
TRUNCATE TABLE temp_seats;
TRUNCATE TABLE bookings;
TRUNCATE TABLE feedback;