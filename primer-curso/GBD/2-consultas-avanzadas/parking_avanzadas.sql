-- 1. Todos los datos de los vehículos blancos o grises que
-- entraron el día 01-10-2023

SELECT *
FROM vehicle 
WHERE color IN('Blanco','Gris')
AND vehicle_id IN (
    SELECT vehicle_id
    FROM stay
    WHERE DATE(in_date)='2023-10-01'
);

-- No sale ninguno porque el campo in_date es DATETIME
-- La función DATE() devuelve la fecha de un DATETIME

-- 2. Para cada matrícula (que salgan todas), número de entradas 
-- y número de salidas

SELECT v.vehicle_id, COUNT(in_date), COUNT(out_date)
FROM vehicle v LEFT JOIN stay s 
ON v.vehicle_id=s.vehicle_id
GROUP BY v.vehicle_id;

-- 3. Estancias y duración en minutos de vehículos Opel

SELECT *, TIMESTAMPDIFF(MINUTE,in_date,out_date) AS duration
FROM stay
WHERE vehicle_id IN (
    SELECT vehicle_id
    FROM vehicle
    WHERE mark='Opel'
);

-- 4. Todos los datos de vehículos que nunca han estacionado

SELECT *
FROM vehicle
WHERE vehicle_id NOT IN (
    SELECT vehicle_id
    FROM stay
);

-- 5. Todos los datos de vehículos que han estacionado en 2023.

SELECT *
FROM vehicle
WHERE vehicle_id IN (
    SELECT vehicle_id
    FROM stay
    WHERE YEAR(in_date)=2023
);

-- 6. Todos los datos de vehículos que están actualmente estacionados

SELECT *
FROM vehicle
WHERE vehicle_id IN (
    SELECT vehicle_id
    FROM stay
    WHERE out_date IS NULL
);

-- 7. Para cada día y cada planta, número de entradas.

SELECT DATE(s.in_date), p.place_floor, COUNT(*)
FROM place p, stay s
WHERE p.place_id=s.place_id
GROUP BY DATE(s.in_date), p.place_floor;

-- 8. Todos los datos de las estancias y los precios por día y minuto

SELECT *
FROM stay s, price p 
WHERE s.in_date BETWEEN p.from_date 
AND IFNULL(p.until_date,CURRENT_DATE);

-- 9. Todos los datos de las estancias junto con su duración en minutos

SELECT *, TIMESTAMPDIFF(MINUTE,in_date,out_date)
FROM stay;

-- 10. Teniendo en cuenta que un día tiene 1440 minutos, calcula
-- el número de días y de minutos de cada estancia
-- La función MOD y el operador % calculan el resto de la división

--Operador %
SELECT *, 
TIMESTAMPDIFF(MINUTE,in_date,out_date) % 1440 AS minute, 
TIMESTAMPDIFF(DAY,in_date,out_date)AS days
FROM stay;

-- Función MOD
SELECT *, 
MOD(TIMESTAMPDIFF(MINUTE,in_date,out_date),1440) AS minute, 
TIMESTAMPDIFF(DAY,in_date,out_date)AS days
FROM stay;


-- 11. Calcula el importe de cada estancia

SELECT *, 
TIMESTAMPDIFF(MINUTE,in_date,out_date) % 1440 AS minute, 
TIMESTAMPDIFF(DAY,in_date,out_date) AS days,
TIMESTAMPDIFF(MINUTE,in_date,out_date) % 1440 * price_minute AS imp_minute, 
TIMESTAMPDIFF(DAY,in_date,out_date) * price_day AS imp_days
FROM stay s, price p 
WHERE s.in_date BETWEEN p.from_date 
AND IFNULL(p.until_date,CURRENT_DATE);

-- 12. Para cada estancia, calcula la columna 'Duration' con el siguiente valor:
-- "long" en estancias de más de 100 minutos
-- "short" en estancias de menos de 100 minutos

SELECT *, 
IF(TIMESTAMPDIFF(MINUTE,in_date,IFNULL(out_date,CURRENT_TIMESTAMP))>100,'Long','Short') AS duration
FROM stay;

