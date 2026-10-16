USE car_repair_garage
-- 1. Todos los datos de los items de productos de la factura
-- 20190001, junto con el importe, el IVA (21%) y el total

SELECT *, price*units AS import,
ROUND(price*units*0.21,2) AS iva, 
ROUND(price*units*1.21,2) AS total
FROM item_product
WHERE invoice_id=20190001;

-- 2. Añadir a lo anterior la descripción del producto

SELECT ip.*, p.description, ip.price*ip.units AS import,
ROUND(ip.price*ip.units*0.21,2) AS iva, 
ROUND(ip.price*ip.units*0.21,2) AS total
FROM item_product ip, product p
WHERE ip.product_id=p.product_id
AND ip.invoice_id=20190001;

-- 3. Equijoin de customer e invoice

SELECT *
FROM client c, invoice i 
WHERE c.client_id=i.client_id

-- 4. Equijoin de invoice e item work

SELECT *
FROM invoice i, item_work iw
WHERE i.invoice_id=iw.invoice_id

-- 5. Identificadores de clientes que han comprado aceite

SELECT DISTINCT i.client_id
FROM invoice i, item_product ip, product p
WHERE i.invoice_id=ip.invoice_id AND ip.product_id=p.product_id
AND p.description LIKE "Oil%";

-- 6. Identificadores de productos comprados por John Smith

SELECT DISTINCT ip.product_id
FROM client c, invoice i, item_product ip 
WHERE c.client_id=i.client_id 
AND i.invoice_id=ip.invoice_id
AND c.name="Smith, John";

-- 7. Nombres de clientes que han comprado aceite

SELECT DISTINCT c.name
FROM client c, invoice i, item_product ip, product p
WHERE c.client_id=i.client_id 
AND i.invoice_id=ip.invoice_id
AND ip.product_id=p.product_id
AND p.description LIKE "Oil%";

-- 8. Descripción de productos comprados por John Smith

SELECT DISTINCT p.description
FROM client c, invoice i, item_product ip, product p
WHERE c.client_id=i.client_id 
AND i.invoice_id=ip.invoice_id
AND ip.product_id=p.product_id
AND c.name="Smith, John";

-- 9. Importe, IVA y total de los items de mano de obra del
-- mecánico Pliskonov, Sergei

SELECT ROUND (i.price_hour*hours,2) AS import,
ROUND (i.price_hour*hours*0.21,2) AS vat, 
ROUND (i.price_hour*hours*1.21,2) AS total
FROM invoice i, item_work iw, worker w
WHERE i.invoice_id=iw.invoice_id AND iw.worker_id=w.worker_id
AND w.name="Pliskonov, Sergei";

-- El operador LIKE se utiliza para buscar una subcadena en una 
-- cadena de caracteres usando patrones con % como comodín

-- 10. Clientes que tengan un correo de yahoo

SELECT *
FROM client
WHERE email LIKE "%yahoo%";

-- 11. Clientes cuyo nombre sea John

SELECT name
FROM client
WHERE name LIKE "%John%";

-- 12. Facturas del día 12, sin especificar mes ni año

SELECT *
FROM invoice
WHERE invoice_date LIKE "%-%-12";

SELECT *
FROM invoice
WHERE DAY(invoice_date)=12;

-- FUNCIONES DE AGREGADOS
-- -- COUNT(*) cuenta filas
-- -- COUNT(exp_col) cuenta valores no nulos
-- -- COUNT(DISTINCT exp_col) cuenta valores distintos no nulos
-- -- MAX(exp_col) valor máximo de caracteres, números y fechas
-- -- MIN(exp_col) valor mínimo de caracteres, números y fechas
-- -- AVG(exp_col) valor promedio de números
-- -- SUM(exp_col) suma de números

-- 13. Contar los clientes

SELECT COUNT(*)
FROM client;

-- 14. Contar los clientes con servidor de correo de gmail

SELECT COUNT(*)
FROM client
WHERE email LIKE "%gmail%";

-- 15. Contar los clientes con dirección no nula

SELECT COUNT(email)
FROM client;


-- 16. Contar los clientes con facturas

SELECT COUNT(DISTINCT client_id)
FROM invoice;

-- 17. Contar número de ciudades donde tenemos clientes

SELECT COUNT(DISTINCT city)
FROM client;

-- 18. El primer y el último nombre de cliente por orden alfabético

SELECT MIN(name), MAX(name) 
FROM client;

-- 19. El precio más barato, el más caro, y el promedio

SELECT MIN(price), MAX(price), AVG(price)
FROM product;

-- 20. Suma del importe, el IVA (10%) y el total de la factura 20190001

SELECT SUM(price*units) AS import,
SUM(ROUND(price*units*0.10,2) )AS iva, 
SUM(ROUND(price*units*1.10,2) )AS total
FROM item_product
WHERE invoice_id=20190001;

-- 21. Suma del importe, el IVA y el total de las facturas del día 12

