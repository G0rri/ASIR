-- 1. Para cada cliente (que salgan todos), todos 
-- sus datos y número de facturas. 

SELECT c.*, COUNT(i.invoice_id)
FROM client c LEFT JOIN invoice i 
ON c.client_id=i.client_id
GROUP BY c.client_id, c.name, c.email, c.phone_number, c.address, c.city, c.cif;

-- Si hacemos equijoin no salen los clientes sin facturas
SELECT c.*, COUNT(i.invoice_id)
FROM client c JOIN invoice i 
ON c.client_id=i.client_id
GROUP BY c.client_id, c.name, c.email, c.phone_number, c.address, c.city, c.cif;

-- O lo que es lo mismo 

SELECT c.*, COUNT(i.invoice_id)
FROM client c, invoice i 
WHERE c.client_id=i.client_id
GROUP BY c.client_id, c.name, c.email, c.phone_number, c.address, c.city, c.cif;

-- 2. Para cada producto (que salgan todos), todos 
-- sus datos y número de ítems

SELECT p.*, COUNT(ip.units)
FROM product p LEFT JOIN item_product ip 
ON p.product_id=ip.product_id
GROUP BY p.description, p.price, p.product_id;

-- 2. Para cada producto (que salgan todos), todos 
-- sus datos, número de ítems y suma de unidades. 

SELECT p.*, COUNT(ip.units), IFNULL(SUM(ip.units),0)
FROM product p LEFT JOIN item_product ip 
ON p.product_id=ip.product_id
GROUP BY p.description, p.price, p.product_id;

-- 3. Left Join de worker e item_work

SELECT *
FROM worker w LEFT JOIN item_work iw
ON w.worker_id=iw.worker_id;

-- 4. Agrupar por mecácnico, contar los ítems y sumar las horas.

SELECT w.*, COUNT(iw.worker_id), IFNULL(SUM(hours),0)
FROM worker w LEFT JOIN item_work iw
ON w.worker_id=iw.worker_id
GROUP BY w.cif, w.name, w.phone_number, w.worker_id;

-- 5. Left Join de vehicle e invoice 

SELECT *
FROM vehicle v LEFT JOIN invoice i 
ON v.vehicle_id=i.vehicle_id;

-- 6. Agrupar por vehículo, y contar las facturas.

SELECT v.*, COUNT(i.invoice_id)
FROM vehicle v LEFT JOIN invoice i 
ON v.vehicle_id=i.vehicle_id
GROUP BY v.brand, v.color, v.model, v.vehicle_id;

-- 7. Identificadores de productos comprados por John Smith

SELECT DISTINCT product_id
FROM item_product 
WHERE invoice_id IN (
    SELECT invoice_id
    FROM invoice
    WHERE client_id=(
        SELECT client_id
        FROM client
        WHERE name='Smith, John'
    )
);

-- 8. Nombres de clientes que han comprado aceite

SELECT name 
FROM client
WHERE client_id IN (
    SELECT client_id
    FROM invoice
    WHERE invoice_id IN (
        SELECT invoice_id 
        FROM item_product
        WHERE product_id IN (
            SELECT product_id
            FROM product
            WHERE description LIKE '%Oil%'
        )
    )
);

-- 9. Descripción de productos comprados por John Smith

SELECT description 
FROM product
WHERE product_id IN (
    SELECT product_id
    FROM item_product 
    WHERE invoice_id IN (
        SELECT invoice_id
        FROM invoice
        WHERE client_id=(
            SELECT client_id
            FROM client
            WHERE name='Smith, John'
        )
    )
);

-- 10. Importe, IVA y total de los items de mano de obra
-- del mecánico Sergei Pliskonov

SELECT ROUND(i.price_hour*iw.hours,2) AS import,
ROUND(i.price_hour*iw.hours*0.21,2) AS vat,
ROUND(i.price_hour*iw.hours*1.21,2) AS total
FROM invoice i, item_work iw
WHERE i.invoice_id=iw.invoice_id
AND iw.worker_id=(
    SELECT worker_id
    FROM worker
    WHERE name='Pliskonov, Sergei'
);

