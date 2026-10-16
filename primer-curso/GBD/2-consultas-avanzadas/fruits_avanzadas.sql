-- La clausula HAVING sirve para poner condiciones en 
-- los grupos sobre funciones de agregados

-- 1. Identificadores de trabajadores que hayan recogido
-- más de 1000 kilos, sumando sus cosechas

SELECT worker_id, SUM(kilos)
FROM harvest
GROUP BY worker_id
HAVING SUM(kilos)>1000;

-- 2. Identificadores de parcelas donde se hayan recogido
-- entre 2000 y 4000 kilos, sumando sus cosechas

SELECT parcel_id, SUM(kilos)
FROM harvest 
GROUP BY parcel_id
HAVING SUM(kilos) BETWEEN 2000 AND 4000;

-- Añadir a lo anterior todos los datos de las parcelas

SELECT p.*, SUM(h.kilos)
FROM harvest h, parcel p 
WHERE h.parcel_id=p.parcel_id
GROUP BY p.parcel_id, p.surface, p.num_trees, p.fruit_id
HAVING SUM(h.kilos) BETWEEN 2000 AND 4000;

-- Identificadores de trabajadores que hayan trabajado 
-- más de 4 días

SELECT worker_id, COUNT(DISTINCT harvest_date)
FROM harvest
GROUP BY worker_id
HAVING COUNT(DISTINCT harvest_date)>4;

-- Añadir a lo anterior todos los datos del trabajador

SELECT w.*, COUNT(DISTINCT h.harvest_date)
FROM harvest h, worker w
WHERE h.worker_id=w.worker_id
GROUP BY w.worker_id, w.name, w.born_date
HAVING COUNT(DISTINCT h.harvest_date)>4;

-- 6. Identificadores de frutas de las que haya más de 
-- dos parcelas

SELECT fruit_id, COUNT(*)
FROM parcel
GROUP BY fruit_id
HAVING COUNT(*)>2;

-- 7. Añadir a lo anterior todos los datos de las frutas

SELECT f.*, COUNT(*)
FROM fruit f, parcel p
WHERE f.fruit_id=p.fruit_id
GROUP BY f.fruit_id, f.specie, f.variety
HAVING COUNT(*)>2;

-- 8. Especies de las que haya más de 6000 árboles

SELECT f.specie, SUM(num_trees)
FROM fruit f, parcel p 
WHERE f.fruit_id=p.fruit_id
GROUP BY f.specie
HAVING SUM(num_trees)>6000;

-- Subconsultas
-- -- Siempre esntre paréntesis
-- -- Devuelven un conjunto de filas y columnas
-- -- Se ejecutan antes que la consulta
-- -- Pueden estar en SELECT, FROM, WHERE y HAVING
-- -- Siempre es posible, usar subconsultas en vez de equijoin

-- 9. Todos los datos de las cosechas de Yamamoto

-- Usando equijoin

SELECT h.*
FROM worker w, harvest h 
WHERE w.worker_id=h.worker_id
AND w.name LIKE "Yamamoto%";

-- Usando una subconsulta

SELECT *
FROM harvest
WHERE worker_id=(
    SELECT worker_id
    FROM worker
    WHERE name LIKE 'Yamamoto%'
);

-- 10. Todos los datos de parcelas de peras 

SELECT *
FROM parcel
WHERE fruit_id IN (
    SELECT fruit_id
    FROM fruit
    WHERE specie='Pear'
);

-- 11. Todos los datos de trabajadores que cosecharon 
-- en el 2022

SELECT *
FROM worker
WHERE worker_id IN (
    SELECT worker_id
    FROM harvest
    WHERE harvest_date LIKE '2022%'
);

SELECT *
FROM worker
WHERE worker_id IN (
    SELECT worker_id
    FROM harvest
    WHERE YEAR(harvest_date)=2022
);

-- 12. Suma de kilos recogidos por Yamamoto

SELECT SUM(kilos)
FROM harvest
WHERE worker_id=(
    SELECT worker_id
    FROM worker
    WHERE name LIKE 'Yamamoto%'
);

-- 13. Todos los datos de parcelas donde se cosechó
-- en diciembre de 2021

