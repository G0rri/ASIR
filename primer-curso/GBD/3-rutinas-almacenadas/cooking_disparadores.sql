-------------------------------------------------------------------
--------------------- Disparadores en PLSQL -----------------------
-- Se ejecutan automáticamente antes de una operación DML en una tabla:
-- No tienen parámetros.
-- -- BEFORE/AFTER INSERT/DELETE/UPDATE ON <tabla> FOR EACH ROW
-- Para acceder a los datos cada fila afectada se usan prefijos:
-- -- old para DELETE y UPDATE
-- -- new para INSERT y UPDATE
-- Para abortar la operación DML en curso:
-- -- SIGNAL SQLSTATE '2000n' SET message_text='<mensaje>'

-- 1. Disparador que audita inserciones en la tabla de ingredientes. 
-- Inserta en la tabla audit_ingre una fila con los siguientes datos:
-- -- Clave primaria con autoincremento
-- -- Usuario
-- -- Tipo de operación ('INSERT')
-- -- Fecha-tiempo actual
-- -- Identificador del ingrediente (new)
-- -- Descripción (new)
-- -- Precio (new)
-- -- Calorías (new)
-- -- Stock (new)

CREATE TABLE audit_ingre (
	audit_ingre_id INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(30),
	type_oper VARCHAR(30),
	audit_datetime DATETIME,
	ingredient_id INT,
	description VARCHAR(40),
	price DECIMAL(6,2),
	calories INT,
	stock INT
);

DELIMITER //
DROP TRIGGER IF EXISTS audit_ingre_insert//
CREATE TRIGGER audit_ingre_insert
AFTER INSERT ON ingredient FOR EACH ROW
BEGIN
	INSERT audit_ingre(username,type_oper,audit_datetime,ingredient_id,description,price,calories,stock)
	VALUES (USER(),'INSERT',CURRENT_TIMESTAMP,new.ingredient_id,new.description,new.price,new.calories,new.stock);
END//
DELIMITER ;

INSERT ingredient VALUES
(NULL,'Beer',2.00,200,5000),
(NULL,'Whisky',14.00,250,6000),
(NULL,'Gyn',13.50,240,7000);

-- 2. Disparador que audita actualizaciones en la tabla ingredientes. 
-- Inserta en la tabla audit_ingre una fila con los siguientes datos:
-- -- Clave primaria con autoincremento
-- -- Clave primaria con autoincremento
-- -- Usuario
-- -- Tipo de operación ('UPDATE')
-- -- Fecha-tiempo actual
-- -- Identificador del ingrediente
-- -- Descripción (new)
-- -- Precio (new)
-- -- Calorías (new)
-- -- Stock (new)

DELIMITER //
DROP TRIGGER IF EXISTS audit_ingre_update//
CREATE TRIGGER audit_ingre_update
AFTER UPDATE ON ingredient FOR EACH ROW
BEGIN
	INSERT audit_ingre(username,type_oper,audit_datetime,ingredient_id,description,price,calories,stock)
	VALUES (USER(),'UPDATE',CURRENT_TIMESTAMP,new.ingredient_id,new.description,new.price,new.calories,new.stock);
END//
DELIMITER ;

-- 3. Disparador que audita borrados en la tabla ingredientes. 
-- Inserta en la tabla audit_ingre una fila con los siguientes datos:
-- -- Clave primaria con autoincremento
-- -- Usuario
-- -- Tipo de operación ('DELETE')
-- -- Fecha-tiempo actual
-- -- Identificador del ingrediente (old)
-- -- Descripción (old)
-- -- Precio (old)
-- -- Calorías (old)
-- -- Stock (old)

DELIMITER //
DROP TRIGGER IF EXISTS audit_ingre_delete//
CREATE TRIGGER audit_ingre_delete
AFTER DELETE ON ingredient FOR EACH ROW
BEGIN
	INSERT audit_ingre(username,type_oper,audit_datetime,ingredient_id,description,price,calories,stock)
	VALUES (USER(),'DELETE',CURRENT_TIMESTAMP,old.ingredient_id,old.description,old.price,old.calories,old.stock);