-- 13. Repite la consulta anterior pero con el valor "medium" para estancias
-- comprendidas entre 80 y 100 minutos

SELECT *, 
IF(TIMESTAMPDIFF(MINUTE,in_date,IFNULL(out_date,CURRENT_TIMESTAMP))>100,'Long',
IF(TIMESTAMPDIFF(MINUTE,in_date,IFNULL(out_date,CURRENT_TIMESTAMP))>=80,'Medium','Short')) AS duration
FROM stay;

-- 14. Repite la consulta anterior usando sólo el operador < (less than)

SELECT *, 
IF(TIMESTAMPDIFF(MINUTE,in_date,IFNULL(out_date,CURRENT_TIMESTAMP))<80,'Short',
IF(TIMESTAMPDIFF(MINUTE,in_date,IFNULL(out_date,CURRENT_TIMESTAMP))<100,'Medium','Long')) AS duration
FROM stay;

-- 15. Todos los datos de la tabla vehículos junto con una columna
-- que muestre si el vehículo es alemán o del resto del mundo

SELECT *, 
IF(mark IN ('Opel','Mercedes'),
'Aleman', 'Resto') AS Country
FROM vehicle;


-- 16. Recalcula el importe de las estancias teniendo en cuenta que
-- no se puede cobrar por minutos más que el precio de un día

SELECT *, v.days*p.price_day + v.minute*p.price_minute AS import
FROM v16 v, price p
WHERE v.in_date BETWEEN p.from_date AND IFNULL(p.until_date,CURRENT_DATE);

-- 16.1 Crea una vista con la consulta 10 para simplificar 

DROP VIEW IF EXISTS v16;
CREATE VIEW v16 AS
SELECT *, 
TIMESTAMPDIFF(MINUTE,in_date,out_date) % 1440 AS minute, 
TIMESTAMPDIFF(DAY,in_date,out_date)AS days
FROM stay;

-- 17. Vehículos para los que no hay ninguna estancia

SELECT *
FROM vehicle
WHERE vehicle_id NOT IN (
    SELECT vehicle_id
    FROM stay
);

-- 18. Para cada vehículo, número de estancias
-- Que aparezcan todos los vehículos

SELECT v.*, COUNT(s.stay_id)
FROM vehicle v LEFT JOIN stay s 
ON v.vehicle_id=s.vehicle_id
GROUP BY v.vehicle_id, v.color, v.mark, v.model;

-- 19. Para cada plaza, número de estancias
-- Que aparezcan todas las plazas

SELECT p.*, COUNT(s.stay_id)
FROM place p LEFT JOIN stay s 
ON p.place_id=s.place_id
GROUP BY p.place_id, p.place_floor;

-- 20. Tiempo en minutos que estuvo ocupada cada plaza, que
-- salgan todas

SELECT p.*, 
IFNULL(SUM(TIMESTAMPDIFF(MINUTE,in_date,out_date)),0)
FROM place p LEFT JOIN stay s 
ON p.place_id=s.place_id
GROUP BY p.place_id, p.place_floor;

-- 21. Para cada estancia, su duración en minutos suponiendo que 
-- que ahora fueran las 18:00 del 4 de noviembre de 2023

SELECT *, 
(TIMESTAMPDIFF(MINUTE,in_date,IFNULL(out_date,'2023-11-04')))
FROM stay;

-- 22. Minutos de ocupación el día 3 de octubre de 2023

SELECT *, 
TIMESTAMPDIFF(
    MINUTE,
    IF(in_date<'2023-10-03','2023-10-03',in_date),
    IF(out_date>'2023-10-04','2023-10-04',out_date)
) AS minutes
FROM stay
WHERE NOT (out_date<'2023-10-03' OR in_date>'2023-10-04');

-- 23. Suma de minutos de ocupación el día 3 de octubre de 2023

