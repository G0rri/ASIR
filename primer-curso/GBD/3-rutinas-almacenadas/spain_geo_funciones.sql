-- 1. Función que recibe como parámetro el identificador de una
-- región y devuelve la suma de población

DELIMITER //
DROP FUNCTION IF EXISTS fun_pop//
CREATE FUNCTION fun_pop(par_region_id INT)
RETURNS INT
BEGIN
RETURN (
    SELECT SUM(population)
    FROM province
    WHERE region_id=par_region_id
);
END//
DELIMITER ;

SELECT fun_pop(region_id)
FROM province;

-- 2. Función que recibe como parámetro el identificador de una
-- región y devuelve la suma de superficie

DELIMITER //
DROP FUNCTION IF EXISTS fun_sur//
CREATE FUNCTION fun_sur(par_region_id INT)
RETURNS INT
BEGIN
RETURN (
    SELECT SUM(surface)
    FROM province
    WHERE region_id=par_region_id
);
END//
DELIMITER ;

SELECT fun_sur(region_id)
FROM province;

-- 3. Función que recibe como parámetro el identificador de una
-- región y devuelve el número de provincias

DELIMITER //
DROP FUNCTION IF EXISTS fun_pro//
CREATE FUNCTION fun_pro(par_region_id INT)
RETURNS INT
BEGIN
RETURN (
    SELECT COUNT(*)
    FROM province
    WHERE region_id=par_region_id
);
END//
DELIMITER ;

SELECT fun_pro(region_id)
FROM province;

-- 4. Todos los datos las regiones, su población, superficie, densidad
-- de población y número de provincias

SELECT *, fun_pop(region_id) AS sum_population, 
fun_sur(region_id) AS sum_surface, 
fun_pro(region_id) AS count_pro,
fun_pop(region_id)/fun_sur(region_id) AS density
FROM region;

-- 5. Función que recibe un número y devuelve lo siguiente:
-- -- Mayor que 1000000: Very high 
-- -- Mayor que 500000: High
-- -- Mayor que 250000: Medium
-- -- Mayor que 150000: Low
-- -- Menor o igual que 150000: Very Low

DELIMITER //
DROP FUNCTION IF EXISTS fun_num//
CREATE FUNCTION fun_num(par_num_id INT)
RETURNS VARCHAR(10)
BEGIN
RETURN (
        IF(par_num_id>1000000, 'Very high', 
            IF(par_num_id>500000, 'High', 
                IF(par_num_id>250000, 'Medium', 
                    IF(par_num_id>150000, 'Low', 'Very Low')
                    )
                )
            )
);
END//
DELIMITER ;

-- Otra forma

DELIMITER //
DROP FUNCTION IF EXISTS fun_num//
CREATE FUNCTION fun_num(x INT)
RETURNS VARCHAR(10)
BEGIN
     IF x > 1000000 THEN
        RETURN 'Very High';
    ELSEIF x > 500000 THEN
        RETURN 'High';
    ELSEIF x > 250000 THEN
        RETURN 'Medium';
    ELSEIF x > 150000 THEN
        RETURN 'Low';
    ELSE 
        RETURN 'Very Low';
    END IF;
END//
DELIMITER ;
   
-- 6. Usar la función anterior con la población de todas las provincias

SELECT *, fun_num(population)
FROM province;

-- 7. Usar la función anterior con la población de todas las regiones

SELECT r.region_id, r.name, fun_num(SUM(population))
FROM province p, region r
WHERE p.region_id=r.region_id
GROUP BY r.region_id, r.name;

-- Más corto usando la función del ejercicio 1

SELECT *, fun_num(fun_pop(region_id))
FROM region;
 
-- 8. Función que recibe como parámetro el identificador de un
-- río y devuelve el número de provincias que atraviesa

DELIMITER //
DROP FUNCTION IF EXISTS num_pro_crossed//
CREATE FUNCTION num_pro_crossed(par_river_id INT)
RETURNS INT
BEGIN
RETURN (
        SELECT COUNT(*)
        FROM pro_riv
        WHERE river_id=par_river_id
);
END//
DELIMITER ;

SELECT num_pro_crossed(river_id)
FROM pro_riv;

-- 9. Función que recibe como parámetro el identificador de un
-- río y devuelve el nombre de la provincia en la que nace

DELIMITER //
DROP FUNCTION IF EXISTS nom_pro_borned//
CREATE FUNCTION nom_pro_borned(par_river_id INT)
RETURNS VARCHAR(20)
BEGIN
RETURN (
        SELECT name 
        FROM province
        WHERE province_id = (
            SELECT province_id
            FROM pro_riv
            WHERE river_id=par_river_id
            AND river_order=1
        )
);
END//
DELIMITER ;

SELECT nom_pro_borned(river_id)
FROM pro_riv;

-- 10. Todos los datos de los ríos, el número de provincias que 
-- atraviensan y el nombre de la provincia donde nacen

SELECT *, 
num_pro_crossed(river_id) AS cruza,
nom_pro_borned(river_id) AS nace
FROM river;

-- 11. Función que recibe como parámetro el identificador de un
-- río y devuelve el nombre de la provincia en la que desemboca

DELIMITER //
DROP FUNCTION IF EXISTS nom_pro_last//
CREATE FUNCTION nom_pro_last(par_river_id INT)
RETURNS VARCHAR(20)
BEGIN
RETURN (
        SELECT name 
        FROM province
        WHERE province_id = (
            SELECT province_id
            FROM pro_riv
            WHERE river_id=par_river_id
            AND river_order = (
                SELECT MAX(river_order)
                FROM pro_riv
                WHERE river_id=par_river_id
            )
            LIMIT 1
        )
);
END//
DELIMITER ;

SELECT nom_pro_last(1);

-- 12. Función que recibe como parámetro el identificador de una
-- provincia y devuelve el nombre de la provincia concatenado
-- con el nombre de la región entre paréntesis: Cádiz (Andalucía)

DELIMITER //
DROP FUNCTION IF EXISTS nom_pro_conc//
CREATE FUNCTION nom_pro_conc(par_pro_id INT)
RETURNS VARCHAR(60)
BEGIN
RETURN (
    SELECT CONCAT(p.name,' (',r.name,')')
    FROM province p, region r 
    WHERE p.region_id=r.region_id
    AND p.province_id=par_pro_id
);
END//
DELIMITER ;

-- 13. Provincias y regiones por las que atraviesa en Ebro

SELECT river_order, nom_pro_conc(province_id)
FROM pro_riv
WHERE river_id=2
ORDER BY 1;

-- 14. Función que recibe como parámetro el identificador de un
-- río y devuelve un texto como el siguiente:
-- "El río Ebro nace en Cantabria, atraviesa 10 provincias, tiene
-- una longitud de 930 kms y desemboca en Tarragona"

DELIMITER //
DROP FUNCTION IF EXISTS num_riv_conc//
CREATE FUNCTION num_riv_conc(par_river_id INT)
RETURNS VARCHAR(200)
BEGIN
RETURN CONCAT(
    'El río ',
    (SELECT name FROM river WHERE river_id=par_river_id), 
    ' nace en ' ,
    nom_pro_borned(par_river_id),
    ', atraviesa ',
    CAST(num_pro_crossed(par_river_id) AS CHAR), 
    ' provincias, tiene una longitud de ',
    (SELECT CAST(length AS CHAR) FROM river WHERE river_id=par_river_id),
    ' kms y desemboca en ',
    nom_pro_last(par_river_id)
    
);
END//
DELIMITER ;

SELECT num_riv_conc(2);
