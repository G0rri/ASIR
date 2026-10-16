-- Rutinas almacenadas en la Base de Datos 
-- Se escriben en un lenguaje llamado PL-SQL
-- Procedimental Language Structured Query Language
-- En PLSQL se programan tres tipos de rutinas:
-- -- Funciones: Tienen una lista de argumentos de entrada (parámetros)
-- -- y devuelven un valor. Son readonly con los datos (SELECT).

-- -- Procedimientos: Tienen una lista de argumentos de entrada
-- -- y de salida y no devuelven ningún valor. No son readonly,
-- -- modifican los datos mediante INSERT, DELETE y UPDATE.

-- -- Disparadores: No tienen lista de argumentos, no devuelven
-- -- ningún valor y se disparan automáticamente cuando se
-- -- ejecuta alguna operación INSERT, DELETE y UPDATE

-- 1. Función que recibe como argumento el identificador 
-- de una receta y devuelve el número de ingredientes

DELIMITER //
DROP FUNCTION IF EXISTS count_ing//
CREATE FUNCTION count_ing(par_rec_id INT)
RETURNS INT
BEGIN
RETURN (
    SELECT COUNT(*)
    FROM item 
    WHERE recipe_id=par_rec_id
);
END//
DELIMITER ;

-- 2. Para cada receta, todos sus datos y número de ingredientes

-- Sin usar la función anterior

SELECT r.*, COUNT(i.ingredient_id)
FROM recipe r LEFT JOIN item i 
ON r.recipe_id=i.recipe_id
GROUP BY r.recipe_id, r.description, r.diff_level;

-- Usando la función

SELECT *, count_ing(recipe_id)
FROM recipe;

-- 3. Todos los datos de la receta con más ingredientes

SELECT *, count_ing(recipe_id)
FROM recipe
WHERE count_ing(recipe_id) = (
    SELECT MAX(count_ing(recipe_id))
    FROM recipe
);

-- 4. Función que recibe como parámetro el identificador de
-- una receta y devuelve la suma de sus calorías por ración

DELIMITER //
DROP FUNCTION IF EXISTS count_sum_cal//
CREATE FUNCTION count_sum_cal(par_rec_id INT)
RETURNS INT
BEGIN
RETURN (
    SELECT SUM(i.calories*it.quantity)/100
    FROM ingredient i, item it
    WHERE i.ingredient_id=it.ingredient_id
    AND it.recipe_id=par_rec_id
);
END//
DELIMITER ;

-- 5. Para cada receta, todos sus datos y suma de calorías

SELECT *, count_sum_cal(recipe_id)
FROM recipe;

-- 6. La receta más ligera

SELECT *, count_sum_cal(recipe_id)
FROM recipe
WHERE count_sum_cal(recipe_id) = (
    SELECT MIN(count_sum_cal(recipe_id))
    FROM recipe
);

-- 7. Función booleana que devuelve verdadero si un ingrediente
-- se ha usado en una fecha determinada. Recibe dos parámetros:
-- -- Identificador del ingrediente
-- -- Fecha

DELIMITER //
DROP FUNCTION IF EXISTS is_used//
CREATE FUNCTION is_used(par_ing_id INT, par_date DATE)
RETURNS BOOLEAN
BEGIN
RETURN par_ing_id IN (
    SELECT ingredient_id
    FROM item
    WHERE recipe_id IN (
        SELECT recipe_id
        FROM command
        WHERE command_date=par_date
    )
);
END//
DELIMITER ;

-- 8. ¿Se usó bacon (20) el día 6 de abril de 2021?

SELECT is_used(20,'2021-04-06');

-- 9. Ingredientes que no se usaron el 6 de abril de 2021

SELECT *
FROM ingredient 
WHERE NOT is_used(ingredient_id,'2021-04-06');

-- 10. Función booleana que devuelve verdadero si existe suficiente 
-- stock de ingredientes para una receta. Recibe dos parámetros:
-- -- Identificador de la receta
-- -- Número de raciones

