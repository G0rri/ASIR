USE spain_geo
-- 1. Equijoin de regiones y provincias

SELECT *
FROM region r, province p
WHERE r.region_id = p.province_id;

-- 2. Provincias de Andalucía con más de un millón de habitantes

SELECT *
FROM region r, province p
WHERE r.region_id = p.region_id
AND r.name = 'Andalucia'
AND p.population > 1000000;

-- 3. Regiones costeras

SELECT DISTINCT r.*
FROM region r, province p
WHERE r.region_id = p.region_id
AND p.coast;

-- 4. Equijoin de las tablas provinces, pro_riv y rivers

SELECT *
FROM province p, pro_riv pr, river r
WHERE p.province_id = pr.province_id 
AND pr.river_id = r.river_id;

-- 5. Equijoin de las tablas provinces, pro_mou y mountains

SELECT *
FROM province p, pro_mou pm, mountain m 
WHERE p.province_id = pm.province_id 
AND pm.mountain_id = m.mountain_id;

-- 6. Provincias castellano-manchegas con población comprendida
-- entre 600000 y 900000 habitantes usando AND
SELECT *
FROM province p, region r
WHERE p.region_id = r.region_id
AND (population >= 600000 AND population <= 900000)
AND r.name = 'Castilla La Mancha';

-- 7. Lo mismo pero con el operador BETWEEN

SELECT *
FROM province p, region r
WHERE p.region_id = r.region_id
AND population BETWEEN 600000 AND 900000
AND r.name = 'Castilla La Mancha';

-- 8. Provincias castellano-manchegas con población no comprendida
-- entre 600000 y 900000

SELECT p.*
FROM province p, region r
WHERE p.region_id = r.region_id
AND NOT population BETWEEN 600000 AND 900000
AND r.name = 'Castilla La Mancha';

-- 9. Todos los datos de Cádiz, Sevilla y Córdoba usando OR
SELECT *
FROM province 
WHERE name = 'Cádiz' OR name = 'Sevilla' OR name = 'Córdoba';

-- 10. Lo mismo pero usando el operador IN
SELECT *
FROM province 
WHERE name IN ('Cádiz', 'Sevilla', 'Córdoba');

-- 11. Provincias cuya capital sea distinta a la provincia
SELECT *
FROM province 
WHERE name != capital

SELECT *
FROM province 
WHERE name <> capital

SELECT *
FROM province 
WHERE NOT name = capital

-- 12. Provincias por las que atraviesa el Ebro ordenadas 
SELECT p.name, pr.river_order
FROM province p, pro_riv pr, river r
WHERE p.province_id = pr.province_id 
AND pr.river_id = r.river_id
AND r.name = 'Ebro'
ORDER BY river_order;

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
AND r.name = 'Ebro'
ORDER BY river_order;

-- 15. Número de ríos de Andalucía

SELECT COUNT(DISTINCT pr.river_id)
FROM region r, province p, pro_riv pr 
WHERE r.region_id = p.region_id 
AND p.province_id = pr.province_id 
AND r.name = 'Andalucía';

-- 16. Números de ríos que desembocan en el Atlántico
SELECT COUNT(*)
FROM river 
WHERE sea = 'Atlántico';

-- 17. Número de cadenas montañosas de Andalucía
SELECT COUNT(DISTINCT pm.mountain_id) 
FROM region r, province p, pro_mou pm, mountain m 
WHERE r.region_id = p.region_id 
AND p.province_id = pm.province_id 
AND r.name = 'Andalucía';
-- 18. Usando dos veces la misma tabla en una consulta, ríos
-- más largos que el Guadalquivir

SELECT *
FROM river r1, river r2
WHERE r1.name = 'Guadalquivir'
AND r1.length < r2.length;

-- 19. Provincias con menos población que Cádiz

SELECT p2.*
FROM province p1, province p2
WHERE p1.name = 'Cádiz'
AND p1.population > p2.population;

-- 20. Ríos aragoneses que desemboquen en el Mediterráneo

SELECT r.*
FROM region r, province p, pro_riv pr, river ri 
WHERE r.region_id = p.region_id 
AND p.province_id = pr.province_id 
AND pr.river_id = ri.river_id
AND r.name = 'Aragón'
AND ri.sea = 'Mar Mediterráneo';

-- 21. Ríos que nacen en Jaén y desembocan en el Atlántico

SELECT *
FROM province p, pro_riv pr, river ri 
WHERE p.province_id = pr.province_id 
AND pr.river_id = ri.river_id
AND p.name = 'Jaén'
AND ri.sea = 'Atlántico'
AND pr.river_order = 1;

-- 22. Número de ríos que nacen en Jaén