SELECT *
FROM parcel
WHERE parcel_id IN (
    SELECT parcel_id
    FROM harvest
    WHERE harvest_date LIKE '2021-12%'
);

-- 14. Suma de árboles de manzana

SELECT SUM(num_trees)
FROM parcel
WHERE fruit_id IN (
    SELECT fruit_id
    FROM fruit
    WHERE specie='Apple'
);

-- 15. Suma de kilos recogidos de manzana

SELECT SUM(kilos)
FROM harvest
WHERE parcel_id IN (
    SELECT parcel_id
    FROM parcel
    WHERE fruit_id IN (
        SELECT fruit_id
        FROM fruit
        WHERE specie='Apple'
    )
);

-- 16. Suma de kilos de pera ercolina

SELECT SUM(kilos)
FROM harvest
WHERE parcel_id IN (
    SELECT parcel_id
    FROM parcel
    WHERE fruit_id IN (
        SELECT fruit_id
        FROM fruit
        WHERE specie='Pear' AND variety='Ercoline'
    )
);

-- 17. En cuántas parcelas distintas trabajó Kamarazova

SELECT COUNT(DISTINCT parcel_id)
FROM harvest
WHERE worker_id=(
    SELECT worker_id
    FROM worker
    WHERE name LIKE 'Kamarazova%'
);

-- 18. Cuántas frutas distintas recogió Kamarazova

SELECT COUNT(DISTINCT fruit_id)
FROM parcel
WHERE parcel_id IN (
    SELECT parcel_id
    FROM harvest
    WHERE worker_id=(
        SELECT worker_id
        FROM worker
        WHERE name LIKE 'Kamarazova%'
    )
);

-- 19. La fila de la tabla harvest con el máximo de kilos

SELECT *
FROM harvest
WHERE kilos=(
    SELECT MAX(kilos)
    FROM harvest
);

-- 20. Todos los datos del trabajador con más edad

SELECT *, TIMESTAMPDIFF(YEAR,born_date,CURRENT_DATE)
FROM worker
WHERE born_date=(
    SELECT MIN(born_date)
    FROM worker
);

-- 21. Todos los datos de la parcela más grande y de la 
-- más pequeña

SELECT *
FROM parcel
WHERE surface=(
    SELECT MAX(surface) 
    FROM parcel
) 
OR surface=(
    SELECT MIN(surface)
    FROM parcel
);


-- 22. Parcela con más árboles que la media

SELECT parcel_id
FROM parcel
WHERE num_trees>(
    SELECT AVG(num_trees)
    FROM parcel
);

-- 23. Parcela con menor densidad de árboles que la media

SELECT *, num_trees/surface AS density 
FROM parcel
WHERE num_trees/surface < (
    SELECT AVG(num_trees/surface)
    FROM parcel
);

-- 24. El mejor recolector: agrupar las cosechas por el 
-- id del trabajador, sumar kilos y seleccionar el máximo

SELECT worker_id, SUM(kilos)
FROM harvest
GROUP BY worker_id
HAVING SUM(kilos) >= ALL (
    SELECT SUM(kilos)
    FROM harvest
    GROUP BY worker_id
);

-- 25. Añadir a lo anterior todos los datos del trabajador

SELECT w.*, SUM(kilos)
FROM harvest h, worker w 
WHERE h.worker_id=w.worker_id
GROUP BY w.worker_id, w.name, w.born_date
HAVING SUM(kilos) >= ALL (
    SELECT SUM(kilos)
    FROM harvest
    GROUP BY worker_id
);

-- 26. El identificador de fruta con más suma de árboles

SELECT fruit_id, SUM(num_trees)
FROM  parcel 
GROUP BY fruit_id 
HAVING SUM(num_trees) >= ALL (
    SELECT SUM(num_trees)
    FROM parcel
    GROUP BY fruit_id
);


-- 27. Añadir a lo anterior todos los datos de la fruta

SELECT f.*, SUM(p.num_trees)
FROM  parcel p, fruit f 
WHERE f.fruit_id=p.fruit_id
GROUP BY f.fruit_id, f.specie, f.variety
HAVING SUM(p.num_trees) >= ALL (
    SELECT SUM(num_trees)
    FROM parcel
    GROUP BY fruit_id
);

