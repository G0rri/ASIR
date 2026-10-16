-- Un procedimiento almacenado es parecido a una función almacenada
-- Tiene parámetros de entrada igual que la función
-- Pero además puede tener parámetros de salida
-- No devuelve un valor como las funciones
-- Realizan operaciones INSERT, DELETE o UPDATE
-- Para ejecutar el procedimiento se usa la orden CALL

-- 1. Procedimiento que cambia los precios vigentes en nuestro parking a partir de mañana
-- Recibe como parámetros el nuevo precio por día y por minuto
-- Tiene que ejecutar un UPDATE en la fila que tenga until_date a nulo
-- Tiene que ejecutar un INSERT con el nuevo precio

DELIMITER //
DROP PROCEDURE IF EXISTS new_prices//
CREATE PROCEDURE new_prices(par_pd DECIMAL(5,3), par_pm DECIMAL(5,3))
BEGIN
    DECLARE x INT(11);
    SET x=(SELECT MAX(price_id)+1 FROM price);
    UPDATE price
    SET until_date=CURRENT_DATE
    WHERE until_date IS NULL;
    INSERT price(price_id, from_date, price_day, price_minute)
    VALUES (x, DATE_ADD(CURRENT_DATE, INTERVAL 1 DAY), par_pd, par_pm);
END//
DELIMITER ;

-- 2. Probamos el procedimiento con los nuevos precios 12.470 y 0.015

CALL new_prices(12.470,0.015);

-- 3. Procedimiento que se ejecutará a la entrada de un coche del parking
-- Recibe como parámetros el identificador del vehículo y el identificador de la plaza
-- Se supone que los datos del vehículo ya están en la BD y la plaza está libre

DELIMITER //
DROP PROCEDURE IF EXISTS imput_vehicle//
CREATE PROCEDURE imput_vehicle(par_vehicle_id VARCHAR(8), par_place_id INT(11))
BEGIN
    DECLARE x INT(11);
    SET x=(SELECT MAX(stay_id)+1 FROM stay);
    INSERT stay(stay_id, in_date, vehicle_id, place_id)
    VALUES (x, CURRENT_TIMESTAMP, par_vehicle_id, par_place_id);
END//
DELIMITER ;

-- 4. Prueba el resultado con algún vehículo en una plaza libre

CALL imput_vehicle('0973-BGF',7);

-- 5. Procedimiento que se ejecutará a la salida de un coche del parking
-- Recibe como parámetro el identificador del vehículo
-- Se supone que el vehículo estaba estacionado dentro del parking

DELIMITER //
DROP PROCEDURE IF EXISTS output_vehicle//
CREATE PROCEDURE output_vehicle(par_vehicle_id VARCHAR(8))
BEGIN
    UPDATE stay
    SET out_date=CURRENT_TIMESTAMP
    WHERE vehicle_id=par_vehicle_id
    AND out_date IS NULL;
END//
DELIMITER ;

-- 6. Prueba el resultado con algún vehículo que esté estacionado

CALL output_vehicle('1234-GCS');

-- 7. Modifica el procedimiento anterior para que mediante un 
-- parámetro de salida se devuelva el importe de la estancia

DELIMITER //
DROP PROCEDURE IF EXISTS output_vehicle//
CREATE PROCEDURE output_vehicle(par_vehicle_id VARCHAR(8), OUT imp DECIMAL(7,2))
BEGIN
    DECLARE in_dt DATETIME;
    SET in_dt=(
        SELECT in_date
        FROM stay
        WHERE vehicle_id=par_vehicle_id
        AND out_date IS NULL
    );
    SET imp=importe(in_dt, CURRENT_TIMESTAMP);
    UPDATE stay
    SET out_date=CURRENT_TIMESTAMP
    WHERE vehicle_id=par_vehicle_id
    AND out_date IS NULL;
END//
DELIMITER ;

-- 8. Prueba el resultado con algún vehículo que esté estacionado
-- y recoge el parámetro de salida en una variable de entorno