SELECT SUM(ip.price*ip.units) AS import, 
SUM(ROUND(ip.price*ip.units*0.21,2) )AS iva, 
SUM(ROUND(ip.price*ip.units*1.21,2) )AS total
FROM invoice i, item_product ip
WHERE i.invoice_id=ip.invoice_id
AND i.invoice_date LIKE "%-%-12"

-- 22. Para todos los ítems de productos, precio de venta, precio de catálogo
-- y descuento en % que se ha aplicado

SELECT *, (p.price-ip.price)/p.price*100 AS discount
FROM item_product ip, product p 
WHERE ip.product_id=p.product_id;  

-- 23. Para cada identificador de cliente, número de ítems de
-- productos y suma de importe

SELECT i.client_id, COUNT(*), SUM(ip.price*ip.units) AS sum_import
FROM invoice i, item_product ip
WHERE i.invoice_id=ip.invoice_id
GROUP BY i.client_id;

-- 24. Añadir a lo anterior el número de facturas

SELECT i.client_id, COUNT(*) AS item, SUM(ip.price*ip.units) AS sum_import, COUNT(DISTINCT i.invoice_id) AS invoice
FROM invoice i, item_product ip
WHERE i.invoice_id=ip.invoice_id
GROUP BY i.client_id;

-- 25. Añadir a lo anterior todos los datos del cliente

SELECT  c.*,
 COUNT(*) AS item, SUM(ip.price*ip.units) AS sum_import, 
 COUNT(DISTINCT i.invoice_id) AS invoice
FROM client c, invoice i, item_product ip
WHERE c.client_id=i.client_id AND i.invoice_id=ip.invoice_id
GROUP BY i.client_id, c.cif, c.name, c.email, c.phone_number, c.address, c.city;

-- 26. Para cada ciudad, número de clientes

SELECT city, COUNT(*) AS num_client
FROM client
GROUP BY city;

-- 27. Añadir a lo anterior el número de facturas
-- Ojo: Los clientes sin facturas no aparecen

SELECT city, COUNT(*) AS num_fac, 
COUNT(DISTINCT c.client_id) AS num_cli
FROM client c, invoice i 
WHERE c.client_id=i.client_id
GROUP BY city;

-- 28. Para cada identificador de producto, número de facturas,
-- suma de cantidad y suma de importe

SELECT product_id, COUNT(*) AS num_fac, 
SUM(units)AS sum_units, SUM(price*units) AS sum_imp
FROM item_product 
GROUP BY product_id;

-- 29. Añadir a lo anterior el nombre del producto

SELECT ip.product_id, p.description, COUNT(*) AS num_fac, 
SUM(ip.units) AS sum_units,
SUM(ip.price*ip.units) AS sum_imp
FROM item_product ip, product p 
WHERE ip.product_id=p.product_id
GROUP BY ip.product_id, p.description;

-- 30. Para cada mecánico, todos sus datos, número de ítems
-- y suma de horas

SELECT w.*, COUNT(*) AS num_items,
SUM(iw.hours) AS sum_hours
FROM item_work iw, worker w 
WHERE iw.worker_id=w.worker_id
GROUP BY w.worker_id, w.cif, w.name, w.phone_number;

-- 31. Añadir a lo anterior la suma de importe

SELECT w.*, COUNT(*) AS num_items,
SUM(iw.hours) AS sum_hours,
SUM(iw.hours*i.price_hour) AS sum_import
FROM invoice i, item_work iw, worker w 
WHERE i.invoice_id=iw.invoice_id AND iw.worker_id=w.worker_id
GROUP BY w.worker_id, w.cif, w.name, w.phone_number;

-- 32. Para cada vehículo, todos los datos de sus ítems
-- de productos con importe e iva

SELECT v.*, ip.*,ip.units*ip.price AS import, 
ip.units*ip.price*0.21 AS vat
FROM vehicle v, invoice i , item_product ip 
WHERE v.vehicle_id=i.vehicle_id 
AND i.invoice_id=ip.invoice_id;

-- 33. Para cada vehículo, todos los datos de sus ítems
-- de mano de obra con importe e iva

SELECT v.*, iw.*,iw.hours*i.price_hour AS import, 
iw.hours*i.price_hour*0.21 AS vat
FROM vehicle v, invoice i , item_work iw 
WHERE v.vehicle_id=i.vehicle_id 
AND i.invoice_id=iw.invoice_id;

-- 34. Para cada producto, su identificador, número de ítems,
-- suma de unidades y suma de importe

SELECT product_id, COUNT(*) AS items, SUM(units) AS sum_units, SUM(units*price) AS import
FROM item_product
GROUP BY product_id;

-- 35. Añadir a lo anterior la descripción del producto

SELECT ip.product_id, p.description, 
COUNT(*) AS items, SUM(ip.units) AS sum_units, SUM(ip.units*ip.price) AS import
FROM item_product ip, product p 
WHERE ip.product_id=p.product_id
GROUP BY ip.product_id, p.description;

-- 36. Para cada servidor de correo, número de clientes y número de facturas
-- Ojo: los clientes sin facturas no aparecen. No entra en EXAMEN

