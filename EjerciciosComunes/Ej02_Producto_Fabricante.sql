/*
Abrir el script de la base de datos llamada “tienda.sql” y ejecutarlo para crear sus tablas e 
insertar datos en las mismas. A continuación, generar el modelo de entidad relación. Deberá 
obtener un diagrama de entidad relación igual al que se muestra a continuación: 

Fabricante ||--------|< Producto

A continuación, se deben realizar las siguientes consultas sobre la base de datos:
*/

USE tienda;
SELECT * FROM fabricante;
SELECT * FROM producto;

#	1.   Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre FROM producto;

#	2.   Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre, precio FROM producto;

#	3.   Lista todas las columnas de la tabla producto.
SELECT * FROM producto;

#	OTRA FORMA: (Mostrando las columnas)
SHOW columns FROM producto;

#	4.   Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
SELECT nombre, round(precio) FROM producto;

#	5.   Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT codigo_fabricante FROM producto;

#	6.   Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar los repetidos.
SELECT distinct codigo_fabricante FROM producto;

#	7.   Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre FROM fabricante ORDER BY nombre ASC;

#	8.   Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en 
#	segundo lugar por el precio de forma descendente.
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;

#	9.   Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT * FROM fabricante LIMIT 5;

#	 OTRA FORMA:
SELECT * FROM fabricante WHERE codigo BETWEEN 1 AND 5;

#	10.  Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1; 

#	 OTRA FORMA:
SELECT nombre, min(precio) FROM producto; 

#	11.   Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1; 

#	 OTRA FORMA:
SELECT nombre, max(precio) FROM producto;

#	12.  Lista el nombre de los productos que tienen un precio menor o igual a $120.
SELECT nombre, precio FROM producto WHERE precio <= 120;

#	13.  Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN.
SELECT * FROM producto WHERE precio BETWEEN 60 AND 200;

#	14.  Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT * FROM producto WHERE codigo_fabricante IN (1,3,5);

#	OTRA FORMA:
SELECT * FROM producto WHERE codigo_fabricante = 1 OR codigo_fabricante = 3 OR codigo_fabricante = 5;

#	15.  Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
SELECT nombre FROM producto WHERE nombre LIKE '%Portátil%';

#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#	MULTITABLA:

#	1.    Devuelve una lista con el código del producto, nombre del producto, código del fabricante y 
#	nombre del fabricante, de todos los productos de la base de datos.
SELECT producto.codigo, producto.nombre, producto.codigo_fabricante, fabricante.nombre
FROM producto 
INNER JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo;

#	OTRA FORMA:
SELECT prod.codigo AS 'Código prod.', prod.nombre, prod.codigo_fabricante, fabr.nombre
FROM producto AS prod
INNER JOIN fabricante AS fabr
ON prod.codigo_fabricante = fabr.codigo;

#	2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base 
#	de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto 
INNER JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo
ORDER BY fabricante.nombre;

#	OTRA FORMA:
SELECT prod.nombre, prod.precio, fabr.nombre
FROM producto AS prod
INNER JOIN fabricante AS fabr
ON prod.codigo_fabricante = fabr.codigo
ORDER BY fabr.nombre;

#	3.   Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato. 
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto 
INNER JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo
ORDER BY precio
LIMIT 1;

#	FORMA 2:
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto 
INNER JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo
HAVING producto.precio = (SELECT min(precio) FROM producto);

#	OTRA FORMA:
SELECT prod.nombre, prod.precio, fabr.nombre
FROM producto AS prod
INNER JOIN fabricante AS fabr
ON prod.codigo_fabricante = fabr.codigo
HAVING prod.precio = (SELECT min(precio) FROM producto);

#	FORMA 2:
SELECT prod.nombre, prod.precio, fabr.nombre
FROM producto AS prod
INNER JOIN fabricante AS fabr
ON prod.codigo_fabricante = fabr.codigo
ORDER BY prod.precio
LIMIT 1;

#	4.   Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT *
FROM producto
INNER JOIN  fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE 'Lenovo';

#	OTRA FORMA:
SELECT *
FROM producto AS prod
INNER JOIN  fabricante AS fabr
ON prod.codigo_fabricante = fabr.codigo
WHERE fabr.nombre LIKE 'Lenovo';

#	5.   Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
SELECT *
FROM producto
INNER JOIN  fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE 'Crucial' AND producto.precio > 200;

#	OTRA FORMA:
SELECT *
FROM producto AS prod
INNER JOIN  fabricante AS fabr
ON prod.codigo_fabricante = fabr.codigo
WHERE fabr.nombre LIKE 'Crucial' AND prod.precio > 200;

