-- PLSQL es la extensión procedimental de SQL
-- Permite la creación de rutinas almacenadas en la base de datos
-- Las rutinas son de 3 tipos:

-- -- Función: con parámetro de entrada, devuelve un valor.
-- -- Son readonly con respecto a los datos.

-- -- Procedimiento: con parámetros de Entrada y Salida,
-- -- ejecuta operaciones INSERT, DELETE Y UPDATE.

-- -- Disparador: sin parámetros se ejecuta automáticamente 
-- -- como respuesta a un evento.

-- 1. Función que devuelve verdadero si un vehículo está estacionado 
-- actualmente en el parking y falso en caso contrario. 
-- El parámetro de entrada es la matrícula del vehículo.
-- La función devuelve un valor booleano (verdadaro/falso, true/false, 1/0)

DELIMITER //
DROP FUNCTION IF EXISTS parked//
CREATE FUNCTION parked(par_vehicle_id VARCHAR(8))
RETURNS BOOLEAN
BEGIN
    DECLARE x BOOLEAN;
    SELECT par_vehicle_id IN (
        SELECT vehicle_id
        FROM stay
        WHERE out_date IS NULL
    ) INTO x;
    RETURN x;
END//
DELIMITER ;

-- 2. Probar la función con la matrícula '9919-CFH'

SELECT parked('9919-CFH');

-- 3. Probar la función con todas las matrículas de la tabla vehicle

SELECT *, parked(vehicle_id)
FROM vehicle;

-- 4. Función que devuelve el precio por día vigente en la fecha que se pasa como parámetro
-- Ojo: la función devuelve un valor decimal de 5 dígitos (3 después de la coma)

DELIMITER //
DROP FUNCTION IF EXISTS get_price_day//
CREATE FUNCTION get_price_day(par_date DATE)
RETURNS DECIMAL(5,3)
BEGIN
    DECLARE x DECIMAL(5,3);
    SELECT price_day INTO x
    FROM price
    WHERE par_date
    BETWEEN from_date AND IFNULL(until_date,CURRENT_DATE);
    RETURN x;
END//
DELIMITER ;

-- Lo mismo pero sin usar ninguna variable

DELIMITER //
DROP FUNCTION IF EXISTS get_price_day//
CREATE FUNCTION get_price_day(par_date DATE)
RETURNS DECIMAL(5,3)
BEGIN
    RETURN (
        SELECT price_day 
        FROM price
        WHERE par_date
        BETWEEN from_date AND IFNULL(until_date,CURRENT_DATE)
    );
END//
DELIMITER ;

-- 5. Probar la función con todas las estancias

SELECT *, get_price_day(in_date)
FROM stay;

-- 6. Función que devuelve el precio por minuto vigente 
-- en la fecha que se pasa como parámetro

DELIMITER //
DROP FUNCTION IF EXISTS get_price_min//
CREATE FUNCTION get_price_min(par_min DATE)
RETURNS DECIMAL(5,3)
BEGIN
    RETURN (
        SELECT price_minute
        FROM price
        WHERE par_min
        BETWEEN from_date AND IFNULL(until_date,CURRENT_DATE)
    );
END//
DELIMITER ;

-- 7. Comprueba el correcto funcionamiento de las funciones anteriores con la siguiente consulta
-- Para cada estancia, fecha de entrada, el precio por día y por minuto

SELECT *, get_price_min(in_date), get_price_day(in_date)
FROM stay;

-- 8. Función que recibe como parámetros la fecha-hora de entrada y de salida
-- y devuelve el importe de la estancia

DELIMITER //
DROP FUNCTION IF EXISTS importe//
CREATE FUNCTION importe(par_dt1 DATETIME, par_dt2 DATETIME)
RETURNS DECIMAL(7,2)
BEGIN
    DECLARE mins, days INTEGER;
    SET mins=TIMESTAMPDIFF (MINUTE,par_dt1,par_dt2) % 1440;
    SET days=TIMESTAMPDIFF (DAY,par_dt1,par_dt2);
    RETURN (
        IF(mins * get_price_min(par_dt1) > get_price_day(par_dt2), 
        get_price_day(par_dt2),
        mins * get_price_min(par_dt1))+
        days * get_price_day(par_dt2)
    );
END//
DELIMITER ;

-- Probarlo con varios casos

-- 9. Sólo minutos

SELECT importe('2024-04-03 9:00','2024-04-03 9:30');

-- 10. Días y minutos 

SELECT importe('2024-04-02 9:00','2024-04-03 9:30');

-- 11. Minutos que se cobran como día entero

SELECT importe('2024-04-02 6:00','2024-04-03 23:30');

-- 12. Prueba la función anterior mostrando el importe y el IVA (21%) de cada estancia

SELECT *, importe(in_date, out_date) AS importe,
ROUND(importe(in_date, out_date) *0.21,2) AS iva
FROM stay;

-- 13. Agrupa la consulta anterior por la matrícula, 
-- cuenta el número de estancias y suma de importe y de iva.

SELECT vehicle_id, COUNT(*),
SUM(importe(in_date, out_date)) AS importe,
SUM(ROUND(importe(in_date, out_date) *0.21,2)) AS sum_iva
FROM stay
GROUP BY vehicle_id;

-- 14. Función que recibe como parámetro una matrícula YEAR
-- devuelve la suma de importe de las estancias de ese coche.
DELIMITER //
DROP FUNCTION IF EXISTS sum_imp_veh//
CREATE FUNCTION sum_imp_veh(par_vehicle_id VARCHAR(8))
RETURNS DECIMAL(8,2)
BEGIN
    RETURN (
        SELECT SUM(importe(in_date,out_date))
        FROM stay
        WHERE vehicle_id=par_vehicle_id
    );
END//
DELIMITER ;

-- Probamos la función con un vehículo.

SELECT sum_imp_veh('4343-BNM');

-- 15. Función que devuelve verdadero si la plaza que 
-- pasa como parámetro está ocupada, y falso en caso contrario.

DELIMITER //
DROP FUNCTION IF EXISTS occupied//
CREATE FUNCTION occupied(par_place_id INT)
RETURNS BOOLEAN
BEGIN
    RETURN par_place_id IN (
        SELECT place_id
        FROM stay
        WHERE out_date IS NULL
    );
END//
DELIMITER ;

-- 16. ¿Está ocupada la plaza 9?

SELECT occupied(9);

-- 17. Listado de plazas ocupadas

SELECT *
FROM place
WHERE occupied(place_id);

-- 18. Listado de plazas libres

SELECT *
FROM place
WHERE NOT occupied(place_id);

-- 19. Función que devuelve la suma de minutos de ocupación 
-- en la fecha que pasa como parámetro.

DELIMITER //
DROP FUNCTION IF EXISTS sum_min_day//
CREATE FUNCTION sum_min_day(d1 DATE)
RETURNS INT
BEGIN
    DECLARE d2 DATE;
    SET d2 = DATE_ADD(d1, INTERVAL 1 DAY);
    RETURN (
        SELECT SUM( 
        TIMESTAMPDIFF(
            MINUTE,
            IF(in_date < d1, d1, in_date),
            IF(out_date > d2, d2, out_date)
        ) )
        FROM stay
        WHERE NOT (out_date < d1 OR in_date > d2)
    );
END//
DELIMITER ;

-- 20. Suma de minutos de ocupación el día 3 de octubre de 2023

SELECT sum_min_day('2023-10-03');
