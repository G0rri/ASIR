-- 1. Función que devuelve el número de facturas del cliente que se 
-- pasa como parámetro

DELIMITER //
DROP FUNCTION IF EXISTS count_inv//
CREATE FUNCTION count_inv(par_client_id INT)
RETURNS INT
BEGIN
RETURN (
    SELECT COUNT(*)
    FROM invoice
    WHERE client_id=par_client_id
);
END//
DELIMITER ;

-- 2. Probar la función anterior con todos los clientes

SELECT *, count_inv(client_id)
FROM client;

-- 3. Todos los datos del cliente con más facturas

SELECT *, count_inv(client_id)
FROM client
WHERE count_inv(client_id) >= ALL (
    SELECT count_inv(client_id)
    FROM client
);

-- Sin usar el operador ALL

SELECT *, count_inv(client_id)
FROM client
WHERE count_inv(client_id) = (
    SELECT MAX(count_inv(client_id))
    FROM client
);

-- 4. Función que devuelve la suma de importe de productos 
-- de las facturas del cliente que se pasa como parámetro

DELIMITER //
DROP FUNCTION IF EXISTS sum_imp_pro_cli//
CREATE FUNCTION sum_imp_pro_cli(par_client_id INT)
RETURNS DECIMAL(8,2)
BEGIN
RETURN (
    SELECT IFNULL(SUM(units*price),0) AS import
    FROM item_product 
    WHERE invoice_id IN (
        SELECT invoice_id
        FROM invoice
        WHERE client_id=par_client_id
    )
);
END//
DELIMITER ;

-- 5. Probar la función anterior con todos los clientes

SELECT *, sum_imp_pro_cli(client_id)
FROM client;

-- 6. Todos los datos de clientes con más importe que la media

SELECT *, sum_imp_pro_cli(client_id)
FROM client
WHERE sum_imp_pro_cli(client_id) > (
    SELECT AVG(sum_imp_pro_cli(client_id))
    FROM client
);

-- 7. Función que devuelve el importe de productos de la factura que
-- se pasa como parámetro (cero si no hay datos)

DELIMITER //
DROP FUNCTION IF EXISTS imp_pro//
CREATE FUNCTION imp_pro(par_invoice_id INT)
RETURNS DECIMAL(8,2)
BEGIN
RETURN (
    SELECT IFNULL(SUM(units*price),0)
    FROM item_product 
    WHERE invoice_id=par_invoice_id
);
END//
DELIMITER ;

-- 8. Todos los datos de las facturas y su importe de productos

SELECT *, imp_pro(invoice_id)
FROM invoice;

-- 9. Función que devuelve el importe de trabajos de la factura que
-- se pasa como parámetro (cero si no hay datos)

DELIMITER //
DROP FUNCTION IF EXISTS imp_work//
CREATE FUNCTION imp_work(par_invoice_id INT)
RETURNS DECIMAL(8,2)
BEGIN
RETURN (
    SELECT IFNULL(i.price_hour*SUM(iw.hours),0)
    FROM invoice i, item_work iw
    WHERE i.invoice_id=par_invoice_id 
    AND iw.invoice_id=par_invoice_id
);
END//
DELIMITER ;

-- 10. Todos los datos de las facturas y su importe de trabajos

SELECT *, imp_work(invoice_id)
FROM invoice;

-- 11. Función que devuelve el importe total de la factura que
-- se pasa como parámetro (cero si no hay datos)

DELIMITER //
DROP FUNCTION IF EXISTS imp_tot//
CREATE FUNCTION imp_tot(par_invoice_id INT)
RETURNS DECIMAL(8,2)
BEGIN
    RETURN (
         imp_pro(par_invoice_id) + imp_work(par_invoice_id)
    );      
END//
DELIMITER ;

-- 12. Todos los datos de las facturas y su importe total e iva

SELECT *, imp_tot(invoice_id) AS import, 
imp_tot(invoice_id) * 0.21 AS vat
FROM invoice;
 
-- 13. La factura con el importe máximo

SELECT *, imp_tot(invoice_id) AS import
FROM invoice
WHERE imp_tot(invoice_id) = (
    SELECT MAX(imp_tot(invoice_id))
    FROM invoice
);

-- 14. Función que devuelve la suma de unidades vendidas
-- del producto que se pasa como parámetro (cero si no hay datos).

DELIMITER //
DROP FUNCTION IF EXISTS sum_uni//
CREATE FUNCTION sum_uni(par_pro_id INT)
RETURNS INT
BEGIN
    RETURN (
         SELECT IFNULL(SUM(units),0)
         FROM item_product
         WHERE product_id=par_pro_id
    );      
