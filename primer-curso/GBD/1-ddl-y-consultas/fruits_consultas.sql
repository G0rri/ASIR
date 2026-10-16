USE fruits
-- 1. Equijoin de frutas y parcelas

SELECT *
FROM fruit f, parcel p 
WHERE f.fruit_id=p.fruit_id;

-- 2. Para cada especie, número de parcelas,
-- suma de hectáreas y suma de árboles

SELECT f.specie, COUNT(*), SUM(p.surface), SUM(num_trees)
FROM fruit f, parcel p 
WHERE f.fruit_id=p.fruit_id
GROUP BY f.specie; 

-- 3. Para cada especie y variedad, número de parcelas,
-- suma de hectáreas y suma de árboles

SELECT f.specie, f.variety, COUNT(p.parcel_id), SUM(p.surface), SUM(num_trees)
FROM fruit f, parcel p 
WHERE f.fruit_id=p.fruit_id
GROUP BY f.specie, f.variety; 

-- 4. Equijoin de parcela y cosecha

SELECT *
FROM parcel p, harvest h 
WHERE p.parcel_id=h.parcel_id;

-- 5. Para cada parcela, todos sus datos y suma de kilos

SELECT p.*, SUM(kilos)
FROM parcel p, harvest h 
WHERE p.parcel_id=h.parcel_id
GROUP BY p.parcel_id, p.surface, p.num_trees, p.fruit_id;

-- 6. Añadir a lo anterior la especie y variedad

SELECT p.*, f.specie, f.variety, SUM(kilos)
FROM fruit f, parcel p, harvest h 
WHERE f.fruit_id=p.fruit_id AND p.parcel_id=h.parcel_id
GROUP BY p.parcel_id, p.surface, p.num_trees, p.fruit_id, f.specie, f.variety;

-- 7. Para cada año, suma de kilos

SELECT YEAR(harvest_date), SUM(kilos)
FROM harvest
GROUP BY YEAR(harvest_date);

-- 8. Para cada año y especie, suma de kilos

SELECT YEAR(h.harvest_date), f.specie, SUM(h.kilos)
FROM fruit f, parcel p, harvest h
WHERE f.fruit_id=p.fruit_id AND p.parcel_id=h.parcel_id
GROUP BY YEAR(h.harvest_date), f.specie;

-- 9. Equijoin de jornalero y cosecha

SELECT *
FROM worker w, harvest h 
WHERE h.worker_id=w.worker_id;

-- 10. Para el jornalero con identificador 1, cuenta de días trabajados,
-- cuenta de parcelas y suma de kilos

SELECT w.worker_id, COUNT(DISTINCT h.harvest_date) AS days_worked, 
COUNT(DISTINCT h.parcel_id), SUM(h.kilos)
FROM worker w, harvest h 
WHERE h.worker_id=w.worker_id
AND w.worker_id="1"
GROUP BY w.worker_id;

-- 11. Para cada identificador de jornalero, cuenta de días trabajados,
-- cuenta de parcelas y suma de kilos

SELECT w.worker_id, COUNT(DISTINCT h.harvest_date) AS days_worked, 
COUNT(DISTINCT h.parcel_id), SUM(h.kilos)
FROM worker w, harvest h 
WHERE h.worker_id=w.worker_id
GROUP BY w.worker_id;

-- 12. Añadir a lo anterior todos los datos del jornalero

SELECT w.*, COUNT(DISTINCT h.harvest_date) AS days_worked, 
COUNT(h.parcel_id), SUM(h.kilos)
FROM worker w, harvest h 
WHERE h.worker_id=w.worker_id
GROUP BY w.worker_id, w.name, w.born_date;

-- 13. Cuenta de parcelas y suma de árboles de pera ercolina

SELECT COUNT(p.parcel_id), SUM(f.fruit_id)
FROM fruit f, parcel p
WHERE f.fruit_id=p.parcel_id
AND f.fruit_id="1"
GROUP BY p.parcel_id;

-- 14. Para cada parcela y año, suma de kilos

SELECT parcel_id, YEAR(harvest_date), SUM(kilos)
FROM harvest h 
GROUP BY parcel_id, YEAR(harvest_date);

-- 15. Edad de cada trabajador que haya recogido manzana roja

SELECT DISTINCT w.*, TIMESTAMPDIFF(YEAR,born_date,CURRENT_DATE) AS age
FROM fruit f, parcel p, harvest h, worker w
WHERE f.fruit_id=p.fruit_id AND p.parcel_id=h.parcel_id 
AND h.worker_id=w.worker_id
AND f.specie="Apple" AND f.variety="Red";

-- 16. Especie y variedad de frutas recogidas por Igor Stropov

SELECT DISTINCT f.specie, f.variety
FROM fruit f, parcel p, harvest h, worker w
WHERE f.fruit_id=p.fruit_id AND p.parcel_id=h.parcel_id 
AND h.worker_id=w.worker_id
AND w.name="Stropov, Igor";

-- 17. Densidad de árboles de cada parcela

SELECT *, num_trees/surface
FROM parcel;

-- 18. Superficie de la parcela más grande de manzana roja

SELECT MAX(p.surface)
FROM fruit f, parcel p
WHERE f.fruit_id=p.fruit_id
AND f.specie="Apple" AND f.variety="Red";

-- 19. Suma de kilos de diciembre de 2021

SELECT SUM(kilos)
FROM harvest
WHERE harvest_date="2021-12%";

-- 20. Para cada trabajador, todos sus datos y porcentaje sus kilos
-- respecto al total de kilos. Hay que hacer una consulta previa 
-- para calcular la suma total de kilos.

SELECT SUM(kilos)
FROM harvest;

SELECT w.*, ROUND(SUM(h.kilos)/14611*100,1) AS kg_percent
FROM harvest h, worker w
WHERE h.worker_id=w.worker_id
GROUP BY w.worker_id, w.name, w.born_date;

-- 21. Todos los datos del trabajador más joven. Hay que hacer una
-- consulta previa para calcular el máximo de la fecha de nacimiento.

-- (Resuelto en 2-consultas-avanzadas/fruits_avanzadas.sql, ejercicio 20 y siguientes)