#	6.   Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard. 
#	Utilizando el operador IN.
SELECT *
FROM producto AS prod
INNER JOIN  fabricante AS fabr
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre IN ('Asus');

#	OTRA FORMA:
SELECT *
FROM producto AS prod
INNER JOIN  fabricante AS fabr
ON prod.codigo_fabricante = fabr.codigo
WHERE fabr.nombre IN ('Asus');

#	7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos 
#	los productos que tengan un precio mayor o igual a $180. Ordene el resultado en primer 
#	lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
SELECT prod.nombre, prod.precio, fabr.nombre
FROM producto AS prod
INNER JOIN fabricante AS fabr
ON prod.codigo_fabricante = fabr.codigo
WHERE prod.precio >= 180
ORDER BY prod.precio DESC, prod.nombre;

#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#	LEFT JOIN y RIGHT JOIN:

#	1.    Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los 
#	productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos 
#	fabricantes que no tienen productos asociados.
SELECT *
FROM fabricante as fabr
LEFT JOIN producto as prod
ON fabr.codigo = prod.codigo_fabricante;

#	OTRA FORMA:
SELECT *
FROM producto as prod
RIGHT JOIN fabricante as fabr
ON fabr.codigo = prod.codigo_fabricante;

#	2.   Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT *
FROM producto as prod
RIGHT JOIN fabricante AS fabr
ON fabr.codigo = prod.codigo_fabricante
WHERE prod.nombre IS NULL;

#	OTRA FORMA:
SELECT *
FROM fabricante as fabr
LEFT JOIN producto AS prod
ON fabr.codigo = prod.codigo_fabricante
WHERE prod.nombre IS NULL;

#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#	Subconsultas (En la cláusula WHERE) 
#	Con operadores básicos de comparación

#	1.    Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT *
FROM producto
WHERE codigo_fabricante = (SELECT codigo 
			   FROM fabricante 
			   WHERE nombre 
			   LIKE 'Lenovo');

#	2.   Devuelve todos los datos de los productos que tienen el mismo precio que el producto 
#	más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT codigo FROM fabricante WHERE nombre LIKE 'Lenovo';		#	Busco el código del fabricante Lenovo.
SELECT max(precio) FROM producto WHERE codigo_fabricante = 2;	#	Busco el precio máximo de Lenovo.

#	 Resuelvo:
SELECT *
FROM producto
WHERE precio = (SELECT max(precio) 
		FROM producto
		WHERE codigo_fabricante = (SELECT codigo
					   FROM fabricante
					   WHERE nombre LIKE 'Lenovo'));

#	3.   Lista el nombre del producto más caro del fabricante Lenovo.
SELECT nombre
FROM producto
WHERE precio = (SELECT max(precio)
		FROM producto
		WHERE codigo_fabricante = (SELECT codigo
					   FROM fabricante
					   WHERE nombre LIKE 'Lenovo'))
AND codigo_fabricante = (SELECT codigo
			 FROM fabricante
			 WHERE nombre LIKE 'Lenovo');	#	Le digo que si o si me muestre fabricante Lenovo.

#	4.   Lista todos los productos del fabricante Asus que tienen un precio superior al 
#	precio medio de todos sus productos.

#	Muestro todos los productos de Asus.
SELECT * FROM producto WHERE codigo_fabricante = 1;

#	Calculo el precio promedio de productos Asus.
SELECT avg(precio) FROM producto WHERE codigo_fabricante = 1;

#	Resuelvo:
SELECT *
FROM producto
WHERE codigo_fabricante = (SELECT codigo
			   FROM fabricante
			   WHERE nombre LIKE 'Asus')
AND precio > (SELECT avg(precio)
	      FROM producto
	      WHERE codigo_fabricante = (SELECT codigo
					 FROM fabricante
					 WHERE nombre LIKE 'Asus'));

#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#	Subconsultas con IN y NOT IN
#	1.    Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre
FROM fabricante
WHERE codigo IN (SELECT distinct(codigo_fabricante)
				FROM producto);

#	2.   Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre
FROM fabricante
WHERE codigo NOT IN (SELECT distinct(codigo_fabricante)
					FROM producto);

#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#	Subconsultas (En la cláusula HAVING)
#	1.    Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número 
#	de productos que el fabricante Lenovo.
SELECT nombre
FROM fabricante
WHERE codigo IN (SELECT codigo_fabricante
                FROM producto
                GROUP BY codigo_fabricante
                HAVING COUNT(*) = (SELECT COUNT(*)
                                    FROM producto AS prod
                                    INNER JOIN fabricante AS fabr
                                    ON prod.codigo_fabricante = fabr.codigo
                                    WHERE fabr.nombre = 'Lenovo'));