-- 11. Todos los datos de facturas de vehículos Opel.

SELECT *
FROM invoice
WHERE vehicle_id IN (
    SELECT vehicle_id
    FROM vehicle
    WHERE brand='Opel'
);

-- 12. Identificador de la factura con más ítems de productos

SELECT invoice_id, COUNT(*)
FROM item_product
GROUP BY invoice_id
HAVING COUNT(*)>= ALL (
    SELECT COUNT(*)
    FROM item_product
    GROUP BY invoice_id
);

-- 13. Añadir a lo anterior todos los datos de la factura

SELECT i.*, COUNT(*)
FROM invoice i, item_product ip
WHERE i.invoice_id=ip.invoice_id
GROUP BY i.invoice_id, i.client_id, i.invoice_date, i.kms, i.price_hour, i.vehicle_id
HAVING COUNT(*)>= ALL (
    SELECT COUNT(*)
    FROM item_product
    GROUP BY invoice_id
);

-- 14. Identificador del cliente que más ha gastado en productos

SELECT i.client_id, SUM(ip.units*ip.price)
FROM invoice i, item_product ip 
WHERE i.invoice_id=ip.invoice_id
GROUP BY i.client_id
HAVING SUM(ip.units*ip.price)>= ALL (
    SELECT SUM(ip.units*ip.price)
    FROM invoice i, item_product ip 
    WHERE i.invoice_id=ip.invoice_id
    GROUP BY i.client_id
);

-- 15. Añadir a lo anterior todos los datos del cliente

SELECT c.*, SUM(ip.units*ip.price)
FROM client c, invoice i, item_product ip 
WHERE c.client_id=i.client_id AND i.invoice_id=ip.invoice_id
GROUP BY c.client_id, c.address, c.cif, c.city, c.email, c.name, c.phone_number
HAVING SUM(ip.units*ip.price)>= ALL (
    SELECT SUM(ip.units*ip.price)
    FROM invoice i, item_product ip 
    WHERE i.invoice_id=ip.invoice_id
    GROUP BY i.client_id
);

-- 16. Para cada producto (que salgan todos), número de ítems,
-- suma de unidades vendidas y suma de importe

SELECT p.*, COUNT(ip.product_id) AS num_item, 
IFNULL(SUM(ip.price*ip.units),0) AS import
FROM product p LEFT JOIN item_product ip
ON ip.product_id=p.product_id
GROUP BY p.product_id, p.description, p.price; 

-- 17. Días transcurridos desde la última factura de Metales Garrido-Smith

SELECT TIMESTAMPDIFF(DAY,MAX(invoice_date),CURRENT_DATE)
FROM invoice
WHERE client_id=(
    SELECT client_id
    FROM client
    WHERE name='Smith, John'
);

-- 18. Porcentaje de descuento (negativo) o de incremento (positivo)
-- de cada ítem, comparando el precio de venta y el precio ac9999tual

SELECT *, (ip.price-p.price)/p.price*100 AS inc_des
FROM item_product ip, product p 
WHERE ip.product_id=p.product_id

-- La función IF(expresión_lógica, valor__then, valor_else)

--- 19. Los datos de los productos, junto con una columna 
-- con el valor "cheap" si el precio es menor a 50€ YEAR
-- "Expensive" en caso contrario. 

SELECT *, IF(price<50,"Cheap","Expensive")
FROM product;

-- 20. Los datos de los productos, junto con una columna 
-- con el valor "Cheap" si el precio es menor a 30€,
-- "Medium" si el precio es menor a 60€ y "Expensive" en 
-- el resto de los casos. 

SELECT *, IF(price<30,"Cheap",IF(price<60,"Medium","Expensive"))
FROM product;

-- 21. Añadir a lo  anterior dos categorías más según
-- -- su precio:
-- -- "Very Cheap" menor que 20
-- -- "Cheap" menor que 40
-- -- "Medium" menor 60
-- -- "Expensive" menor que 80
-- -- "Very Expensive" menor que 80 o más