-- 28. El identificador de parcela con menos suma de kilos

SELECT parcel_id, SUM(kilos)
FROM harvest
GROUP BY parcel_id
HAVING SUM(kilos) <= ALL (
    SELECT SUM(kilos)
    FROM harvest
    GROUP BY parcel_id
);

-- 29. Añadir a lo anterior todos los datos de la parcela

SELECT p.*, SUM(h.kilos)
FROM harvest h, parcel p
WHERE h.parcel_id=p.parcel_id
GROUP BY p.parcel_id, p.surface, p.num_trees, p.fruit_id
HAVING SUM(h.kilos) <= ALL(
    SELECT SUM(kilos)
    FROM harvest
    GROUP BY parcel_id
);

-- 30. Productividad (kilos por árbol) de cada parcela

SELECT p.parcel_id, SUM(h.kilos)/p.num_trees AS pro
FROM parcel p, harvest h 
WHERE p.parcel_id=h.parcel_id
GROUP BY p.parcel_id, p.num_trees;

-- 31. De la consulta anterior, obtener el máximo de 
-- productividad

SELECT p.parcel_id, SUM(h.kilos)/p.num_trees AS pro
FROM parcel p, harvest h 
WHERE p.parcel_id=h.parcel_id
GROUP BY p.parcel_id, p.num_trees
HAVING SUM(h.kilos)/p.num_trees >= ALL (
    SELECT SUM(h.kilos)/p.num_trees AS pro
    FROM parcel p, harvest h 
    WHERE p.parcel_id=h.parcel_id
    GROUP BY p.parcel_id, p.num_trees
);

-- 32. Todos los datos de frutas sin parcelas

SELECT *
FROM fruit
WHERE fruit_id NOT IN (
    SELECT fruit_id
    FROM parcel
);

-- 33. Todos los datos de trabajadores que nunca han 
-- recogido fruta

SELECT *
FROM worker
WHERE worker_id NOT IN (
    SELECT worker_id
    FROM harvest
);

-- 34. Todos los datos de trabajadores que nunca han 
-- recogido fruta en el año 2021

SELECT *
FROM worker
WHERE worker_id NOT IN (
    SELECT worker_id
    FROM harvest
    WHERE harvest_date IN (
        SELECT harvest_date
        FROM harvest
        WHERE YEAR(harvest_date)=2021
    )
);

-- 35. Todos los datos de trabajadores que nunca han 
-- recogido la fruta con identificador 4

SELECT *
FROM worker
WHERE worker_id NOT IN (
    SELECT worker_id
    FROM harvest
    WHERE parcel_id IN (
        SELECT parcel_id
        FROM parcel
        WHERE fruit_id=4
    )
);

-- 36. Todos los datos de trabajadores que nunca han 
-- recogido pera ercolina

SELECT *
FROM worker
WHERE worker_id NOT IN (
    SELECT worker_id
    FROM harvest
    WHERE parcel_id IN (
        SELECT parcel_id
        FROM parcel
        WHERE fruit_id=(
            SELECT fruit_id
            FROM fruit
            WHERE specie='Pear'
            AND variety='Ercoline'
        )
    )
);


-- 37. Todos los datos de parcelas en las que se recogió
-- fruta en fin de semana

SELECT *
FROM parcel
WHERE parcel_id IN (
    SELECT parcel_id
    FROM harvest
    WHERE DAYOFWEEK(harvest_date) IN (7,1)
);

-- 38. Todos los datos de trabajadores que nunca han 
-- recogido la fruta con identificador 4 pero que sí
-- han recogido otras frutas

SELECT *
FROM worker
WHERE worker_id NOT IN (
    SELECT worker_id
    FROM harvest
    WHERE parcel_id IN (
        SELECT parcel_id
        FROM parcel
        WHERE fruit_id=4
    )
)
AND worker_id IN (
    SELECT worker_id
    FROM harvest
);

-- 39. Left join de frutas y parcelas, agrupar por fruta,
-- cuenta de parcelas, suma de árboles y suma de superficie

