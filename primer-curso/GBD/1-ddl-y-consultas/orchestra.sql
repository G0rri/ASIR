-- My second script of SQL
-- Creation of Orchestra database

CREATE TABLE musician (
	musician_id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(40),
	cif VARCHAR(9),
	born_date DATE
);

CREATE TABLE composer (
	composer_id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(40),
	born_year DATE,
	death_year DATE
);

CREATE TABLE piece (
	piece_id INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(40),
	composer_id INT,
	FOREIGN KEY (composer_id) REFERENCES composer(composer_id)
);

CREATE TABLE concert (
	concert_id INT PRIMARY KEY AUTO_INCREMENT,
	con_date DATE,
	venue VARCHAR(40),
	con_people INT,
	piece_id INT
);

CREATE TABLE pie_con (
	piece_id INT,
	concert_id INT,
	PRIMARY KEY (piece_id, concert_id),
	FOREIGN KEY (concert_id) REFERENCES concert(concert_id),
	FOREIGN KEY (piece_id) REFERENCES piece(piece_id)
);
	
	CREATE TABLE mus_con (
		musician_id INT,
		concert_id INT,
		instrument VARCHAR(40),
		PRIMARY KEY (musician_id, concert_id),
		FOREIGN KEY (musician_id) REFERENCES musician(musician_id),
		FOREIGN KEY (concert_id) REFERENCES concert(concert_id)
);