SELECT *, IF(price<20,"Very Cheap",
            IF(price<40,"Cheap",
                IF(price<60,"Medium",
                    IF(price<80,"Expensive","Very Expemsive")
                    )
                )
            )
FROM product
ORDER BY price;

-- 22. Lo mismo de antes pero empezando por  "Very Expensive"

SELECT *, IF(price>=80,"Very Expensive",
            IF(price<60,"Expensive",
                IF(price<40,"Medium",
                    IF(price>=20,"Cheap","Very Cheap")
                    )
                )
            )
FROM product
ORDER BY price;

-- 23. Clasificar a los clientes como buenos (más de 500€),
-- regulares (más de 100€) y malos (el resto) teniendo
-- en cuenta su gasto en productos

SELECT i.client_id, SUM(ip.units*ip.price) AS import,
    IF(SUM(ip.units*ip.price)>500,"Buenos",
        IF(SUM(ip.units*ip.price)>100,"Regulares","Malos")
    )
FROM invoice i, item_product ip 
WHERE i.invoice_id=ip.invoice_id
GROUP BY i.client_id;

-- 24. Insertar una nueva factura con fecha de hoy para el cliente Smith, John
-- Los ítems son:
--    100 unidades de 'Air filter' con un descuento del 10%
--    200 unidades de 'Spark plug' con un descuento del 5%
INSERT INTO invoice(invoice_id,invoice_date,client_id)
VALUES (20240001,CURRENT_DATE,2);
INSERT INTO item_product(invoice_id,product_id,price,units)
VALUES
(20240001,7,13.14,100),
(20240001,4,5.65,200);

-- 25. Suma de unidades vendidas del producto más vendido

SELECT product_id, SUM(units)
FROM item_product
GROUP BY product_id
HAVING SUM(units)>= ALL (
    SELECT SUM(units)
    FROM item_product
    GROUP BY product_id
);

-- 26.Añadir al anterior la descrpción del producto.

SELECT p.product_id, p.description, SUM(units)
FROM product p, item_product ip
WHERE p.product_id=ip.product_id
GROUP BY p.product_id, p.description
HAVING SUM(units)>= ALL (
    SELECT SUM(units)
    FROM item_product
    GROUP BY product_id
);

-- 27. El producto más caro y el más barato, en la misma fila

SELECT MAX(price), MIN(price)
FROM product;

-- Lo solucionamos con subconsultas en SELECT

SELECT (
    SELECT description
    FROM product
    WHERE price=(
        SELECT MAX(price)
        FROM product
    )
) AS most_expensive,
(
    SELECT (
    SELECT description
    FROM product
    WHERE price=(
        SELECT MIN(price)
        FROM product
    )
    )
) AS cheapeast;

-- Si nos conformamos con dos filas distintas es más fácil

SELECT *
FROM product
WHERE price=(SELECT MAX(price) FROM product)
OR price=(SELECT MIN(price) FROM product)

-- 28. Para cada identificador de producto, suma de importe
-- y porcentaje de importe respecto al total

SELECT product_id, SUM(units*price) AS sum_import,
SUM(units*price)/(
	SELECT SUM(units*price)
	FROM item_product
)*100 AS perhours
FROM item_product
GROUP BY product_id;

-- 28. Para cada identificador de mecánico, suma de horas
-- y porcentaje respecto al total

SELECT worker_id, SUM(hours) AS sum_hours,
SUM(hours)/(
    SELECT SUM(hours)
    FROM item_work
)*100
FROM item_work
GROUP BY worker_id;

-- 29. Añadir a lo anterior la suma del importe de mano de
-- obra y porcentaje respecto al total

SELECT iw.worker_id, SUM(hours) AS sum_hours,
SUM(hours)/(
    SELECT SUM(hours)
    FROM item_work  
)*100 AS per_hours,
ROUND(SUM(iw.hours*i.price_hour),2) AS sum_import,
SUM(iw.hours*i.price_hour)/(
    SELECT SUM(iw.hours*i.price_hour)
    FROM invoice i, item_work iw
    WHERE i.invoice_id=iw.invoice_id
)*11 AS per_import
FROM invoice i, item_work iw
WHERE i.invoice_id=iw.invoice_id
GROUP BY iw.worker_id;