SELECT SUBSTR(email,LOCATE('@',email)+1,30),
COUNT(DISTINCT c.client_id) AS num_client,
COUNT(*) AS num_invoices
FROM client c, invoice i 
WHERE c.client_id=i.client_id
GROUP BY SUBSTR(email,LOCATE('@',email)+1,30);

-- 37. Para cada marca de coche, número de facturas

SELECT v.brand, COUNT(*)
FROM vehicle v, invoice i 
WHERE v.vehicle_id=i.vehicle_id
GROUP BY v.brand;

-- 38. Para cada identificador de mecánico, número de vehículos
-- distintos, de modelos distintos y de marcas distintas 
-- en los que ha trabajado

SELECT iw.worker_id, 
COUNT(DISTINCT v.vehicle_id) AS num_vehicle, 
COUNT(DISTINCT v.model) AS num_model,
COUNT(DISTINCT v.brand) AS num_brand
FROM vehicle v, invoice i, item_work iw
WHERE v.vehicle_id=i.vehicle_id 
AND i.invoice_id=iw.invoice_id
GROUP BY iw.worker_id;

-- 39. Añadir a lo anterior todos los datos del mecánico

SELECT iw.worker_id, w.name, w.cif, w.phone_number, 
COUNT(DISTINCT v.vehicle_id) AS num_vehicle, 
COUNT(DISTINCT v.model) AS num_model,
COUNT(DISTINCT v.brand) AS num_brand
FROM vehicle v, invoice i, item_work iw, worker w
WHERE v.vehicle_id=i.vehicle_id 
AND i.invoice_id=iw.invoice_id
AND iw.worker_id=w.worker_id
GROUP BY iw.worker_id, w.name, w.cif, w.phone_number;

-- 40. Para cada año, suma de importe de productos

SELECT YEAR(i.invoice_date), SUM(units*price)
FROM invoice i, item_product ip 
WHERE i.invoice_id=ip.invoice_id
GROUP BY YEAR(i.invoice_date);

-- 41. Para cada mes de cada año, suma de importe de productos

SELECT YEAR(i.invoice_date), MONTH(i.invoice_date), SUM(units*price)
FROM invoice i, item_product ip 
WHERE i.invoice_id=ip.invoice_id
GROUP BY YEAR(i.invoice_date), MONTH(i.invoice_date);

-- 42. Para cada año, suma de importe de mano de obra

SELECT YEAR(i.invoice_date), SUM(iw.hours*i.price_hour)
FROM invoice i, item_work iw 
WHERE i.invoice_id=iw.invoice_id
GROUP BY YEAR(i.invoice_date);

-- 43. Para cada mes de cada año, suma de importe de mano de obra

SELECT YEAR(i.invoice_date), MONTH(i.invoice_date), SUM(iw.hours*i.price_hour)
FROM invoice i, item_work iw 
WHERE i.invoice_id=iw.invoice_id
GROUP BY YEAR(i.invoice_date), MONTH(i.invoice_date);

-- 44. Todos los datos de facturas (sin duplicados) que tengan
-- ítems tanto de productos como de mano de obra

SELECT DISTINCT i.*
FROM invoice i, item_product ip, item_work iw
WHERE i.invoice_id=ip.invoice_id
AND i.invoice_id=iw.invoice_id;

-- 45. Todos los datos de mecánicos con trabajos en 
-- vehiculos de marca Renault

SELECT DISTINCT w.*, v.brand
FROM vehicle v, invoice i, item_work iw, worker w
WHERE v.vehicle_id=i.vehicle_id 
AND i.invoice_id=iw.invoice_id 
AND iw.worker_id=w.worker_id
AND v.brand="Renault"

-- 46. Suma de importe de piezas, iva incluido, de la factura
-- con identificador 20200006. Si no hay ítem, que salga cero. 
-- Las funciones SUM, MAX, MIN y AVG devuelven NULL si no hay datos.
-- La función COUNT devuelve 0 si no hay datos.
-- La función IFNULL tiene dos parámetros:
-- -- La expresión que se va a evaluar si es nula o no. 
-- -- El valor que devuelve si el primer parámetro es NULL.

SELECT IFNULL(SUM(ROUND(units*price*1.21,2)),0)
FROM item_product
WHERE invoice_id=20200006;

SELECT IFNULL(SUM(ROUND(units*price*1.21,2)),0)
FROM item_product
WHERE invoice_id=20200016;

-- 47. Suma de importe de reparaciones, iva incluido, de la factura
-- con identificador 20200006. Si no hay item, que salga cero.

SELECT IFNULL(SUM(ROUND(i.price_hour*iw.hours*1.21,2)),0)
FROM invoice i, item_work iw
WHERE i.invoice_id=iw.invoice_id
AND i.invoice_id=20200006;

-- 48. Tdos los datos de clientes con asteristos en los emails nulos. 

SELECT client_id, cif, name, phone_number, address, city, IFNULL(email,"**********")
FROM client;
