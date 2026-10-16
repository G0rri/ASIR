USE cinema
-- Structured Query Language (SQL)
-- -- Data Definition Language (DDL)
-- -- -- CREATE
-- -- -- DROP
-- -- Data Manipulation Language (DML)
-- -- -- SELECT
-- -- -- INSERT
-- -- -- DELETE
-- -- -- UPDATE

-- El 20% de 100€

SELECT 100 * 0.2 AS resultado;

-- El 20% de 100€ y el 30% de 99€

SELECT 100 * 0.2 AS res1, 99*0.3 AS res2;

-- Los nombres de los artistas

SELECT name
FROM artist;

-- Los nombres de los artistas y u país

SELECT name, country
FROM artist;

--Todos los datos de los artistas

SELECT *
FROM artist;

-- Los  artistas con identificador menor que 5

SELECT *
FROM artist
WHERE artist_id < 5;

-- Los artistas que no sean italianos

SELECT *
FROM artist
WHERE country <> 'italy';

SELECT *
FROM artist
WHERE country != 'italy';

SELECT *
FROM artist
WHERE NOT country = 'italy';

-- Artistas italianos y artistas británicos

SELECT *
FROM artist
WHERE country = 'italy' OR country = 'UK';

-- Artistas no italianos ni britanicos

SELECT *
FROM artist
WHERE NOT (country = 'italy' OR country = 'UK');

SELECT *
FROM artist
WHERE country != 'italy' AND country != 'UK';

-- Artistas que nacieron en los años 50

SELECT *
FROM artist
WHERE birth_date >= '1950-01-01' AND birth_date <'1960-01-01';

SELECT *
FROM artist
WHERE YEAR (birth_date)>=1950 AND YEAR (birth_date)>=1960;

-- Producto cartesiano de estudios y películas

SELECT *
FROM studio, movie;

-- Equijoin  de estudios y películas

SELECT *
FROM studio, movie
WHERE studio.studio_id = movie.studio_id;

SELECT *
FROM studio s, movie m
WHERE s.studio_id = m.studio_id;

-- Equijoin de movie y mov_art

SELECT *
FROM movie m, mov_art ma 
WHERE m.movie_id = ma.movie_id;

-- Equijoin de artist y mov_art

SELECT *
FROM artist a, mov_art ma
WHERE a.artist_id = ma.artist_id;

-- La cardinalidad del equijoin es la cardinalidad de la tabla hija
-- Títulos de películas de Malpaso 

SELECT *
FROM studio s, movie m
WHERE s.studio_id = m.studio_id 
AND s.name = 'Malpaso Productions';

-- Nombres de artistas que han dirigido

SELECT *
FROM artist a, mov_art ma 
WHERE a.artist_id = ma.artist_id
AND ma.rol = 'Director';

-- Website de la productora de Top Gun

SELECT s.website
FROM studio, movie
WHERE s.studio_id = m.studio_id 
AND m.title = 'Top Gun';

-- Identificador del director de Top Gun

SELECT ma.artist_id
FROM movie m, mov_art ma 
WHERE m.movie_id = ma.movie_id 
AND m.title = 'Top Gun' 
AND ma.rol = 'Director';

-- Identificador de actores y actrices de Million Dollar Baby

SELECT ma.artist_id
FROM movie m, mov_art ma 
WHERE m.movie_id = ma.movie_id 
AND m.title = 'Million Dollar Baby' 
AND (ma.rol = 'Actor' OR ma.rol = 'Actress');

SELECT ma.artist_id
FROM movie m, mov_art ma 
WHERE m.movie_id = ma.movie_id 
AND m.title = 'Million Dollar Baby'
AND  ma.rol  IN ('Actor', 'Actress');

-- Todos los datos de películas no producidas por Malpaso ni Paramount

SELECT m.*
FROM studio s, movie m
WHERE s.studio_id = m.studio_id 
AND s.name != 'Malpaso Productions'
AND s.name != 'Paramount Pictures';

SELECT m.*
FROM studio s, movie m
WHERE s.studio_id = m.studio_id 
AND s.name <> 'Malpaso Productions'
AND s.name <> 'Paramount Pictures';

-- Identificador de películas dirigidas por Clint Eastwood

SELECT ma.movie_id
FROM artist a, mov_art ma
WHERE a.artist_id = ma.artist_id
AND a.name = 'Clint Eastwood'
AND ma.rol = 'Director';

-- Artistas vivos 

SELECT *
FROM artist
WHERE death_date IS NULL;

-- Artistas fallecidos

SELECT *
FROM artist
WHERE death_date IS NOT NULL;

-- Equijoin de studio, movie y mov_art

SELECT *
FROM studio s, movie m, mov_art ma
WHERE s.studio_id = m.studio_id
AND m.movie_id = ma.movie_id;

-- Identificadores de artistas que han dirigido para Paramount

SELECT ma.artist_id
FROM studio s, mov_art ma, movie m
WHERE s.studio_id = m.studio_id
AND m.movie_id = ma.movie_id
AND s.name = 'Paramount Pictures'
AND ma.rol = 'Director';

-- Equijoin de studio, movie, mov_art, artist

SELECT *
FROM studio s, movie m, mov_art ma, artist a
WHERE s.studio_id = m.studio_id 
AND m.movie_id = ma.movie_id 
AND ma.artist_id = a.artist_id;

-- Nombres de artistas que han dirigido para Paramunt

SELECT a.name
FROM studio s, movie m, mov_art ma, artist a
WHERE s.studio_id = m.studio_id 
AND m.movie_id = ma.movie_id 
AND ma.artist_id = a.artist_id
AND ma.rol = 'Director'
AND s.name = 'Paramount Pictures';

-- Las funciones CURRENT 
-- CURRENT_DATE: fecha actual AAAA-MM-DD
-- CURRENT_TIME: tiempo actual HH:MM:SS
-- CURRENT_TIMESTAMP: fecha-hora actual AAAA-MM-DD HH:MM:SS 
-- CURRENT_USER: usuario actual 
SELECT CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP, CURRENT_USER
-- La función TIMESTAMPDIFF resta dos expresiones fecha-hora
-- tiene los siguientes argumentos:
-- -- Unidades del resultado (SECOND, MINUTE, HOUR, DAY, YEAR)
-- -- Fecha-hora anterior
-- -- Fecha-hora posterior

-- Edad calculada a partir de una fecha de nacimiento

SELECT TIMESTAMPDIFF (YEAR,'2000-01-15', CURRENT_DATE);

-- La edad actual de los artistas vivos

SELECT *, TIMESTAMPDIFF (YEAR, birth_date, CURRENT_DATE)
FROM artist
WHERE death_date IS NULL;

-- La edad de fallecimiento de los artistas muertos

SELECT *, TIMESTAMPDIFF(YEAR, birth_date, death_date)
FROM artist
WHERE death_date IS NOT NULL;

-- Cuántos días faltan para las vacaciones de Navidad

SELECT TIMESTAMPDIFF (DAY, CURRENT_DATE, '2023-12-22');

-- Cuántos minutos faltan hasta el recreo

SELECT TIMESTAMPDIFF (MINUTE, CURRENT_TIMESTAMP, '2023-11-07 11:00'); 
SELECT TIMEDIFF ('11:00', CURRENT_TIME)

-- Cuántos artistas hay

SELECT COUNT(*) 
FROM artist;

-- Cuántos artistas fallecidos hay

SELECT COUNT(death_date)
FROM artist;

-- De cuántos países distintos son los artistas

SELECT COUNT (DISTINCT country)
FROM artist;