-- 30. Añadir a lo anterior todos los datos del mecánico

SELECT w.*, SUM(hours) AS sum_hours,
SUM(hours)/(
    SELECT SUM(hours)
    FROM item_work  
)*100 AS per_hours,
ROUND(SUM(iw.hours*i.price_hour),2) AS sum_import,
SUM(iw.hours*i.price_hour)/(
    SELECT SUM(iw.hours*i.price_hour)
    FROM invoice i, item_work iw
    WHERE i.invoice_id=iw.invoice_id
)*11 AS per_import
FROM invoice i, item_work iw, worker w
WHERE i.invoice_id=iw.invoice_id 
AND iw.worker_id=w.worker_id
GROUP BY w.worker_id, w.cif, w.name, w.phone_number;

-- 31. Para cada vehículo (que salgan todos), todos sus
-- datos, número de facturas y porcentaje respecto al total

SELECT v.*, COUNT(i.invoice_id),
COUNT(invoice_id)/(
    SELECT COUNT(*)
    FROM invoice
)*100
FROM vehicle v LEFT JOIN invoice i 
ON v.vehicle_id=i.vehicle_id
GROUP BY v.brand, v.color, v.model, v.vehicle_id;

-- 32. Agrupar los productos según las categorías del 
-- ejercicio 21 y contar el número de productos

SELECT IF(price<20,"Very Cheap",
        IF(price<40,"Cheap",
            IF(price<60,"Medium",
                IF(price<80,"Expensive","Very Expensive")
                )
            )
        ) AS category, COUNT(*) AS num_products
FROM product
GROUP BY IF(price<20,"Very Cheap",
        IF(price<40,"Cheap",
            IF(price<60,"Medium",
                IF(price<80,"Expensive","Very Expensive")
                )
            )
        );

-- 33. Añadir a lo anterior el porcentaje respecto al total

SELECT IF(price<20,"Very Cheap",
        IF(price<40,"Cheap",
            IF(price<60,"Medium",
                IF(price<80,"Expensive","Very Expensive")
                )
            )
        ) AS category, COUNT(*) AS num_products,
        COUNT(*)/(
            SELECT COUNT(*)
            FROM product
        )*100 AS per_products
FROM product
GROUP BY IF(price<20,"Very Cheap",
        IF(price<40,"Cheap",
            IF(price<60,"Medium",
                IF(price<80,"Expensive","Very Expensive")
                )
            )
        );


-- 34. Para cada año, suma de importe de productos y
-- porcentaje respecto al total

SELECT YEAR(i.invoice_date), SUM(ip.units*ip.price) AS import,
SUM(ip.units*ip.price)/(
    SELECT SUM(units*price)
    FROM item_product  
)*100 AS per_imp
FROM invoice i, item_product ip 
WHERE i.invoice_id=ip.invoice_id
GROUP BY YEAR(i.invoice_date);

-- 35. De la factura 2020002, el importe de productos,
-- el importe de mano de obra, y la suma de ambos

SELECT (
    SELECT IFNULL(SUM(units*price),0)
    FROM item_product
    WHERE invoice_id=20200002
) AS imp_pro, (
    SELECT IFNULL(SUM(i.price_hour*iw.hours),0)
    FROM invoice i, item_work iw
    WHERE i.invoice_id=iw.invoice_id
    AND i.invoice_id=20200002
) AS imp_wor, 
    (SELECT IFNULL(SUM(units*price),0)
    FROM item_product
    WHERE invoice_id=20200002) + (SELECT IFNULL(SUM(i.price_hour*iw.hours),0)
    FROM invoice i, item_work iw
    WHERE i.invoice_id=iw.invoice_id
    AND i.invoice_id=20200002) AS imp_total;

-- 36. Añadir a lo anterior la fecha de la factura,
-- el cif y el nombre del cliente

