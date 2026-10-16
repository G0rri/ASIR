-- 1. Procedimiento que inserta o modifica un ingrediente.
-- Recibe como parámetros:
-- -- Descripción del ingrediente
-- -- Precio
-- -- Calorías
-- -- Stock
-- Si el ingrediente ya existe, se actualizan precio, calorías y stock.
-- Si el ingrediente es nuevo, se inserta una fila con todos los datos.

DELIMITER //
DROP PROCEDURE IF EXISTS upsert_ingred//
CREATE PROCEDURE upsert_ingred(par_des VARCHAR(40), par_pri DECIMAL(6,2), par_cal INT, par_sto INT)
BEGIN
	IF par_des IN (SELECT description FROM ingredient) THEN
		UPDATE ingredient
		SET price=par_pri, calories=par_cal, stock=par_sto
		WHERE description=par_des;
	ELSE
		INSERT ingredient(description, price, calories, stock)
		VALUES (par_des, par_pri, par_cal, par_sto);
	END IF;
END//
DELIMITER ;

-- 2. Prueba con un ingrediente que ya existe

CALL upsert_ingred('Butter',4.90,717,3200);
 
-- 3. Prueba con un ingrediente nuevo

CALL upsert_ingred('Banana',1.90,89,5000);

-- 4. Procedimiento que inserta o modifica un ítem.
-- Recibe como parámetros:
-- -- Identificador de la receta
-- -- Identificador del ingrediente
-- -- Cantidad
-- Si el ítem ya existía, se actualiza la cantidad.
-- Si el ítem es nuevo, se inserta una fila con todos los datos.
-- Ojo: la tabla ítem tiene una clave primaria compuesta.

DELIMITER //
DROP PROCEDURE IF EXISTS upsert_item//
CREATE PROCEDURE upsert_item(par_recipe_id INT, par_ingredient_id INT, par_quantity INT)
BEGIN
	IF (
		SELECT TRUE
		FROM item
		WHERE recipe_id=par_recipe_id 
		AND ingredient_id=par_ingredient_id
	) THEN
		UPDATE item
		SET quantity=par_quantity
		WHERE recipe_id=par_recipe_id 
		AND ingredient_id=par_ingredient_id;
	ELSE
		INSERT item(recipe_id, ingredient_id, quantity)
		VALUES (par_recipe_id, par_ingredient_id, par_quantity);
	END IF;
END//
DELIMITER ;

-- 5. Prueba con un item que ya existe

CALL upsert_item(5,17,90);

-- 6. Prueba con un item nuevo

CALL upsert_item(5,5,25);

-- 7. Añadir al procedimiento anterior un parámetro de salida
-- de tipo entero que tomará el siguiente valor:
-- -- 1 si se modifica el item
-- -- 2 si se inserta el item

DELIMITER //
DROP PROCEDURE IF EXISTS upsert_item//
CREATE PROCEDURE upsert_item(par_recipe_id INT, par_ingredient_id INT, par_quantity INT, OUT par_out INT)
BEGIN
	IF (
		SELECT TRUE
		FROM item
		WHERE recipe_id=par_recipe_id 
		AND ingredient_id=par_ingredient_id
	) THEN
		UPDATE item
		SET quantity=par_quantity
		WHERE recipe_id=par_recipe_id 
		AND ingredient_id=par_ingredient_id;
		SET par_out = 1;
	ELSE
		INSERT item(recipe_id, ingredient_id, quantity)
		VALUES (par_recipe_id, par_ingredient_id, par_quantity);
		SET par_out = 2;
	END IF;
END//
DELIMITER ;

-- 8. Prueba con un item que existe

CALL upsert_item(1,5,38,@x);
SELECT @x;

-- 9. Prueba con un item que no existe

CALL upsert_item(1,4,100,@x);
SELECT @x;

-- 10. Procedimiento que inserta una nueva comanda.
-- Los parámetros de entrada son dos:
-- -- número de raciones
-- -- identificador de la receta
-- Si hay suficiente stock de ingredientes para la comanda,
-- entonces se inserta la comanda con la fecha del sistema y
-- se actualizan (restando) los stocks de ingredientes.
-- Si no hay suficiente stock entonces no se hace nada.
-- Mediante un parámetro de salida se devuelve un 0 si no hay 
-- suficiente stock y un 1 en caso contrario.

DELIMITER //
DROP PROCEDURE IF EXISTS insert_command//
CREATE PROCEDURE insert_command(par_rations INT, par_recipe_id INT, OUT par_out INT)
BEGIN
	IF enough_stock(par_recipe_id,par_rations) THEN
		INSERT command(command_date, rations, recipe_id)
		VALUES (CURRENT_DATE, par_rations, par_recipe_id);
		UPDATE ingredient i1
		SET stock = stock - (
			SELECT quantity * par_rations
			FROM item i2
			WHERE i1.ingredient_id = i2.ingredient_id
			AND recipe_id = par_recipe_id
		)
		WHERE ingredient_id IN (
			SELECT ingredient_id
			FROM item
			WHERE recipe_id = par_recipe_id
		);
		SET par_out = 1;
	ELSE
		SET par_out = 0;
	END IF;
END//
DELIMITER ;

-- 11. Nueva comanda de 100 raciones de paella

CALL insert_command(100,5,@x);
SELECT @x;

-- 12. Nueva comanda de 2 raciones de paella

CALL insert_command(2,5,@x);
SELECT @x;
