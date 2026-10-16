CREATE TABLE team (
    team_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    country VARCHAR(30)
);
CREATE TABLE cyclist (
    cyclist_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    country VARCHAR(30) NOT NULL,
    birth_date DATE NOT NULL,
    team_id INT NOT NULL,
    FOREIGN KEY (team_id) REFERENCES team(team_id)
);
CREATE TABLE stage (
    stage_id INT PRIMARY KEY AUTO_INCREMENT,
    st_date DATE NOT NULL,
    st_from VARCHAR(30) NOT NULL, 
    st_to VARCHAR(30) NOT NULL,
    kms INT NOT NULL
);
CREATE TABLE cyc_sta (
    cyclist_id INT,
    stage_id INT,
    result_order INT,
    result_time TIME,
    PRIMARY KEY (cyclist_id, stage_id),
    FOREIGN KEY (cyclist_id) REFERENCES cyclist(cyclist_id),
    FOREIGN KEY (stage_id) REFERENCES stage(stage_id)
);
INSERT INTO team VALUES
(1,'Avant riders','Spain'),
(2,'Hot wheels','UK'),
(3,'Riding for peace','Spain');
INSERT INTO cyclist VALUES
(1,'García, José','Spain','1995-11-30',1),
(2,'Maroto, Juan','Spain','1998-10-10',1),
(3,'Pérez, Luis','Argentina','1999-01-23',1),
(4,'Smith, John','UK','2000-12-21',2),
(5,'Kabuto, Noburu','Japan','1998-01-12',2),
(6,'Pitty, Morgan','USA','2001-09-21',2),
(7,'Silva, Antonio','Spain','2000-09-12',3),
(8,'Andretti, Marco','Italy','1994-10-30',3),
(9,'Jhonson, Brad','USA','1992-07-13',3);
INSERT INTO stage VALUES
(1,'2023-05-01','Salamanca','Zamora',105),
(2,'2023-05-02','Zamora','León',124),
(3,'2023-05-03','León','Valladolid',110),
(4,'2023-05-04','Valladolid','Salamanca',95);
INSERT INTO cyc_sta VALUES
(1,1,9,'03:55:55'),
(2,1,3,'03:52:23'),
(3,1,2,'03:52:23'),
(4,1,1,'03:52:23'),
(5,1,4,'03:52:40'),
(6,1,5,'03:53:15'),
(7,1,6,'03:53:15'),
(8,1,7,'03:53:55'),
(9,1,8,'03:54:20'),
(1,2,2,'4:10:23'),
(2,2,1,'4:10:23'),
(3,2,3,'4:10:23'),
(4,2,4,'4:10:23'),
(5,2,5,'4:10:23'),
(6,2,6,'4:10:23'),
(7,2,7,'4:10:30'),
(8,2,8,'4:11:51'),
(9,2,NULL,NULL),
(1,3,NULL,NULL),
(2,3,6,'04:50:17'),
(3,3,5,'04:50:15'),
(4,3,4,'04:49:16'),
(5,3,1,'04:49:02'),
(6,3,3,'04:49:12'),
(7,3,2,'04:49:12'),
(8,3,7,'04:50:33'),
(2,4,2,'03:17:15'),
(3,4,1,'03:16:00'),
(4,4,4,'03:17:55'),
(5,4,3,'03:17:16'),
(6,4,NULL,NULL),
(7,4,5,'03:20:09'),
(8,4,NULL,NULL);
