-- 1.Equijoin de tres tablas, las que quieras. 

SELECT *
FROM cyclist c, cyc_sta cs, stage s
WHERE c.cyclist_id=cs.cyclist_id 
AND cs.stage_id=s.stage_id;

-- 2.Todods los datos de ciclistas que han ganado alguna etapa, 
-- junto a su edad actual.

SELECT c.*, cs.result_order, TIMESTAMPDIFF(YEAR, birth_date, CURRENT_DATE)
FROM cyclist c, cyc_sta cs 
WHERE c.cyclist_id=cs.cyclist_id
AND cs.result_order="1"
GROUP BY c.cyclist_id, c.name, c.country, c.birth_date, c.team_id, cs.result_order;

--3.Para cada ciclista, todos sus datos y suma de kilómetros que ha recorrido. 

SELECT c.*, SUM(s.kms)
FROM cyclist c, cyc_sta cs, stage s 
WHERE c.cyclist_id=cs.cyclist_id 
AND cs.stage_id=s.stage_id
GROUP BY c.cyclist_id, c.name, c.country, c.birth_date, c.team_id;

--4.Para cada etapa, todos sus datos, número de ciclistas que han participado 
-- y número de ciclistas que la han terminado.

SELECT s.*, COUNT(*), COUNT(cs.cyclist_id)
FROM stage s, cyc_sta cs 
WHERE s.stage_id=cs.cyclist_id
GROUP BY s.stage_id, s.st_date, s.st_from, s.st_to, s.kms;

--5.Todos los datos de ciclistas que abandonaron 
-- en la etapa que acabó en Salamanca. 

SELECT c.*, s.st_to
FROM cyclist c, cyc_sta cs, stage s 
WHERE c.cyclist_id=cs.cyclist_id 
AND cs.stage_id=s.stage_id
AND s.st_to="Salamanca"
AND cs.result_order IS NULL
GROUP BY c.cyclist_id, c.name, c.country, c.birth_date, c.team_id;
