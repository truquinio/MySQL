/*
MANOS A LA OBRA 7:
Pongamos a prueba esta nueva cláusula: ORDER BY: Seguiremos trabajando con la tabla “superhéroe”.
*/
USE superheroe;

#	Muestro todas las tablas:
SELECT * FROM creador;
SELECT * FROM personaje;

#	Realiza una consulta que devuelva todos los registros ordenados por “inteligencia” ASCENDENTE:
SELECT * FROM personaje ORDER BY inteligencia ASC;

#	Realiza una consulta que devuelva todos los registros ordenados por “inteligencia” DESCENDENTE:
SELECT * FROM personaje ORDER BY inteligencia DESC;