DELIMITER //
DROP FUNCTION IF EXISTS enough_stock//
CREATE FUNCTION enough_stock(par_recipe_id INT, n INT)
RETURNS BOOLEAN
BEGIN
RETURN 1 = ALL (
    SELECT i.stock > it.quantity*n
    FROM ingredient i, item it 
    WHERE i.ingredient_id=it.ingredient_id
    AND it.recipe_id=par_recipe_id
);
END//
DELIMITER ;

-- ¿Tenemos para 3 raciones de la receta 1?

SELECT enough_stock(1,3);

-- 11. ¿Hay stock para 45 raciones de Grilled tuna (2)?

SELECT enough_stock(2,45)

-- 12. Todos los datos de recetas para las que hay stock suficiente
-- para 20 raciones

SELECT * 
FROM recipe
WHERE enough_stock(recipe_id,20);

-- 13. Función que devuelve la clasificación energética de la receta
-- cuyo identificador se pasa como parámetro, según la siguiente tabla:
-- -- hasta 300 calorías 'Low'
-- -- más de 300 y hasta 500 'Medium'
-- -- más de 500 y hasta 700 'High'
-- -- más de 700 'Very high'

DELIMITER //
DROP FUNCTION IF EXISTS energy//
CREATE FUNCTION energy(par_recipe_id INT)
RETURNS VARCHAR(20)
BEGIN
RETURN (
IF(count_sum_cal(par_recipe_id) IS NULL, NULL,
    IF(count_sum_cal(par_recipe_id)<=300, 'Low',
        IF(count_sum_cal(par_recipe_id)<=500, 'Medium',
            IF(count_sum_cal(par_recipe_id)<=700, 'High', 'Very High'
                )
            )
        )
    )
);
END//
DELIMITER ;

-- 14. Clasificación energética de todas las recetas

SELECT *, energy(recipe_id)
FROM recipe;

-- 15. Agrupa las recetas por su clasificación energética y
-- cuenta el número de recetas

SELECT energy(recipe_id), COUNT(*)
FROM recipe
GROUP BY energy(recipe_id);

-- 16. Función que devuelve verdadero si con cierta cantidad euros
-- tenemos suficiente dinero para un número de raciones de una receta.
-- Recibe como parámetros:
-- -- Cantidad de euros
-- -- Identificador de la receta
-- -- Número de raciones

DELIMITER //
DROP FUNCTION IF EXISTS enough_money//
CREATE FUNCTION enough_money(euros DECIMAL(6,2), par_recipe_id INT, n INT)
RETURNS BOOLEAN
BEGIN
RETURN euros >= (
    SELECT n * SUM(i.price*it.quantity)/1000
    FROM ingredient i, item it 
    WHERE i.ingredient_id=it.ingredient_id
    AND it.recipe_id=par_recipe_id
);
END//
DELIMITER ;

-- 17. Para todas las recetas, comprueba qué devuelve la función
-- con 10 euros y 9 raciones

SELECT *, enough_money(10,recipe_id,9)
FROM recipe;

-- 18. Función que devuelve el coste de una ración de una receta 
-- cuyo identificador se pasa como parámetro

DELIMITER //
DROP FUNCTION IF EXISTS cost//
CREATE FUNCTION cost(par_recipe_id INT)
RETURNS DECIMAL(6,2)
BEGIN
RETURN (
    SELECT SUM(i.price*it.quantity)/1000
    FROM ingredient i, item it 
    WHERE i.ingredient_id=it.ingredient_id
    AND it.recipe_id=par_recipe_id
);
END//
DELIMITER ;

-- 19. El coste de todas las recetas

SELECT *, cost(recipe_id)
FROM recipe;

-- 20. Utiliza la función del ejercicio 18 para simplificar la función
-- del ejercicio 16

DELIMITER //
DROP FUNCTION IF EXISTS enough_money//
CREATE FUNCTION enough_money(euros DECIMAL(6,2), par_recipe_id INT, n INT)
RETURNS BOOLEAN
BEGIN
RETURN euros >= cost(par_recipe_id) * n;
END//
DELIMITER ;