END//
DELIMITER ;

-- 15. Probar la función anterior con todos los productos

SELECT *, sum_uni(product_id)
FROM item_product;

-- 16. El producto más vendido

SELECT *, sum_uni(product_id)
FROM item_product
WHERE sum_uni(product_id) = (
    SELECT MAX(sum_uni(product_id))
    FROM item_product
);

-- 17. Función que devuelve la suma de importe facturado
-- en la fecha que se pasa como parámetro

DELIMITER //
DROP FUNCTION IF EXISTS sum_imp_day//
CREATE FUNCTION sum_imp_day(par_date DATE)
RETURNS DECIMAL(8,2)
BEGIN
    RETURN (
        SELECT SUM(imp_tot(invoice_id))
        FROM invoice
        WHERE invoice_date=par_date
    );      
END//
DELIMITER ;

-- 18. Probar el funcionamiento con todas las fechas (sin duplicados)
-- en las que haya facturas
-- sub-consultas en FROM es necesario poner un ALIAS

SELECT invoice_date, sum_imp_day(invoice_date)
FROM (
    SELECT DISTINCT invoice_date
    FROM invoice
) t;

-- 19. Función que devuelve la suma de importe facturado
-- del vehículo cuya matrícula se pasa como parámetro

DELIMITER //
DROP FUNCTION IF EXISTS sum_imp_veh//
CREATE FUNCTION sum_imp_veh(par_vehicle_id VARCHAR(7))
RETURNS DECIMAL(8,2)
BEGIN
    RETURN (
        SELECT IFNULL(SUM(imp_tot(invoice_id)),0)
        FROM invoice
        WHERE vehicle_id=par_vehicle_id
    );      
END//
DELIMITER ;

-- 20. Suma de importe e iva facturado a cada vehículo

SELECT vehicle_id, sum_imp_veh(vehicle_id) AS import,
sum_imp_veh(vehicle_id) * 0.21 AS vat
FROM vehicle;

-- 21. Función que recibe como parámetro los cuatro dígitos
-- de un año y devuelve el número siguiente de la última factura
-- de ese año

DELIMITER //
DROP FUNCTION IF EXISTS next_invoice_id//
CREATE FUNCTION next_invoice_id(par_year INT(4))
RETURNS INT(8)
BEGIN
    RETURN (
        SELECT IFNULL(MAX(invoice_id),par_year*10000)+1
        FROM invoice
        WHERE YEAR(invoice_id)=par_year
    );      
END//
DELIMITER ;

-- 22. Prueba la función con los años 2019, 2020, 2021 y 2022

SELECT next_invoice_id(2019),
next_invoice_id(2020),
next_invoice_id(2021),
next_invoice_id(2022);

-- 23. Inserta una factura con fecha de hoy, del cliente 2, del 
-- vehiculo '0987QQQ', con 123000 kms y precio de hora 49,99€

INSERT INTO invoice(invoice_id, invoice_date, client_id, kms, vehicle_id, price_hour)
VALUES 
(next_invoice_id(YEAR(CURRENT_DATE)), CURRENT_DATE, 2, 123000, '0987QQQ', 49.99);

-- 24. Función que recibe como parámetros la matrícula de un vehículo
-- y los kilómetros actuales y devuelve los kilómetros recorridos 
-- desde la última factura

DELIMITER //
DROP FUNCTION IF EXISTS kms_inv_id//
CREATE FUNCTION kms_inv_id(par_veh_id VARCHAR(7), par_kms INT(6))
RETURNS INT(6)
BEGIN
    RETURN (
        SELECT par_kms-kms
        FROM invoice
        WHERE invoice_id = (
            SELECT MAX(invoice_id)
            FROM invoice
            WHERE vehicle_id=par_veh_id
        )
    );      
END//
DELIMITER ;

-- Profesor
DELIMITER //
DROP FUNCTION IF EXISTS kms_since_last_invoice//
CREATE FUNCTION kms_since_last_invoice(par_vehicle_id VARCHAR(7), par_kms INT(6))
RETURNS INT(6)
BEGIN
    RETURN par_kms - (
        SELECT MAX(kms)
        FROM invoice
        WHERE vehicle_id=par_vehicle_id
    );      
END//
DELIMITER ;

-- 25. Entra en el taller el vehículo 2134KJH con 76543 kilómetros.
-- ¿Cuántos kilómetros recorrió desde la última factura?

SELECT kms_inv_id('2134KJH', '76543');
