-- 2. Provincias de Andalucía con más de un millón de habitantes

SELECT *
FROM region r, province p
WHERE r.region_id = p.region_id
AND r.name = 'Andalucia'
AND p.population > 1000000;

SELECT *
FROM province
WHERE population>1000000
AND region_id = (
    SELECT region_id
    FROM region
    WHERE name='Andalucía'
);

-- 3. Regiones costeras

SELECT DISTINCT r.*
FROM region r, province p
WHERE r.region_id = p.region_id
AND p.coast;

SELECT *
FROM region
WHERE region_id IN (
    SELECT region_id
    FROM province
    WHERE coast
);

-- 6. Provincias castellano-manchegas con población comprendida
-- entre 600000 y 900000 habitantes usando AND

SELECT *
FROM province p, region r
WHERE p.region_id = r.region_id
AND (population >= 600000 AND population <= 900000)
AND r.name = 'Castilla La Mancha';

SELECT *
FROM province
WHERE region_id = (
    SELECT region_id
    FROM region
    WHERE name LIKE 'Castilla La Mancha'      
)
AND population>=600000 AND population<=900000;
     

-- 7. Lo mismo pero con el operador BETWEEN

SELECT *
FROM province p, region r
WHERE p.region_id = r.region_id
AND population BETWEEN 600000 AND 900000
AND r.name = 'Castilla La Mancha';

SELECT *
FROM province
WHERE region_id = (
    SELECT region_id
    FROM region
    WHERE name LIKE 'Castilla La Mancha'      
)
AND population BETWEEN 600000 AND 900000;

-- 8. Provincias castellano-manchegas con población no comprendida
-- entre 600000 y 900000

SELECT p.*
FROM province p, region r
WHERE p.region_id = r.region_id
AND NOT population BETWEEN 600000 AND 900000
AND r.name = 'Castilla La Mancha';

SELECT *
FROM province
WHERE region_id = (
    SELECT region_id
    FROM region
    WHERE name LIKE 'Castilla La Mancha'      
)
AND population NOT BETWEEN 600000 AND 900000;

-- 12. Provincias por las que atraviesa el Ebro ordenadas 
SELECT p.name, pr.river_order
FROM province p, pro_riv pr, river r
WHERE p.province_id = pr.province_id 
AND pr.river_id = r.river_id
AND r.name = 'Ebro'
ORDER BY river_order;

SELECT p.name, pr.river_order
FROM province p, pro_riv pr
WHERE p.province_id = pr.province_id 
AND pr.river_id = (
    SELECT river_id
    FROM river
    WHERE name ='Ebro'    
)
ORDER BY pr.river_order;

-- 13. Regiones por las que atraviesa el Ebro ordenadas 

SELECT re.name, pr.river_order
FROM region re, province p, pro_riv pr, river r
WHERE re.region_id = p.region_id AND p.province_id = pr.province_id 
AND pr.river_id = r.river_id
AND r.name = 'Ebro'
ORDER BY river_order;

SELECT DISTINCT re.name
FROM region re, province p, pro_riv pr, river r
WHERE re.region_id = p.region_id AND p.province_id = pr.province_id 
AND pr.river_id = r.river_id
AND r.name = 'Ebro'
ORDER BY river_order;

SELECT DISTINCT r.name
FROM region r, province p, pro_riv pr
WHERE r.region_id=p.region_id
AND p.province_id = pr.province_id 
AND pr.river_id = (
    SELECT river_id
    FROM river
    WHERE name ='Ebro'    
)
ORDER BY pr.river_order;

----------------------------------------------------------------------------
------------------ Funciones de agregados ----------------------------------
----------------------------------------------------------------------------
-- Devuelven un resultado resumido de un grupo de filas 
-- -- COUNT(*) número de filas 
-- -- COUNT(campo) número de valores no nulos en la campo 
-- -- COUNT (DISTINCT campo) lo mismo pero además distintos 
-- -- MAX(campo) máximo valor del campo 
-- -- MIN(campo) mínimo valor del campo 
-- -- SUM(campo) suma de valores del campo 
-- -- AVG(campo) promedio de valores del campo 

-- 14. Número de provincias y de comunidades por las que atraviesa el Ebro

