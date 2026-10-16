-- 1. Piezas musicales de compositores vivos

SELECT piece_id
FROM pieces
WHERE composer_id IN (
    SELECT composer_id
    FROM composers
    WHERE dead_date IS NULL
);

-- 2. Identificadores de conciertos donde se tocaron piezas
-- de compositores vivos

SELECT concert_id
FROM con_pie
WHERE piece_id IN (
    SELECT piece_id
    FROM pieces
    WHERE composer_id IN (
        SELECT composer_id
        FROM composers
        WHERE dead_date IS NULL
    )
);

-- 3. Para cada intérprete (que salgan todos), todos sus datos
-- y número de conciertos en los que ha participado

SELECT p.*, COUNT(DISTINCT cp.concert_id)
FROM performers p LEFT JOIN con_per cp
ON p.performer_id=cp.performer_id
GROUP BY p.performer_id, p.name, p.birth_date;

-- 4. Conciertos en los que se interpretó alguna pieza de Mozart

SELECT DISTINCT concert_id
FROM con_pie
WHERE piece_id IN (
    SELECT piece_id
    FROM pieces
    WHERE composer_id = (
        SELECT composer_id
        FROM composers
        WHERE name LIKE '%Mozart%'
    )
);

-- 5. Conciertos en los que no se interpretó ninguna pieza de Mozart
-- Es necesaria la tabla concert, 
-- porque tampoco queremos que aparezcan los conciertos ajenos.

SELECT *
FROM concerts
WHERE concert_id NOT IN (
    SELECT concert_id
    FROM con_pie
    WHERE piece_id IN (
        SELECT piece_id
        FROM pieces
        WHERE composer_id IN (
            SELECT composer_id
            FROM composers
            WHERE name LIKE '%Mozart%'
        )
    )
);

-- 6. Edad media actual de los compositores vivos

SELECT composer_id, AVG(TIMESTAMPDIFF(YEAR,birth_date,CURRENT_DATE))
FROM composers
WHERE dead_date IS NULL;

-- 7. Para cada concierto y cada instrumento, número de intérpretes

SELECT concert_id, instrument, COUNT(performer_id)
FROM con_per
GROUP BY concert_id, instrument;

-- 8. El compositor que vivió más años

SELECT *
FROM composers
WHERE TIMESTAMPDIFF(YEAR,birth_date,IFNULL(dead_date,CURRENT_DATE)) = (
    SELECT MAX(TIMESTAMPDIFF(YEAR,birth_date,IFNULL(dead_date,CURRENT_DATE)))
    FROM composers
);

-- Sin usar MAX, es necesario

SELECT *
FROM composers
WHERE TIMESTAMPDIFF(YEAR,birth_date,IFNULL(dead_date,CURRENT_DATE)) >= ALL (
    SELECT TIMESTAMPDIFF(YEAR,birth_date,IFNULL(dead_date,CURRENT_DATE))
    FROM composers
);

-- 9. El concierto más reciente

SELECT *
FROM concerts
WHERE concert_date = (
    SELECT MAX(concert_date)
    FROM concerts
);

-- 10. Músicos que nunca han tocado el violín

SELECT *
FROM performers
WHERE performer_id NOT IN (
    SELECT performer_id
    FROM con_per
    WHERE instrument='Violin'
);

-- 11. Identificadores de conciertos de Stropov

SELECT concert_id
FROM con_per
WHERE performer_id = (
    SELECT performer_id
    FROM performers
    WHERE name LIKE '%Stropov%'
);

-- 12. Todos los datos de conciertos en los que Stropov
-- y Kamarazova han coincidido


SELECT *
FROM concerts
WHERE concert_id IN (
    SELECT concert_id
    FROM con_per
    WHERE performer_id = (
        SELECT performer_id
        FROM performers
        WHERE name LIKE '%Stropov%'
    )
) AND concert_id IN (
    SELECT concert_id
    FROM con_per
    WHERE performer_id = (
        SELECT performer_id
        FROM performers
        WHERE name LIKE '%Kamarazova%'
    )
);

-- 13. Suma de público durante el año 2018

SELECT SUM(people)
FROM concerts
WHERE YEAR(concert_date)=2018;

-- 14. Para cada código de concierto, número de músicos

SELECT concert_id, COUNT(DISTINCT performer_id)
FROM con_per
GROUP BY concert_id

-- 15. El concierto con más músicos

