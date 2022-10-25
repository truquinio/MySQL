/*
Abrir el script de la base de datos llamada “jardineria.sql” y ejecutarlo para crear todas las 
tablas e insertar datos en las mismas. Deberá obtener un diagrama de entidad relación igual al 
que se muestra a continuación:

A continuación, se deben realizar las siguientes consultas sobre la base de datos: 
*/
USE jardineria;
SELECT * FROM cliente;
SELECT * FROM detalle_pedido;
SELECT * FROM empleado;
SELECT * FROM gama_producto;
SELECT * FROM oficina;
SELECT * FROM pago;
SELECT * FROM pedido;
SELECT * FROM producto;

#	Consultas sobre una tabla
#	1.   Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
SELECT codigo_oficina, ciudad
FROM oficina;

#	2.	Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
SELECT ciudad, telefono, pais
FROM oficina
WHERE pais LIKE 'España';

#	3.   Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
SELECT nombre, apellido1, apellido2, email, codigo_jefe
FROM empleado
WHERE codigo_jefe = 7;

#	4.   Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
SELECT puesto, nombre, apellido1, apellido2, email, codigo_jefe
FROM empleado
WHERE codigo_jefe IS NULL;

#	OTRA FORMA:
SELECT puesto, nombre, apellido1, apellido2, email, codigo_jefe
FROM empleado
WHERE puesto LIKE 'Director General';

#	5.   Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
SELECT nombre, apellido1, apellido2, puesto
FROM empleado
WHERE puesto != 'Representante Ventas';

#	Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que sean representantes de ventas.
SELECT nombre, apellido1, apellido2, puesto
FROM empleado
WHERE puesto = 'Representante Ventas';

#	6.   Devuelve un listado con el nombre de los todos los clientes españoles.
SELECT nombre_cliente, pais
FROM cliente
WHERE pais = 'Spain';

#	7.   Devuelve un listado con los distintos estados por los que puede pasar un pedido.
SELECT distinct(estado) FROM pedido;

#	8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008.
#	Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. 
#	Resuelva la consulta:

#	Utilizando la función YEAR de MySQL.
SELECT distinct(codigo_cliente), fecha_pago
FROM pago
WHERE YEAR(fecha_pago) = 2008;

#	Utilizando la función DATE_FORMAT de MySQL. 
SELECT distinct(codigo_cliente), fecha_pago
FROM pago
WHERE DATE_FORMAT(fecha_pago, "%Y") = 2008;

#	Sin utilizar ninguna de las funciones anteriores.
SELECT distinct(codigo_cliente), fecha_pago
FROM pago
WHERE LEFT(fecha_pago, 4) = 2008;

#	9.   Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos 
#	que no han sido entregados a tiempo. 
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega > fecha_esperada;

#	10.	Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de 
#	entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha 
#	esperada.

#	Utilizando la función ADDDATE de MySQL.	(FUNCIONA CON DÍAS, MESES, AÑOS...)
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE adddate(fecha_entrega, interval 2 day) <= fecha_esperada;

#	Utilizando la función DATEDIFF de MySQL. (SÓLO FUNCIONA CON DÍAS)
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE datediff(fecha_entrega, fecha_esperada) >= 2;

#	11.   Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
SELECT * FROM pedido
WHERE estado LIKE 'Rechazado' AND year(fecha_pedido) = 2009;

#	12.  Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
SELECT * FROM pedido
WHERE estado LIKE 'Entregado' AND month(fecha_entrega) = 01;

#	13.  Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. 
#	Ordene el resultado de mayor a menor.
SELECT * FROM pago
WHERE forma_pago LIKE 'Paypal' AND year(fecha_pago) = 2008;

#	14.  Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en 
#	cuenta que no deben aparecer formas de pago repetidas.
SELECT distinct forma_pago FROM pago;

#	15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que 
#	tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de 
#	venta, mostrando en primer lugar los de mayor precio.
SELECT nombre, gama, cantidad_en_stock, precio_venta
FROM producto
WHERE gama LIKE 'Ornamentales' AND cantidad_en_stock > 100
ORDER BY precio_venta DESC;