CALL output_vehicle('0987-BSR',@my_import);
SELECT @my_import;

-- 9. Vamos a añadir un parámetros de salida al procedimiento imput_vehicle,
-- para obtener información sobre la ejecución exitosa o errónea
-- de la salida del vehículo. El parámetro tomará los siguientes valores:
-- -- 1 OK
-- -- 2 Error vehículo no existe
-- -- 3 Error vehículo ya aparcado
-- -- 4 Error plaza no existe
-- -- 5 Error plaza ocupada

DELIMITER //
DROP PROCEDURE IF EXISTS imput_vehicle//
CREATE PROCEDURE imput_vehicle(par_vehicle_id VARCHAR(8), par_place_id INT(11), OUT out_code INT)
BEGIN
    DECLARE x INT(11);
    IF par_vehicle_id NOT IN (SELECT vehicle_id FROM vehicle) THEN
        SET out_code=2;
    ELSEIF parked(par_vehicle_id) THEN
        SET out_code=3;
    ELSEIF par_place_id NOT IN (SELECT place_id FROM place) THEN
        SET out_code=4;
    ELSEIF occupied(par_place_id) THEN
        SET out_code=5;
    ELSE
        SET x=(SELECT MAX(stay_id)+1 FROM stay);
        INSERT stay(stay_id, in_date, vehicle_id, place_id)
        VALUES (x, CURRENT_TIMESTAMP, par_vehicle_id, par_place_id);
        SET out_code=1;
    END IF;
END//
DELIMITER ;

-- 10. Probar cada caso


CALL imput_vehicle('0000-ABC',8,@x);
SELECT @x; --> 2

-- Coche no existe
CALL imput_vehicle('0973-BGF',8,@x);
SELECT @x; --> 3

-- Coche existe pero la plaza no
CALL imput_vehicle('0987-BSR',18,@x);
SELECT @x; --> 4

-- La plaza está ocupada
CALL imput_vehicle('0987-BSR',2,@x);
SELECT @x; --> 5

-- Funciona bien
CALL imput_vehicle('0987-BSR',1,@x);
SELECT @x; --> 1

-- 11. Añadir un parámetros de salida al procedimiento output_vehicle,
-- para obtener información sobre la ejecución exitosa o errónea
-- de la salida del vehículo. El parámetro tomará los siguientes valores:
-- -- 1 OK
-- -- 2 Error vehículo no existe
-- -- 3 Error vehículo no aparcado

DELIMITER //
DROP PROCEDURE IF EXISTS output_vehicle//
CREATE PROCEDURE output_vehicle(par_vehicle_id VARCHAR(8),OUT imp DECIMAL(7,2),OUT out_code INT)
BEGIN
	DECLARE in_dt DATETIME;
	IF par_vehicle_id NOT IN (SELECT vehicle_id FROM vehicle) THEN 
		SET out_code=2;
	ELSEIF NOT parked(par_vehicle_id) THEN
		SET out_code=3;
	ELSE
		SET in_dt=(
			SELECT in_date
			FROM stay
			WHERE vehicle_id=par_vehicle_id
			AND out_date IS NULL
		);
		SET imp=importe(in_dt,CURRENT_TIMESTAMP);
		UPDATE stay
		SET out_date=CURRENT_TIMESTAMP
		WHERE vehicle_id=par_vehicle_id
		AND out_date IS NULL;
		SET out_code=1;
	END IF;
END//
DELIMITER ;

-- 12. Probamos cada caso

CALL output_vehicle('8888-RRR',@x,@y);
SELECT @x AS importe;
SELECT @y AS codigo_estado; --> 2

CALL output_vehicle('1135-BBV',@x,@y);
SELECT @x AS importe;
SELECT @y AS codigo_estado; --> 3

CALL output_vehicle('0987-BSR',@x,@y);
SELECT @x AS importe;
SELECT @y AS codigo_estado; 