END//
DELIMITER ;

-- 4. Disparador que impide que se puedan borrar filas de la tabla 
-- de comandas con más de 30 días de antigüedad

DELIMITER //
DROP TRIGGER IF EXISTS no_delete_command//
CREATE TRIGGER no_delete_command
AFTER DELETE ON command FOR EACH ROW
BEGIN
	IF TIMESTAMPDIFF(DAY,old.command_date,CURRENT_DATE) > 30 THEN
		SIGNAL SQLSTATE '20001' SET message_text='Deletion older than 30 days not allowed';
	END IF;
END//
DELIMITER ;


-- 5. Disparador que impide que se puedan insertar filas de la tabla 
-- de comandas si existen más de cinco menús con igual fecha que la 
-- fecha del que se está insertando

DELIMITER //
DROP TRIGGER IF EXISTS no_insert_command//
CREATE TRIGGER no_insert_command
AFTER INSERT ON command FOR EACH ROW
BEGIN
	IF (
		SELECT COUNT(*)
		FROM command
		WHERE command_date=new.command_date
	) >= 5 THEN
		SIGNAL SQLSTATE '20002' SET message_text='Insertion not allowed, more than 5 commands this day';
	END IF;
END//
DELIMITER ;

-- 6. Disparador que impide que se pueda subir el precio de un
-- ingrediente más de un 10%

DELIMITER //
DROP TRIGGER IF EXISTS no_increase_price//
CREATE TRIGGER no_increase_price
AFTER UPDATE ON ingredient FOR EACH ROW
BEGIN
	IF (new.price - old.price)/old.price*100 > 10 THEN
		SIGNAL SQLSTATE '20003' SET message_text='Price increases not allowed';
	END IF;
END//
DELIMITER ;

DELIMITER //
DROP TRIGGER IF EXISTS no_increase_price//
CREATE TRIGGER no_increase_price
AFTER UPDATE ON ingredient FOR EACH ROW
BEGIN
	IF old.price * 1.10 < new.price  THEN
		SIGNAL SQLSTATE '20003' SET message_text='Price increases not allowed';
	END IF;
END//
DELIMITER ;

-- 7. Disparador que al insertar una comanda resta el stock 
-- de todos los ingredientes

DELIMITER //
DROP TRIGGER IF EXISTS insert_command//
CREATE TRIGGER insert_command
AFTER INSERT ON command FOR EACH ROW
BEGIN
	UPDATE ingredient i1
		SET stock = stock - (
			SELECT quantity * new.rations
			FROM item i2
			WHERE i1.ingredient_id = i2.ingredient_id
			AND recipe_id = new.recipe_id
		)
		WHERE ingredient_id IN (
			SELECT ingredient_id
			FROM item
			WHERE recipe_id = new.recipe_id
		);
END//
DELIMITER ;

-- 8. Modificar el disparador anterior de forma que se aborte
-- la operación en caso de stock insuficiente de algún
-- ingrediente

DELIMITER //
DROP TRIGGER IF EXISTS insert_command//
CREATE TRIGGER insert_command
AFTER INSERT ON command FOR EACH ROW
BEGIN
	IF enough_stock(new.recipe_id,new.rations) THEN
	UPDATE ingredient i1
		SET stock = stock - (
			SELECT quantity * new.rations
			FROM item i2
			WHERE i1.ingredient_id = i2.ingredient_id
			AND recipe_id = new.recipe_id
		)
		WHERE ingredient_id IN (
			SELECT ingredient_id
			FROM item
			WHERE recipe_id = new.recipe_id
		);
	ELSE
	SIGNAL SQLSTATE '20004' SET message_text='Not enough stock of some ingredients';
	END IF;
END//
DELIMITER ;