#	16.  Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo 
#	representante de ventas tenga el código de empleado 11 o 30.
SELECT nombre_cliente, ciudad, codigo_empleado_rep_ventas FROM cliente
WHERE ciudad LIKE 'Madrid' 
AND codigo_empleado_rep_ventas IN (11, 30);

#	OTRA FORMA:
SELECT nombre_cliente, ciudad, codigo_empleado_rep_ventas FROM cliente
WHERE ciudad LIKE 'Madrid' 
AND (codigo_empleado_rep_ventas = 11 OR codigo_empleado_rep_ventas = 30);

#	Consultas multitabla (Composición interna) Las consultas se deben resolver con INNER JOIN.
#	1.    Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
SELECT cli.nombre_cliente, concat(empl.nombre, ' ', empl.apellido1, ' ', empl.apellido2) AS 'Vendedor', empl.puesto
FROM cliente AS cli
INNER JOIN empleado AS empl
ON cli.codigo_empleado_rep_ventas = empl.codigo_empleado
WHERE empl.puesto = 'Representante Ventas';

#	2.   Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
SELECT distinct cli.codigo_cliente, cli.nombre_cliente, concat(empl.nombre, ' ', 
empl.apellido1, ' ', empl.apellido2) AS 'Vendedor', empl.puesto, pago.forma_pago
FROM cliente AS cli
INNER JOIN empleado AS empl
ON cli.codigo_empleado_rep_ventas = empl.codigo_empleado
INNER JOIN pago
ON cli.codigo_cliente = pago.codigo_cliente
WHERE empl.puesto = 'Representante Ventas'
ORDER BY cli.codigo_cliente;

#	3.   Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de 
#	sus representantes de ventas.
SELECT distinct cli.codigo_cliente, cli.nombre_cliente, concat(empl.nombre, ' ', 
empl.apellido1, ' ', empl.apellido2) AS 'Vendedor', empl.puesto
FROM cliente AS cli
INNER JOIN empleado AS empl
ON cli.codigo_empleado_rep_ventas = empl.codigo_empleado
WHERE empl.puesto = 'Representante Ventas' AND cli.codigo_cliente NOT IN (SELECT pago.codigo_cliente FROM pago)
ORDER BY cli.codigo_cliente;

#	4.   Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes 
#	junto con la ciudad de la oficina a la que pertenece el representante.
SELECT distinct cli.codigo_cliente, cli.nombre_cliente, concat(empl.nombre, ' ', 
empl.apellido1, ' ', empl.apellido2) AS 'Vendedor', empl.puesto, pago.forma_pago, ofi.ciudad
FROM cliente AS cli
INNER JOIN empleado AS empl
ON cli.codigo_empleado_rep_ventas = empl.codigo_empleado
INNER JOIN pago
ON cli.codigo_cliente = pago.codigo_cliente
INNER JOIN oficina AS ofi
ON empl.codigo_oficina = ofi.codigo_oficina
WHERE empl.puesto = 'Representante Ventas'
ORDER BY cli.codigo_cliente;

#	5.   Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus 
#	representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT distinct cli.codigo_cliente, cli.nombre_cliente, concat(empl.nombre, ' ', 
empl.apellido1, ' ', empl.apellido2) AS 'Vendedor', empl.puesto, ofi.ciudad
FROM cliente AS cli
INNER JOIN empleado AS empl
ON cli.codigo_empleado_rep_ventas = empl.codigo_empleado
INNER JOIN oficina AS ofi
ON empl.codigo_oficina = ofi.codigo_oficina
WHERE empl.puesto = 'Representante Ventas' AND cli.codigo_cliente NOT IN (SELECT pago.codigo_cliente FROM pago)
ORDER BY cli.codigo_cliente;

#	6.   Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
SELECT distinct cli.codigo_cliente, cli.ciudad AS 'Ciudad Cliente', cli.nombre_cliente, 
concat(ofi.linea_direccion1,'. ', ofi.linea_direccion2) AS 'Dirección Oficina', 
ofi.ciudad AS 'Ciudad Oficina'
FROM cliente AS cli
INNER JOIN empleado AS empl
ON cli.codigo_empleado_rep_ventas = empl.codigo_empleado
INNER JOIN oficina as ofi
ON empl.codigo_oficina = ofi.codigo_oficina
WHERE cli.ciudad = 'Fuenlabrada';