SELECT i.invoice_date, c.address, c.cif, c.city, 
c.client_id, c.email, c.name, c.phone_number,
(
    SELECT IFNULL(SUM(units*price),0)
    FROM item_product
    WHERE invoice_id=20200002
) AS imp_pro, (
    SELECT IFNULL(SUM(i.price_hour*iw.hours),0)
    FROM invoice i, item_work iw
    WHERE i.invoice_id=iw.invoice_id
    AND i.invoice_id=20200002
) AS imp_wor, 
    (SELECT IFNULL(SUM(units*price),0)
    FROM item_product
    WHERE invoice_id=20200002) + (SELECT IFNULL(SUM(i.price_hour*iw.hours),0)
    FROM invoice i, item_work iw
    WHERE i.invoice_id=iw.invoice_id
    AND i.invoice_id=20200002) AS imp_total
FROM client c, invoice i    
WHERE c.client_id=i.client_id
AND i.invoice_id=20200002;

-- 37. Lo mismo de antes pero con todas las facturas

-- Left Join de invoice e item_product calculando importe
-- Agrupamos por identificador de factura

SELECT i.invoice_id, IFNULL(SUM(ip.units*ip.price),0)
FROM invoice i LEFT JOIN item_product ip 
ON i.invoice_id=ip.invoice_id
GROUP BY i.invoice_id;

-- Left Join de invoice e item_work calculando importe
-- Agrupamos por identificador de factura

SELECT i.invoice_id, IFNULL(SUM(i.price_hour*iw.hours),0)
FROM invoice i LEFT JOIN item_work iw 
ON i.invoice_id=iw.invoice_id
GROUP BY i.invoice_id;

-- Juntamos las dos consultas anteriores combirtiendolas  
-- en subconsultas en FROM 
-- SELECT ... 
-- FROM (subconsulta 1) s1, (subconsulta 2) s2, ...
-- WHERE ...

SELECT s1.invoice_id, s1.imp_pro, s2.imp_work
FROM (
    SELECT i.invoice_id, IFNULL(SUM(ip.units*ip.price),0) AS imp_pro
    FROM invoice i LEFT JOIN item_product ip 
    ON i.invoice_id=ip.invoice_id
    GROUP BY i.invoice_id
) s1, (
    SELECT i.invoice_id, IFNULL(SUM(i.price_hour*iw.hours),0) AS imp_work
    FROM invoice i LEFT JOIN item_work iw 
    ON i.invoice_id=iw.invoice_id
    GROUP BY i.invoice_id
) s2
WHERE s1.invoice_id=s2.invoice_id; 

----------------VISTAS----------
-- Una vista (view) es una tabla virtual y de sólo lectura
-- que se obtiene a partir de una consulta sobre tablas base 
-- u otras consultas. 
--Las vistas simplifican la labor del programador, ya que 
-- proporcionan los datos procesados de las formas más 
-- útiles para las aplicaciones. 

-- 38. Crea una vista donde con todos los identificadores que facturas 
-- y la suma del importe de productos

DROP VIEW IF EXISTS inv_item_pro;

CREATE VIEW inv_item_pro AS (
    SELECT i.invoice_id, IFNULL(SUM(ip.units*ip.price),0) AS imp_pro
    FROM invoice i LEFT JOIN item_product ip 
    ON i.invoice_id=ip.invoice_id
    GROUP BY i.invoice_id
);

-- 39. Crea una vista donde con todos los identificadores que facturas 
-- y la suma del importe de mano de obra

DROP VIEW IF EXISTS inv_item_work;

CREATE VIEW inv_item_work AS (
    SELECT i.invoice_id, IFNULL(SUM(i.price_hour*iw.hours),0) AS imp_work
    FROM invoice i LEFT JOIN item_work iw 
    ON i.invoice_id=iw.invoice_id
    GROUP BY i.invoice_id
);

-- 40. Resuelve el ejercicio 37 usando las vistas anteriores 

SELECT s1.invoice_id, s1.imp_pro, s2.imp_work
FROM inv_item_pro s1, inv_item_work s2
WHERE s1.invoice_id=s2.invoice_id; 