SELECT COUNT (*)
FROM province p, pro_riv pr, river ri 
WHERE p.province_id = pr.province_id 
AND pr.river_id = ri.river_id
AND p.name = 'Jaén'
AND pr.river_order = 1;

-- 23. Densidad de población de Cataluña

SELECT SUM (population) / SUM (surface)
FROM region r, province p
WHERE r.region_id = p.region_id
AND r.name = 'Cataluña';


-- 24. Altura máxima de las cadenas montañosas de Andalucía

SELECT MAX(height)
FROM region r, province p, pro_mou pm, mountain m 
WHERE r.region_id = p.region_id 
AND p.province_id = pm.province_id 
AND pm.mountain_id = m.mountain_id
AND r.name = 'Andalucía';

-- 25. Todos los datos de los ríos de Andalucía

SELECT DISTINCT r.*
FROM region r, province p, pro_riv pr 
WHERE r.region_id = p.region_id 
AND p.province_id = pr.province_id 
AND r.name = 'Andalucía';

-- La clausula GROUP BY agrupa una o varias columnas
-- que tengan valores repetidos.
-- En la orden SELECT se ponen los mismos campos que en GROUP BY
-- junto con algunas funciones de agregados como COUNT, SUM, etc

-- 26. Para cada identificador de región, número de provincias
-- y suma de superficie y de población

SELECT region_id, COUNT(*), SUM(surface), SUM(population)
FROM province
GROUP BY region_id;

-- 27. Añadir a lo anterior el nombre de la región

SELECT r.region_id, r.name, COUNT(*), SUM(surface), SUM(population)
FROM region r, province p
WHERE r.region_id = p.region_id
GROUP BY r.region_id, r.name;

-- 28. Número de provincias costeras y no costeras

SELECT coast, COUNT(*)
FROM province
GROUP BY coast;

-- 29. Para cada identificador de río, numero de provincias y 
-- de regiones que atraviesa
-- AS es un alias
SELECT pr.river_id, COUNT(*) AS count_pro, 
COUNT(DISTINCT p.region_id) AS count_reg
FROM province p, pro_riv pr
WHERE p.province_id=pr.province_id 
GROUP BY pr.river_id;

-- 30. Añadir a lo anterior el nombre del río

SELECT pr.river_id, r.name, COUNT(*) AS count_pro, COUNT(DISTINCT p.region_id) AS count_reg
FROM province p, pro_riv pr, river r
WHERE p.province_id=pr.province_id AND pr.river_id=r.river_id
GROUP BY pr.river_id, r.name;

-- 31. Para cada identificador de región, número de ríos

SELECT p.region_id, COUNT(DISTINCT pr.river_id) AS count_riv 
FROM province p, pro_riv pr 
WHERE p.province_id=pr.province_id 
GROUP BY p.region_id;

-- 32. Añadir a lo anterior el nombre de la región

SELECT p.region_id, r.name, COUNT(DISTINCT pr.river_id) AS count_riv 
FROM region r, province p, pro_riv pr 
WHERE r.region_id=p.region_id AND p.province_id=pr.province_id 
GROUP BY p.region_id, r.name;

-- 33. Añadir a lo anterior el número de cordilleras
-- Lo dejamos para cuando expliquemos LEFT JOIN

SELECT p.region_id, r.name, 
COUNT(DISTINCT pr.river_id) AS count_riv,
COUNT(DISTINCT pm.mountain_id) AS count_mou
FROM region r, province p, pro_riv pr, pro_mou pm
WHERE r.region_id=p.region_id AND p.province_id=pr.province_id AND p.province_id=pm.province_id
GROUP BY p.region_id, r.name;

-- 34. Para cada identificador de cordillera, número de provincias

SELECT mountain_id, COUNT(*) AS count_pro
FROM pro_mou 
GROUP BY mountain_id;

-- 35. Añadir a lo anterior el número de comunidades autónomas

SELECT pm.mountain_id, 
COUNT(*) AS count_prov,
COUNT(DISTINCT p.region_id) AS count_reg
FROM province p, pro_mou pm
WHERE p.province_id=pm.province_id
GROUP BY pm.mountain_id;

-- 36. Añadir a lo anterior el nombre de la cordillera

SELECT pm.mountain_id, m.name, 
COUNT(*) AS count_prov,
COUNT(DISTINCT p.region_id) AS count_reg
FROM province p, pro_mou pm, mountain m
WHERE p.province_id=pm.province_id AND pm.mountain_id=m.mountain_id
GROUP BY pm.mountain_id, m.name;

-- 37. Para cada mar, número de ríos y longitud media de los ríos

SELECT sea, COUNT(*), AVG(length)
FROM river
GROUP BY sea;