#	7.   Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad 
#	de la oficina a la que pertenece el representante.
SELECT distinct cli.codigo_cliente, cli.ciudad AS 'Ciudad Cliente', cli.nombre_cliente, 
concat(ofi.linea_direccion1,'. ', ofi.linea_direccion2) AS 'Dirección Oficina', 
ofi.ciudad AS 'Ciudad Oficina'
FROM cliente AS cli
INNER JOIN empleado AS empl
ON cli.codigo_empleado_rep_ventas = empl.codigo_empleado
INNER JOIN oficina as ofi
ON empl.codigo_oficina = ofi.codigo_oficina;

#	8.   Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
SELECT nombre, apellido1, apellido2



/*


9.   Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
10.  Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
Consultas multitabla (Composición externa)
Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, JOIN.
1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
2.   Devuelve un listado que muestre solamente los clientes que no han realizado ningún 
pedido.
3.   Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que 
no han realizado ningún pedido.
4.   Devuelve un listado que muestre solamente los empleados que no tienen una oficina 
asociada.
5.   Devuelve un listado que muestre solamente los empleados que no tienen un cliente 
asociado.
6.   Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los 
que no tienen un cliente asociado.
7.   Devuelve un listado de los productos que nunca han aparecido en un pedido.
8. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los 
representantes de ventas de algún cliente que haya realizado la compra de algún producto 
de la gama Frutales.
9.   Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado 
ningún pago.
10.  Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el 
nombre de su jefe asociado.
Consultas resumen
1.    ¿Cuántos empleados hay en la compañía?
2.   ¿Cuántos clientes tiene cada país?
3.   ¿Cuál fue el pago medio en 2009?
4.   ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el 
número de pedidos.
5.   Calcula el precio de venta del producto más caro y más barato en una misma consulta.
6.   Calcula el número de clientes que tiene la empresa.
7.   ¿Cuántos clientes tiene la ciudad de Madrid?
8.   ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
9.   Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende 
cada uno.
10.  Calcula el número de clientes que no tiene asignado representante de ventas.
11.   Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado 
deberá mostrar el nombre y los apellidos de cada cliente.
12.  Calcula el número de productos diferentes que hay en cada uno de los pedidos.
13.  Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de 
los pedidos.
14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que 
se han vendido de cada uno. El listado deberá estar ordenado por el número total de 
unidades vendidas.
15. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el 
IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el 
número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base 
imponible, y el total la suma de los dos campos anteriores.
16. La misma información que en la pregunta anterior, pero agrupada por código de producto.
17.  La misma información que en la pregunta anterior, pero agrupada por código de producto 
filtrada por los códigos que empiecen por OR.
18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se 
mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% 
IVA)
Subconsultas con operadores básicos de comparación
1.    Devuelve el nombre del cliente con mayor límite de crédito.
2.   Devuelve el nombre del producto que tenga el precio de venta más caro.
3. Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta 
que tendrá que calcular cuál es el número total de unidades que se han vendido de cada 
producto a partir de los datos de la tabla detalle_pedido. Una vez que sepa cuál es el código 
del producto, puede obtener su nombre fácilmente.)
4.   Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar 
INNER JOIN).
5.   Devuelve el producto que más unidades tiene en stock.
6.   Devuelve el producto que menos unidades tiene en stock.
7.   Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto 
Soria.
Subconsultas con ALL y ANY
1.    Devuelve el nombre del cliente con mayor límite de crédito.
2.   Devuelve el nombre del producto que tenga el precio de venta más caro.
3.   Devuelve el producto que menos unidades tiene en stock.
Subconsultas con IN y NOT IN
1.    Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún 
cliente.
2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
3. Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.
4.   Devuelve un listado de los productos que nunca han aparecido en un pedido.
5.   Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que 
no sean representante de ventas de ningún cliente.
Subconsultas con EXISTS y NOT EXISTS
1.    Devuelve un listado que muestre solamente los clientes que no han realizado ningún 
pago.
2. Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.
3.   Devuelve un listado de los productos que nunca han aparecido en un pedido.
4.   Devuelve un listado de los productos que han aparecido en un pedido alguna vez.
*/