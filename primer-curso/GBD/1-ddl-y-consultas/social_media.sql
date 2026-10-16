-- Creation of Social Media database 

CREATE TABLE users (
	user_id  VARCHAR(40) PRIMARY KEY,
	password VARCHAR(40),
	birth_date DATE
);

CREATE TABLE post (
	post_id	INT PRIMARY KEY AUTO_INCREMENT,
	message VARCHAR(40),
	post_date DATE,
	user_id VARCHAR(40),
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE follow (
	user_id VARCHAR(40),
	followed_id VARCHAR(40),
	ini_date DATE,
	PRIMARY KEY (user_id, followed_id),
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	FOREIGN KEY (followed_id) REFERENCES users(user_id)
);

CREATE TABLE reaction (
	user_id VARCHAR(40),
	post_id INT,
	emotion INT,
	PRIMARY KEY (user_id, post_id),
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	FOREIGN KEY (post_id) REFERENCES post(post_id)
);

--Insert some example rows 
INSERT INTO users (user_id, password, birth_date)
VALUES
('juan@gmail.example', 'abcd', '1980-01-01'),
('ana@yahoo.example', 'qwerty', '2000-12-27'),
('pepe@hotmail.example', 'asdf', '1999-02-28');

INSERT INTO  post (message, post_date, user_id)
VALUES
('Love is in the air', '2010-10-01', 'ana@yahoo.example'),
('Cant get enought', '2015-07-01', 'pepe@hotmail.example');

INSERT INTO reaction (user_id, post_id, emotion)
VALUES
('juan@gmail.example', 1, 1),
('pepe@hotmail.example', 1, 2),
('ana@yahoo.example', 2, 5);

INSERT INTO follow (user_id, followed_id, ini_date)
VALUES
('juan@gmail.example', 'pepe@hotmail.example', '2022-01-01'),
('pepe@hotmail.example', 'juan@gmail.example', '2022-01-01'),
('ana@yahoo.example', 'juan@gmail.example', '2021-10-01');