SELECT COUNT(*), COUNT(DISTINCT re.region_id)
FROM region re, province p, pro_riv pr, river r
WHERE re.region_id = p.region_id AND p.province_id = pr.province_id 
AND pr.river_id = r.river_id
AND r.name = 'Ebro'
ORDER BY river_order;

SELECT COUNT(*) AS num_province, COUNT(DISTINCT re.region_id) AS num_regions
FROM region re, province p, pro_riv pr, river r
WHERE re.region_id = p.region_id AND p.province_id = pr.province_id 
AND pr.river_id = r.river_id
AND r.name='Ebro'
ORDER BY river_order;

SELECT COUNT(DISTINCT region_id) AS num_regions,
COUNT(*) AS num_provinces
FROM province
WHERE province_id IN (
    SELECT province_id
    FROM pro_riv
    WHERE river_id=(
        SELECT river_id
        FROM river
        WHERE name='Ebro'  
    )
);

-- 15. Número de ríos de Andalucía

SELECT COUNT(DISTINCT pr.river_id)
FROM region r, province p, pro_riv pr 
WHERE r.region_id = p.region_id 
AND p.province_id = pr.province_id 
AND r.name = 'Andalucía';

SELECT COUNT(DISTINCT river_id)
FROM pro_riv
WHERE province_id IN(
    SELECT province_id
    FROM province
    WHERE region_id=(
        SELECT region_id
        FROM region
        WHERE name='Andalucía'
    )
);

-- 17. Número de cadenas montañosas de Andalucía
SELECT COUNT(DISTINCT pm.mountain_id) 
FROM region r, province p, pro_mou pm, mountain m 
WHERE r.region_id = p.region_id 
AND p.province_id = pm.province_id 
AND r.name = 'Andalucía';

SELECT COUNT(DISTINCT mountain_id)
FROM pro_mou
WHERE province_id IN(
    SELECT province_id
    FROM province
    WHERE region_id=(
        SELECT region_id
        FROM region
        WHERE name='Andalucía'
    )
);

-- 18. Usando dos veces la misma tabla en una consulta, ríos
-- más largos que el Guadalquivir

SELECT *
FROM river r1, river r2
WHERE r1.name = 'Guadalquivir'
AND r1.length < r2.length;

SELECT *
FROM river
WHERE length>(
    SELECT length
    FROM river
    WHERE name='Guadalquivir'
);

-- 19. Provincias con menos población que Cádiz

SELECT p2.*
FROM province p1, province p2
WHERE p1.name = 'Cádiz'
AND p1.population > p2.population;

SELECT *
FROM province
WHERE population<(
    SELECT population
    FROM province
    WHERE name='Cádiz'
);

-- 20. Ríos aragoneses que desemboquen en el Mediterráneo

SELECT r.*
FROM region r, province p, pro_riv pr, river ri 
WHERE r.region_id = p.region_id 
AND p.province_id = pr.province_id 
AND pr.river_id = ri.river_id
AND r.name = 'Aragón'
AND ri.sea = 'Mediterráneo';

SELECT *
FROM river
WHERE sea='Mediterráneo'
AND river_id IN (
    SELECT river_id
    FROM pro_riv
    WHERE province_id IN (
        SELECT province_id
        FROM province
        WHERE region_id=(
            SELECT region_id
            FROM region
            WHERE name='Aragón'
        )
    )
);

-- 21. Ríos que nacen en Jaén y desembocan en el Atlántico

SELECT *
FROM province p, pro_riv pr, river ri 
WHERE p.province_id = pr.province_id 
AND pr.river_id = ri.river_id
AND p.name = 'Jaén'
AND ri.sea = 'Atlántico'
AND pr.river_order = 1;

SELECT *
FROM river
WHERE sea='Atlántico'
AND river_id IN (
    SELECT river_id
    FROM pro_riv
    WHERE river_order=1 
    AND province_id IN (
        SELECT province_id
        FROM province
        where name='Jaén'
    )
);


-- 22. Número de ríos que nacen en Jaén

SELECT COUNT(*)
FROM province p, pro_riv pr, river ri 
WHERE p.province_id = pr.province_id 
AND pr.river_id = ri.river_id
AND p.name = 'Jaén'
AND pr.river_order = 1;

SELECT COUNT(*)
FROM river
WHERE river_id IN (
    SELECT river_id
    FROM pro_riv
    WHERE river_order=1 AND province_id IN (
        SELECT province_id
        FROM province
        where name='Jaén'
    )
);

