-- My third script of SQL
-- Creation of cinema database 

CREATE TABLE studio (
	studio_id INT PRIMARY KEY AUTO_INCREMENT,
	f_year INT,
	profit DECIMAL(40),
	name VARCHAR(40),
	country VARCHAR(40)
);

CREATE TABLE movie (
	movie_id INT PRIMARY KEY AUTO_INCREMENT,
	gender VARCHAR(40),
	title VARCHAR(40),
	rel_year INT,
	studio_id INT,
	FOREIGN KEY (studio_id) REFERENCES studio(studio_id)
);

CREATE TABLE artist (
	artist_id INT PRIMARY KEY AUTO_INCREMENT,
	country VARCHAR(40),
	gender VARCHAR(40),
	name VARCHAR(40),
	birth_date DATE,
	death_date DATE
);

CREATE TABLE mov_art (
	artist_id INT,
	movie_id INT ,
	rol VARCHAR(40),
	PRIMARY KEY (artist_id, movie_id, rol),
	FOREIGN KEY (artist_id) REFERENCES artist(artist_id),
	FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);

-- Insertion of some rows

INSERT INTO studio(f_year, profit, name, country)
VALUES
(1912, 450, 'Paramount Pictures', 'Los Angeles'),
(1923, 13375, 'Warner Brothers', 'Los Angeles'),
(1967, 25, 'Malpaso Productions', 'California');

INSERT INTO movie(gender, title, rel_year, studio_id)
VALUES
('Drama', 'Million Dollar Baby', 2004, 3),
('Belic', 'Top Gun', 1983, 1),
('Drama', 'Gran Torino', 2008, 3),
('Western', 'The Good, the bad and the ugly', 1966, 3),
('Belic', 'Top Gun Maverick', 2022, 1);

INSERT INTO artist(country, name, gender, birth_date, death_date)
VALUES
('USA', 'Clint Eastwood', 'Man', '1930-05-31', NULL),
('USA', 'Hillary Swank', 'Woman', '1974-07-30', NULL),
('USA', 'Morgan Freeman', 'Man', '1937-06-01', NULL),
('USA', 'Tom Cruise', 'Man', '1962-07-03', NULL),
('USA', 'Kelly McGillis', 'Woman', '1957-07-09', NULL),
('UK', 'Tony Scott', 'Man', '1944-06-21', '2012-08-21'),
('USA', 'Ahney Her', 'Woman', '1992-07-13', NULL),
('Italy', 'Sergio Leone', 'Man', '1929-01-03', '1989-04-30'),
('USA', 'Joseph Kosinki', 'Man', '1974-05-03', NULL);


INSERT INTO mov_art(artist_id, movie_id, rol)
VALUES
(1, 1, 'Actor'),
(2, 1, 'Actress'),
(1, 1, 'Director'),
(3, 1, 'Actor'),
(6, 2, 'Director'),
(4, 2, 'Actor'),
(5, 2, 'Actress'),
(1, 3, 'Director'),
(1, 3, 'Actor'),
(7, 3, 'Actress'),
(8, 4, 'Actor'),
(1, 4, 'Actor'),
(9, 4, 'Director'),
(4, 5, 'Actor');