SELECT 
SUM(TIMESTAMPDIFF(
    MINUTE,
    IF(in_date<'2023-10-03','2023-10-03',in_date),
    IF(out_date>'2023-10-04','2023-10-04',out_date)
)) AS sum_minutes
FROM stay
WHERE NOT (out_date<'2023-10-03' OR in_date>'2023-10-04');

-- 24. Porcentaje de ocupación el día 3 de octubre de 2023

SELECT 
SUM(TIMESTAMPDIFF(
    MINUTE,
    IF(in_date<'2023-10-03','2023-10-03',in_date),
    IF(out_date>'2023-10-04','2023-10-04',out_date)
))/ (9 * 1440)*100 AS per_minutes
FROM stay
WHERE NOT (out_date<'2023-10-03' OR in_date>'2023-10-04');

-- 25. Para cada vehículo con más de una entrada,
-- número de entradas y número de salidas

SELECT vehicle_id, COUNT(in_date), COUNT(out_date)
FROM stay
GROUP BY vehicle_id
HAVING COUNT(in_date) > 1;

-- 26. Máximo número de entradas de un mismo vehículo

SELECT vehicle_id, COUNT(in_date)
FROM stay
GROUP BY vehicle_id
HAVING COUNT(in_date) >= ALL (
    SELECT COUNT(in_date)
    FROM stay
    GROUP BY vehicle_id
);

-- 27. Repite el ejercicio 24 pero utiliza una variable 
-- para contar el número de plazas

SET @x = (
    SELECT COUNT(*)
    FROM place
);
SELECT 
SUM(TIMESTAMPDIFF(
    MINUTE,
    IF(in_date<'2023-10-03','2023-10-03',in_date),
    IF(out_date>'2023-10-04','2023-10-04',out_date)
))/ (@x * 1440)*100 AS per_minutes
FROM stay
WHERE NOT (out_date<'2023-10-03' OR in_date>'2023-10-04');

-- 28. Repite el ejercicio anterior pero usando una variable 
-- para la fecha

SET @d1 = '2023-10-03';
SET @d2 = DATE_ADD(@d1,INTERVAL 1 DAY);
SET @x = (
    SELECT COUNT(*)
    FROM place
);
SELECT 
SUM(TIMESTAMPDIFF(
    MINUTE,
    IF(in_date<@d1,@d1,in_date),
    IF(out_date>@d2,@d2,out_date)
))/ (@x * 1440)*100 AS per_minutes
FROM stay
WHERE NOT (out_date<@d1 OR in_date>@d2);

-- 29. Estado actual de las todas las plazas de aparcamiento
-- Si la plaza está ocupada, que aparezca la palabra "Occupied"
-- Si la plaza está vacía, que aparezca la palabra "Empty"

SELECT p.place_id, 
IF(COUNT(in_date)=COUNT(out_date),"Empty","Occupied") AS stat
FROM place p LEFT JOIN stay s 
ON p.place_id=s.place_id
GROUP BY p.place_id;

-- 30. Plazas en las que haya estacionado alguna vez un Opel Astra.

SELECT DISTINCT place_id
FROM stay
WHERE vehicle_id IN (
    SELECT vehicle_id
    FROM vehicle
    WHERE mark='Opel' AND model='Astra'
);

-- 31. Vehículos que nunca hayan estacionado en la primera planta.

SELECT *
FROM vehicle
WHERE vehicle_id NOT IN (
    SELECT vehicle_id
    FROM stay
    WHERE place_id IN (
        SELECT place_id
        FROM place
        WHERE place_floor=1
    )
);

-- 32. Estancias más cortas que la media. Supongamos que hoy es 10/10/2023

SELECT * 
FROM stay
WHERE TIMESTAMPDIFF(MINUTE,in_date,IFNULL(out_date,'2023-20-10'))<(
    SELECT AVG(TIMESTAMPDIFF(MINUTE,in_date,IFNULL(out_date,'2023-20-10')))
    FROM stay
);

-- 33. Vehículo con mayor número de minutos en una estancia.