-- 23. Densidad de población de Cataluña

SELECT SUM (population) / SUM (surface)
FROM region r, province p
WHERE r.region_id = p.region_id
AND r.name = 'Cataluña';

SELECT SUM(population)/SUM(surface)
FROM province
WHERE region_id=(
    SELECT region_id
    FROM region
    WHERE name='Cataluña'
);

-- 24. Altura máxima de las cadenas montañosas de Andalucía

SELECT MAX(height)
FROM region r, province p, pro_mou pm, mountain m 
WHERE r.region_id = p.region_id 
AND p.province_id = pm.province_id 
AND pm.mountain_id = m.mountain_id
AND r.name='Andalucía';

SELECT MAX(height)
FROM mountain
WHERE mountain_id IN (
    SELECT mountain_id
    FROM pro_mou
    WHERE province_id IN (
        SELECT province_id
        FROM province
        WHERE region_id=(
            SELECT region_id
            FROM region
            WHERE name='Andalucía'
        )
    )
);

-- 25. Todos los datos de los ríos de Andalucía

SELECT DISTINCT ri.*
FROM region r, province p, pro_riv pr, river ri
WHERE r.region_id = p.region_id 
AND p.province_id = pr.province_id 
AND pr.river_id=ri.river_id
AND r.name='Andalucía';

SELECT *
FROM river
WHERE river_id IN (
    SELECT river_id
    FROM pro_riv
    WHERE province_id IN (
        SELECT province_id
        FROM province
        WHERE region_id=(
            SELECT region_id
            FROM region
            WHERE name='Andalucía'
        )
    )
);

-- En el equijoin las filas de la tabla padre que no se
-- emparejan no aparece en el resultado

-- 26. Equijoin de province y pro_riv, comprobando que 
-- en el resultafo no están todas las provincias

SELECT *
FROM province p, pro_riv pr 
WHERE p.province_id=pr.province_id;

-- LEFT JOIN sirve para que en el resultado aparezcan 
-- todas las filas de la tabla padre, incluso aquellas 
-- que no se emparejan con ninguna fila de la tabla hija. 

-- 27. Left Join de province y pro_riv, comprobando que 
-- Almería sale emparejada con nulos en las columnas
-- de la tabla hija. 

SELECT *
FROM province p LEFT JOIN pro_riv pr 
ON p.province_id=pr.province_id;

-- 28. Agrupar la consulta anterior por los datos de la 
-- provincia y contar el número de rios 

SELECT p.*, COUNT(pr.river_id)
FROM province p LEFT JOIN pro_riv pr 
ON p.province_id=pr.province_id
GROUP BY p.province_id, p.name, p.region_id, p.surface, 
p.population, p.coast, p.capital;

-- 29. Left join de province y pro_mou

SELECT *
FROM province p LEFT JOIN pro_mou pm
ON p.province_id=pm.province_id;

-- 30. Agrupar la consulta anterior por los datos de la 
-- provincia y contar el número de cadenas montañosasa

SELECT p.*, COUNT(pm.mountain_id)
FROM province p LEFT JOIN pro_mou pm
ON p.province_id=pm.province_id
GROUP BY p.province_id, p.name, p.region_id, p.surface, 
p.population, p.coast, p.capital;

-- 31. Todos los datos de cada provincia andaluza, junto con 
-- su porcentaje de población respecto a Andalucía y respecto
-- a España

SELECT *, population/(
    SELECT SUM(population)
    FROM province
    WHERE region_id =(
        SELECT region_id
        FROM region
        WHERE name='Andalucía'
    )
)*100 AS per_andalucía, 
population/(
    SELECT SUM(population)
    FROM province
)*100 AS per_spain
FROM province
WHERE region_id =(
    SELECT region_id
    FROM region
    WHERE name='Andalucía'
);

-- 32. Crea una vista con todos los datos de provincias andaluzas

DROP VIEW IF EXISTS v_andalucía;
CREATE VIEW v_andalucía AS (
SELECT *
FROM province
WHERE region_id =(
    SELECT region_id
    FROM region
    WHERE name='Andalucía'
    )
);

-- 33. Usa la vista anterior para resolver el ejercicio 31

