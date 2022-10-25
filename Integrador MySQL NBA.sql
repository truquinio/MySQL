/*
Llegó el momento de poner a prueba nuestros conocimientos de bases de datos, para ello nos 
han propuesto el siguiente desafío:

Tenemos que adivinar la clave y posición de una caja fuerte. El cerrojo consta de 4 candados, 
cada candado tiene de clave, un número que puede ser de más de 1 cifra y una posición que 
puede ir desde 1 a 4.

Nosotros tenemos los 4 candados en la mano (Candado A, Candado B, Candado C y Candado D) 
debemos averiguar la posición de cada candado y la clave del mismo.

1- Abrir el script de la base de datos llamada “nba.sql”, que se encuentra en el drive y ejecutarlo 
para crear todas las tablas e insertar datos en las mismas. Deberá obtener el siguiente diagrama 
de relación:
*/

USE nba;

SELECT * FROM equipo;
SELECT * FROM estadistica;
SELECT * FROM jugador;
SELECT * FROM partido;

/*
CANDADO A:

Posición:  El candado A está ubicado en la posición calculada a partir del número obtenido en la/s 
siguiente/s consulta/s:
Teniendo el máximo de asistencias por partido, muestre cuantas veces se logró dicho máximo. 
Este resultado nos dará la posición del candado (1, 2, 3 o 4)
Clave:  La clave del candado A estará con formada por la/s siguientes consulta/s a la base de 
datos:
Muestre la suma total del peso de los jugadores, donde la conferencia sea Este y la posición sea 
centro o esté comprendida en otras posiciones.
*/
SELECT count(*)
FROM estadistica
WHERE Asistencia_por_partido = (SELECT max(Asistencias_por_partido) FROM estadistica);

SELECT sum(j.peso)
FROM jugador AS j
INNER JOIN equipo AS e
ON j.nombre_equipo = e.nombre
WHERE e.conferencia LIKE 'East' AND j.posicion LIKE '%C%';

#	Posición Candado A: 2
#	Clave candado A: 14043

/*
CANDADO B:

Posición:  El candado B está ubicado en la posición calculada a partir del número obtenido en la/s 
siguiente/s consulta/s:
Muestre la cantidad de jugadores que poseen más asistencias por partidos, que el numero de 
jugadores que tiene el equipo Heat. 
Este resultado nos dará la posición del candado (1, 2, 3 o 4)
Clave:  La clave del candado B estará con formada por la/s siguientes consulta/s a la base de 
datos:
La clave será igual al conteo de partidos jugados durante las temporadas del año 1999.
*/
SELECT * FROM jugador;
SELECT * FROM estadistica;
SELECT count(*) FROM jugador WHERE nombre_equipo LIKE '%Heat%';

SELECT count(*)
FROM estadistica
WHERE Asistencias_por_partido > (SELECT count(*) FROM jugador WHERE nombre_equipo LIKE '%Heat%');

SELECT count(*)
FROM partido
WHERE temporada LIKE '%99%';


#	Posición Candado B: 3
#	Clave candado B: 3480

/*
CANDADO C:

Posición:  El candado C está ubicado en la posición calculada a partir del número obtenido en la/s 
siguiente/s consulta/s:
La posición del código será igual a la cantidad de jugadores que proceden de Michigan y forman 
parte de equipos de la conferencia oeste. 
Al resultado obtenido lo dividiremos por la cantidad de jugadores cuyo peso es mayor o igual a 
195, y a eso le vamos a sumar 0.9945.
Este resultado nos dará la posición del candado (1, 2, 3 o 4)
Clave:  La clave del candado C estará con formada por la/s siguientes consulta/s a la base de 
datos:
Para obtener el siguiente código deberás redondear hacia abajo el resultado que se devuelve de 
sumar: el promedio de puntos por partido, el conteo de asistencias por partido, y la suma de 
tapones por partido. Además, este resultado debe ser, donde la división sea central.
*/
SELECT count(*) 
FROM jugador AS j
INNER JOIN equipo AS e
ON j.nombre_equipo = e.nombre
WHERE j.procedencia LIKE '%Michigan%' AND e.conferencia LIKE '%West%';

SELECT count(*)
FROM jugador
WHERE peso >= 195;

SELECT avg(Puntos_por_partido)
FROM estadistica;

SELECT count(Asistencias_por_partido)
FROM estadistica;

SELECT sum(Tapones_por_partido)
FROM estadistica;

SELECT round((avg(e.Puntos_por_partido) + count(e.Asistencias_por_partido) + sum(e.Tapones_por_partido)))
FROM estadistica AS e
INNER JOIN jugador AS j
ON e.jugador = j.codigo
INNER JOIN equipo AS eqp
ON j.nombre_equipo = eqp.nombre
WHERE eqp.division LIKE '%Central%';

#	Posición Candado C: 1
#	Clave candado C: 631

/*
CANDADO D
Posición:    El candado D está ubicado en la posición calculada a partir del número obtenido en la/s 
siguiente/s consulta/s: 
Muestre los tapones por partido del jugador Corey Maggette durante la temporada 00/01. Este 
resultado debe ser redondeado. Nota:  el resultado debe estar redondeado
Este resultado nos dará la posición del candado (1, 2, 3 o 4)
Clave:  La clave del candado D estará con formada por la/s siguientes consulta/s a la base de 
datos: 
Para obtener el siguiente código deberás redondear hacia abajo, la suma de puntos por partido 
de todos los jugadores de procedencia argentina.
*/
SELECT sum(e.Tapones_por_partido)
FROM estadistica AS e
INNER JOIN jugador AS j
ON e.jugador = j.codigo
WHERE j.nombre LIKE '%Corey Maggette%' AND e.temporada LIKE '%00/01%';

SELECT round(sum(e.Puntos_por_partido))
FROM estadistica as e
INNER JOIN jugador as j
ON e.jugador = j.codigo
WHERE j.procedencia = "Argentina";

#	Posición Candado D: 4
#	Clave candado D: 191