SELECT f.*, COUNT(p.parcel_id) AS sum_parcel, 
SUM(p.num_trees) AS sum_tree, 
SUM(p.surface) AS sum_surface
FROM fruit f LEFT JOIN parcel p 
ON p.fruit_id=f.fruit_id
GROUP BY f.fruit_id, f.specie, f.variety;

-- 40. Añadir a lo anterior los porcentajes de árboles y de
-- superficie respecto al total

SELECT f.*, COUNT(p.parcel_id) AS sum_parcel, 
IFNULL(SUM(p.num_trees),0) AS sum_trees,
IFNULL(SUM(p.num_trees),0)/(
    SELECT SUM(num_trees)
    FROM parcel
)*100 AS per_trees,
IFNULL(SUM(p.surface),0) AS sum_surface,
IFNULL(SUM(p.surface),0)/(
    SELECT SUM(surface)
    FROM parcel
)*100 AS sum_surface,
SUM(p.num_trees) AS sum_tree, 
SUM(p.surface) AS sum_surface
FROM fruit f LEFT JOIN parcel p 
ON p.fruit_id=f.fruit_id
GROUP BY f.fruit_id, f.specie, f.variety;

-- 41. Left join de trabajadores y cosechas, agrupar por
-- trabajador, cuenta de días trabajados y suma de kilos recogidos

SELECT w.*, COUNT(DISTINCT h.harvest_date) AS count_days,
IFNULL(SUM(h.kilos),0) AS sum_kilos
FROM worker w LEFT JOIN harvest h 
ON w.worker_id=h.worker_id
GROUP BY worker_id, w.born_date, w.name;

-- 42. Para cada trabajador, todos sus datos y su cosecha
-- (parcela-día) más pesada

SELECT *
FROM worker w, harvest h1
WHERE w.worker_id=h1.worker_id
AND h1.kilos = (
    SELECT MAX(kilos)
    FROM harvest h2
    WHERE h1.worker_id=h2.worker_id
);

SELECT *
FROM worker w, harvest h1
WHERE w.worker_id=h1.worker_id
AND h1.kilos >= ALL (
    SELECT kilos
    FROM harvest h2
    WHERE h1.worker_id=h2.worker_id
);

-- 43. Para cada parcela, su cosecha (parcela-día) más
-- pesada

SELECT *
FROM parcel p, harvest h1
WHERE p.parcel_id=h1.parcel_id
AND h1.kilos = (
    SELECT MAX(kilos)
    FROM harvest h2
    WHERE h1.parcel_id=h2.parcel_id
);

-- 44. Para cada año-mes, el trabajador que más días 
-- cosechó

-- Creamos una vista con los datos que necesitamos

DROP VIEW IF EXISTS v_44;
CREATE VIEW v_44 AS
SELECT worker_id,
YEAR(harvest_date) AS harvest_year,
MONTH(harvest_date) AS harvest_month,
COUNT(DISTINCT(harvest_date)) AS count_days
FROM harvest
GROUP BY worker_id, YEAR(harvest_date), MONTH(harvest_date);

-- Subconsulta correlacionada con la vista anterior

SELECT *
FROM v_44 s1
WHERE count_days = (
    SELECT MAX(count_days)
    FROM v_44 s2
    WHERE s1.harvest_year=s2.harvest_year
    AND s1.harvest_month=s2.harvest_month
);

-- 45. Para cada fruta (que salgan todas), especie, variedad,
-- número de trabajadores que han cosechado, suma de kilos 
-- recogidos y porcentaje respecto al total de kilos

SELECT f.*,
COUNT(DISTINCT h.worker_id) AS count_worker,
IFNULL(SUM(h.kilos),0) AS sum_kilos,
IFNULL(SUM(h.kilos),0)/(
    SELECT SUM(kilos)
    FROM harvest
)*100 AS per_kilos
FROM fruit f 
LEFT JOIN parcel p ON f.fruit_id=p.fruit_id
LEFT JOIN harvest h ON p.parcel_id=h.parcel_id
GROUP BY f.fruit_id, f.specie, f.variety;

-- 46. ¿Cuántos kilos por debajo del record se quedó Kamarazova
-- el día 2 de diciembre de 2022 en la parcela 3?