SELECT *, population/(
    SELECT SUM(population)
    FROM v_andalucía
)*100 AS per_andalucía, 
population/(
    SELECT SUM(population)
    FROM province
)*100 AS per_spain
FROM v_andalucía;

-- 34. Todos los datos de las regiones, junto con su población
-- y porcentaje de población respecto a España

SELECT r.*, SUM(p.population) AS sum_pop,
SUM(p.population)/(
    SELECT SUM(population)
    FROM province
)*100 AS per_spain
FROM region r, province p 
WHERE r.region_id=p.region_id
GROUP BY r.region_id, r.name;

-- 35. Todos los datos de las provincias, junto con su densidad
-- de población y una columna llamada 'Category' con los siguientes
-- valores en función de los habitantes por kilómetro cuadrado:
-- -- Very empty menos de 50 
-- -- Empty menos de 100
-- -- Medium menos de 150
-- -- Crowded menos de 200
-- -- Very crowded 200 o más

SELECT *, population/surface AS density,
IF(population/surface<50,"Very Empty",
            IF(population/surface<100,"Empty",
                IF(population/surface<150,"Medium",
                    IF(population/surface<200,"Crowded","Very Crowded")
                    )
                )
            ) AS category
FROM province;

-- 36. Agrupar la consulta anterior por la columna 'Category' 
-- y contar el número de provincias

SELECT 
IF(population/surface<50,"1. Very Empty",
            IF(population/surface<100,"2. Empty",
                IF(population/surface<150,"3. Medium",
                    IF(population/surface<200,"4. Crowded","5. Very Crowded")
                    )
                )
            ) AS category, COUNT(*) AS num_provinces
FROM province
GROUP BY 
IF(population/surface<50,"1. Very Empty",
            IF(population/surface<100,"2. Empty",
                IF(population/surface<150,"3. Medium",
                    IF(population/surface<200,"4. Crowded","5. Very Crowded")
        )
    )
);

-- 37. Para cada provincias (que salgan todas), su identificador, 
-- nombre y número de cadenas montañosas

SELECT p.province_id, p.name, COUNT(pm.mountain_id) AS num_mou
FROM province p LEFT JOIN pro_mou pm
ON p.province_id=pm.province_id
GROUP BY p.province_id, p.name;

-- 38. Añadir a lo anterior el número de ríos

SELECT p.province_id, p.name, 
COUNT(DISTINCT pm.mountain_id) AS num_mou,
COUNT(DISTINCT pr.river_id) AS num_riv
FROM province p 
LEFT JOIN pro_mou pm ON p.province_id=pm.province_id 
LEFT JOIN pro_riv pr ON p.province_id=pr.province_id
GROUP BY p.province_id, p.name;

------------------ Subconsultas correlacionadas ------------------
-- En la subconsulta se usan campos de la consulta principal.
-- Mientras que una subconsulta normal se ejcuta sólo una vez,
-- una correlacionada se ejecuta una vez para cada fila de la
-- consulta principal.

-- 39. Para cada identificador de región, la provincia más poblada

SELECT region_id, name, population
FROM province p1
WHERE population = (
    SELECT MAX(population)
    FROM province p2
    WHERE p1.region_id=p2.region_id
)
ORDER BY 1;

-- 40. Añadir a lo anterior el nombre de la región

SELECT p1.region_id, r.name, p1.name, p1.population
FROM region r, province p1
WHERE r.region_id=p1.region_id
AND p1.population = (
    SELECT MAX(population)
    FROM province p2
    WHERE p1.region_id=p2.region_id
)
ORDER BY 1;

-- 41. Para cada identificador de río, el identificador de la
-- provincia en la que desemboca

SELECT river_id, province_id
FROM pro_riv pr1
WHERE river_order = (
    SELECT MAX(river_order)
    FROM pro_riv pr2
    WHERE pr1.river_id=pr2.river_id
);

-- 42. Añadir a lo anterior los nombres de ríos y de provincias

SELECT pr1.river_id, pr1.province_id, r.name, p.name
FROM province p, pro_riv pr1, river r
WHERE p.province_id=pr1.province_id AND pr1.river_id=r.river_id
AND river_order = (
    SELECT MAX(river_order)
    FROM pro_riv pr2
    WHERE pr1.river_id=pr2.river_id
);
