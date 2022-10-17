/*
MANOS A LA OBRA 6:
	a)   Ahora veamos cómo ha quedado la tabla “superheroes” que creaste anteriormente. 
Para ello necesitarás una consulta de tipo SELECT.
*/
USE superheroe;

#	Muestro todas las tablas:
SELECT * FROM creador;
SELECT * FROM personaje;

#	b)   Realiza una consulta que devuelva todos los valores de la columna “nombre_real” de la tabla superhéroe.
SELECT nombre_real FROM personaje;

#	c)   Realiza una consulta que devuelva todos los nombres reales de los personajes cuyo nombre empieza con “B”
SELECT nombre_real FROM personaje WHERE nombre_real LIKE 'B%';

#	c)   Realiza una consulta que devuelva todos los personajes que empiecen con “T”
SELECT personaje FROM personaje WHERE personaje LIKE 'T%';