SELECT *
FROM stay
WHERE TIMESTAMPDIFF(MINUTE,in_date,IFNULL(out_date,CURRENT_DATE)) = (
    SELECT MAX(TIMESTAMPDIFF(MINUTE,in_date,IFNULL(out_date,CURRENT_DATE)))
    FROM stay
);

-- 34. Día con mayor número de entradas.

SELECT DATE(in_date), COUNT(*)
FROM stay
GROUP BY DATE(in_date)
HAVING COUNT(*) >= ALL (
    SELECT COUNT(*)
    FROM stay
    GROUP BY DATE(in_date)
);

-- 35. Las estancias 9 y 24 son del mismo vehículo. 
-- Minutos que estuvo fuera, usando variables.

SET @x=(
    SELECT out_date
    FROM stay
    WHERE stay_id=9
);
SET @y=(
    SELECT in_date
    FROM stay
    WHERE stay_id=24
);
SELECT TIMESTAMPDIFF(MINUTE,@x,@y);

-- 36. Lo mismo pero con subconsultas en FROM.

SELECT TIMESTAMPDIFF(MINUTE,s1.out_date,s2.in_date)
FROM (
    SELECT out_date
    FROM stay
    WHERE stay_id=9
)AS s1, (
    SELECT in_date
    FROM stay
    WHERE stay_id=24
)AS s2;

-- 37. Incremento de precio del día desde el 01/02/2017 hasta 01/02/2018.

SET @x=(
    SELECT price_day
    FROM price
    WHERE '2017-02-01' BETWEEN from_date AND IFNULL(until_date,CURRENT_DATE)
);
SET @y=(
    SELECT price_day
    FROM price
    WHERE '2018-02-01' BETWEEN from_date AND IFNULL(until_date,CURRENT_DATE)
);
SELECT (@y-@x)/@x*100;

-- 38. Facturación diaria (suma de importes cobrados a la salida).

SELECT DATE(out_date), SUM(v.days*p.price_day + v.minute*p.price_minute) AS sum_import
FROM v16 v, price p
WHERE v.in_date BETWEEN p.from_date AND IFNULL(p.until_date,CURRENT_DATE)
GROUP BY DATE(out_date);

-- 39. El vehículo '0987-BSR' aparca en la primera plaza libre,
-- inserta la estancia.

-- Con AUTO_INCREMENT
INSERT INTO stay(stay_id, in_date, out_date, vehicle_id, place_id)
VALUES
(NULL,);

SET @x=(
    SELECT MAX(stay_id)+1
    FROM stay
);
SET @y=(
    SELECT MIN(place_id)
    FROM place
    WHERE place_id NOT IN (
        SELECT place_id
        FROM stay
        WHERE out_date IS NULL
    )
);
INSERT INTO stay(stay_id, in_date, out_date, vehicle_id, place_id)
VALUES
(@x,CURRENT_TIMESTAMP,NULL,'0987-BSR',@y);

-- 40. Los precios suben a partir de hoy un 2.5%
-- 1º Modificar el último registro de precios
-- 2º Insertar un nuevo registro de precios

SET @x=(
    SELECT MAX(price_id)+1
    FROM price
);
SET @y=(
    SELECT price_day
    FROM price
    WHERE until_date IS NULL
);
SET @z=(
    SELECT price_minute
    FROM price
    WHERE until_date IS NULL
);
UPDATE price
SET until_date=CURRENT_DATE
WHERE until_date IS NULL;
INSERT INTO price(price_id, from_date, until_date, price_day, price_minute)
VALUES
(@x,CURRENT_DATE+1,NULL,@y*1.025,@z*1.025);

-- 41. Modificar la horas de entrada, incrementándolas en 5 minutos
-- para el vehículo '0987-BSR'
-- Antes de actualizar los datos es conveniente establecer 
-- un punto de retorno al que poder volver
-- deshaciendo los cambios mediante ROLLBACK en caso de error 

SAVEPOINT s1;
UPDATE stay
SET in_date=ADDTIME(in_date,300)
WHERE vehicle_id='0987-BSR';
ROLLBACK;

-- Comprobamos el resultado, y si no es el esperado deshacemos

ROLLBACK TO s1;