SELECT concert_id, COUNT(DISTINCT performer_id)
FROM con_per
GROUP BY concert_id
ORDER BY 2 DESC
LIMIT 1;

SELECT concert_id, COUNT(DISTINCT performer_id)
FROM con_per
GROUP BY concert_id
HAVING COUNT(DISTINCT performer_id) >= ALL (
    SELECT COUNT(DISTINCT performer_id)
    FROM con_per
    GROUP BY concert_id
);

-- 16. Para cada compositor (que salgan todos), número de
-- conciertos y número de piezas musicales distintas interpretadas

SELECT c.composer_id, COUNT(*), COUNT(DISTINCT cp.piece_id)
FROM composers c 
LEFT JOIN pieces p ON c.composer_id=p.composer_id
LEFT JOIN con_pie cp ON p.piece_id=cp.piece_id
GROUP BY c.composer_id;

-- 17. Intérpretes que hayan participado en todos los conciertos
-- de la Auditorio Municipal

SELECT performer_id, COUNT(*)
FROM con_per
WHERE concert_id IN (
    SELECT concert_id
    FROM concerts
    WHERE auditorium='Auditorio Municipal'
)
GROUP BY performer_id
HAVING COUNT(*) >= ALL (
    SELECT COUNT(*)
    FROM concerts
    WHERE auditorium='Auditorio Municipal'
);

-- 18. Intérpretes que no han participado en ningún concierto
-- de la Auditorio Municipal

SELECT *
FROM performers
WHERE performer_id NOT IN (
    SELECT performer_id
    FROM con_per
    WHERE concert_id IN (
        SELECT concert_id
        FROM concerts
        WHERE auditorium='Auditorio Municipal'
    )
);

-- 19. Para cada intérprete (que salgan todos), todos sus datos y número
-- de instrumentos que toca

SELECT p.*, COUNT(DISTINCT cp.instrument)
FROM performers p LEFT JOIN con_per cp 
ON p.performer_id=cp.performer_id
GROUP BY p.performer_id,p.birth_date,p.name;

-- 20. Modifica la tabla composers para que la clave primaria
-- sea autonumérica(no)

-- 21. MySQL devuelve un error porque existe una clave ajena
-- en la tabla pieces que apunta a la clave primaria de composers(no)

-- 22. Borrar la restricción de integridad de clave ajena(no)

-- 23. Repetimos la instrucción que dió error(no)

-- 24. Volvemos a crear la restricción de clave ajena(no)

-- 25. Inserta al compositor Freddie Mercury, de forma que se genere su clave primaria

-- 26. La función LAST_INSERT_ID() devuelve la última clave primaria autonumérica
-- generada en una operación INSERT

-- 27. Inserta la pieza musical 'Bohemian Rapsody'

-- 28. Modifica la tabla performers para que la clave primaria sea autonumérica

-- 29. Insertar un nuevo intérprete, llamado 'Nganga, Mobutu' que tocó el piano
-- en los conciertos 2 y 3

-- 30. El intérprete que toca más instrumentos distintos

-- 31. Para cada intérprete (que salgan todos), número de veces que
-- ha actuado en la Auditorio Municipal, ordenados por número de conciertos

-- 32. Para cada pieza musical (que salgan todas), número de veces
-- que ha sido interpretada en la Auditorio Municipal

-- 33. Intérpretes que hayan participado en todos los conciertos

-- 34. Para cada concierto, número de violines y número de guitarras

-- 35. Para cada intérprete, número de conciertos en el Gran Teatro
-- y número de conciertos en la Auditorio Municipal

-- 36. Para cada código de concierto, el código del compositor más antiguo

-- 37. Lo mismo pero mostrando todos los datos del concierto y el compositor

-- 38. Todos los datos de los intérpretes junto con el porcentaje de conciertos
-- en los que ha tocada 

-- 39. Crear una vista llamada per_con_per con el left join de las
-- tablas performers y con_per

-- 40. Crear una vista llamada com_pie con el left join de composers y pieces

-- 41. Para cada músico, todos sus datos y el número de piezas musicales

-- 42. Crear una vista llamada con_con_pie con el left join de concerts y con_pie

-- 43. Usando la vista con_con_pie, para cada concierto, número de piezas musicales

-- 44. Suma de público de conciertos donde se ha interpretado música de Mozart

-- 45. Usando la vista con_con_pie, para cada concierto, número de compositores
