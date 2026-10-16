-- Creation of traffic database 

CREATE TABLE vehicle (
	vehicle_id VARCHAR(7) PRIMARY KEY,
	brand VARCHAR(40),
	model VARCHAR(40),
	color VARCHAR(40)
);
	
CREATE TABLE person (
	person_id INT PRIMARY KEY AUTO_INCREMENT,
	cif VARCHAR(9),
	name VARCHAR(40),
	email VARCHAR(40),
	adrress VARCHAR(40),
	city VARCHAR(40)
);

CREATE TABLE fine (
	fine_id INT PRIMARY KEY AUTO_INCREMENT,	
	description VARCHAR(30),
	fine_date DATE,
	amount DECIMAL(8, 2),
	vehicles_id VARCHAR(7),
	driver_id INT,
	FOREIGN KEY (vehicles_id) REFERENCES vehicle(vehicle_id),
	FOREIGN KEY (driver_id) REFERENCES person(person_id)
);	

CREATE TABLE transfer (
	vehicle_id VARCHAR(7),
	owner_id INT,
	tr_date DATE,
	PRIMARY KEY (vehicle_id, owner_id, tr_date),
	FOREIGN KEY (vehicle_id) REFERENCES vehicle(vehicle_id),
	FOREIGN KEY (owner_id) REFERENCES person(person_id)
);

-- Insert some records

INSERT INTO vehicle (vehicle_id, brand, model, color) 
VALUES
('1234BCD', 'Opel', 'Corsa', 'Red'),
('4321FFG', 'Citroen', 'C3', 'Blue'),
('0101RRT', 'Opel', 'Corsa', 'White'),
('2323HHT', 'Mercedes', 'Class A', 'Silver');

INSERT INTO person (cif, name, email, adrress, city) 
VALUES
('29292929M', 'Smith, John', 'jsmith@gmail.example', NULL, 'Madrid'),
('28010101R', 'Sakata, Koji', 'sakata@yahoo.example', NULL, 'Getafe'),
('28282828T', 'Garcia, Ana', NULL, 'Gran Via 3', 'Madrid'); 

INSERT INTO transfer (vehicle_id, owner_id, tr_date)
VALUES
('1234BCD', 2, '2000-12-23'),
('1234BCD', 3, '2010-05-01'),
('1234BCD', 1, '2023-02-15'),
('4321FFG', 1, '2022-08-03'),
('0101RRT', 1, '2021-09-11'),
('0101RRT', 2, '2021-12-15'),
('2323HHT', 3, '2019-01-01'),
('2323HHT', 2, '2021-08-30'),
('2323HHT', 3, '2023-09-27');

INSERT INTO fine (description, fine_date, amount, vehicles_id, driver_id) 
VALUES
('Speed Excess', '2020-12-30', 250.00, '2323HHT', 3),
('Parking', '2020-12-31', 99.95, '2323HHT', 3),
('Speed Excess', '2021-08-01', 150.00, '0101RRT', 1);