SELECT (
    SELECT MAX(kilos)
    FROM harvest
) - (
    SELECT kilos
    FROM harvest
    WHERE harvest_date='2022-12-02'
    AND parcel_id=3
    AND worker_id = (
        SELECT worker_id
        FROM worker
        WHERE name LIKE '%Kamarazova%'
    )
) AS resul;

-- 47. Para cada cosecha, todos sus datos junto con la resta 
-- de los kilos menos el promedio de kilos

SELECT *, kilos - (
    SELECT AVG(kilos)
    FROM harvest
) AS diff
FROM harvest;

-- 48. Especies y variedades que ha recogido Kamarazova

SELECT *
FROM fruit
WHERE fruit_id IN (
    SELECT fruit_id
    FROM parcel
    WHERE parcel_id IN (
        SELECT parcel_id
        FROM harvest
        WHERE worker_id = (
            SELECT worker_id
            FROM worker
            WHERE name LIKE '%Kamarazova%'
        )
    )
);

-- 49. Para cada trabajador (que salgan todos), su nombre y
-- suma de kilos por especie y variedad

SELECT w.name, f.specie, f.variety, SUM(h.kilos)
FROM worker w 
LEFT JOIN harvest h ON w.worker_id=h.worker_id
LEFT JOIN parcel p ON h.parcel_id=p.parcel_id
LEFT JOIN fruit f ON p.fruit_id=f.fruit_id
GROUP BY w.name, f.specie, f.variety;

-- 50. Para cada trabajador, todos sus datos, suma de kilos,
-- y una columna category con el siguiente valor:
-- -- 0 kg: Nothing
-- -- Menos de 600 kg: Beginner
-- -- Menos de 1200 kg: Intermediate
-- -- Menos de 1800 kg: Advanced
-- -- Menos de 2400 kg: Master
-- -- Resto: Super Master

SELECT w.*, IFNULL(SUM(kilos),0), 
IF(SUM(kilos) IS NULL,'Nothing',
    IF(SUM(kilos)<600,'Beginner',
        IF(SUM(kilos)<1200,'Intermediate',
            IF(SUM(kilos)<1800,'Advance',
                IF(SUM(kilos)<2400,'Master','Super Master')
            )
        )
    )
) AS category
FROM worker w LEFT JOIN harvest h 
ON w.worker_id=h.worker_id
GROUP BY w.worker_id, w.born_date, w.name;

-- 51. Para cada categoría de la consulta anterior, contar
-- el número de trabajadores 

SELECT category, COUNT(*)
FROM (
    SELECT w.*, IFNULL(SUM(kilos),0), 
    IF(SUM(kilos) IS NULL,' 1. Nothing',
        IF(SUM(kilos)<600,'2. Beginner',
            IF(SUM(kilos)<1200,'3. Intermediate',
                IF(SUM(kilos)<1800,'4. Advance',
                    IF(SUM(kilos)<2400,'5. Master','6. Super Master')
                )
            )
        )
    ) AS category
    FROM worker w LEFT JOIN harvest h 
    ON w.worker_id=h.worker_id
    GROUP BY w.worker_id, w.born_date, w.name
) s1
GROUP BY category;

-- 52. Todos los datos de trabajadores que nunca han
-- recogido manzana roja

SELECT *
FROM worker 
WHERE worker_id NOT IN (
    SELECT worker_id
    FROM harvest
    WHERE parcel_id IN (
        SELECT parcel_id
        FROM parcel
        WHERE fruit_id IN (
            SELECT fruit_id
            FROM fruit
            WHERE specie='Apple' AND variety='Red'
        )
    )
);

-- 53. Calcular la nómina mensual de los trabajadores
-- teniendo en cuenta lo siguiente: 50€ por día
-- trabajado más 5€ por cada 100 kg de fruta recogida
-- más 50€ si han recogido más de 1000 kg

SELECT worker_id, MONTH(harvest_date), YEAR(harvest_date),
50 * COUNT(DISTINCT harvest_date) + 
5 * SUM(kilos) / 100 + 
IF(SUM(kilos) > 1000,50,0) AS salary
FROM harvest
GROUP BY worker_id, MONTH(harvest_date), YEAR(harvest_date);
