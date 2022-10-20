/*
Abrir el script de la base de datos llamada “nba.sql” y ejecutarlo para crear todas las tablas e 
insertar datos en las mismas. A continuación, generar el modelo de entidad relación. Deberá 
obtener un diagrama de entidad relación igual al que se muestra a continuación: 
A continuación, se deben realizar las siguientes consultas sobre la base de datos:
*/
USE nba;

SELECT * FROM equipo;
SELECT * FROM estadistica;
SELECT * FROM jugador;
SELECT * FROM partido;

#	1.    Mostrar el nombre de todos los jugadores ordenados alfabéticamente.
SELECT nombre AS 'Jugador' FROM jugador
ORDER BY nombre ASC;

#	2.   Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras, 
#	ordenados por nombre alfabéticamente.
SELECT nombre AS 'Jugador', peso, posicion FROM jugador
WHERE posicion LIKE 'C' AND peso > 200
ORDER BY nombre ASC;

#	3.   Mostrar el nombre de todos los equipos ordenados alfabéticamente.
SELECT nombre AS 'Equipo' FROM equipo
ORDER BY nombre ASC;

#	4.   Mostrar el nombre de los equipos del este (East).
SELECT nombre AS 'Equipo', conferencia FROM equipo
WHERE conferencia LIKE 'East';

#	5.   Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.
SELECT * FROM equipo
WHERE ciudad LIKE 'C%'
ORDER BY nombre;

#	6.   Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
SELECT nombre, nombre_equipo FROM jugador
ORDER BY nombre_equipo;

#	7.   Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.
SELECT nombre AS 'Jugador', nombre_equipo FROM jugador
WHERE nombre_equipo LIKE 'Raptors'
ORDER BY nombre ASC;

#	8.   Mostrar los puntos por partido del jugador ‘Pau Gasol’.
SELECT * FROM jugador WHERE nombre LIKE 'Pau Gasol';		#	Identifico al jugador Pau Gasol y su N° de jugador = 66

SELECT Puntos_por_partido FROM estadistica WHERE jugador = 66;	#	Identifico los Puntos x part del jugador 66

#	FORMA 1:
SELECT nombre AS 'Jugador', Puntos_por_partido, temporada
FROM estadistica estad, jugador jug
WHERE estad.jugador = jug.codigo 
AND lower(jug.nombre) = 'Pau Gasol';

#	 FORMA 2:
SELECT jugador.nombre, estadistica.Puntos_por_partido, estadistica.temporada
FROM jugador 
INNER JOIN estadistica 
ON jugador.codigo = estadistica.jugador
WHERE jugador.nombre = 'Pau Gasol';

#	FORMA 3:
SELECT jug.nombre, estad.Puntos_por_partido, estad.temporada
FROM jugador AS jug
INNER JOIN estadistica AS estad
ON jug.codigo = estad.jugador
WHERE jug.nombre = 'Pau Gasol';

#	9.   Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.
SELECT nombre AS 'Jugador', Puntos_por_partido, temporada
FROM estadistica estad, jugador jug
WHERE estad.jugador = jug.codigo 
AND lower(jug.nombre) = 'Pau Gasol'
AND estad.temporada LIKE '04/05';

#	FORMA 2:
SELECT jugador.nombre, estadistica.Puntos_por_partido, estadistica.temporada
FROM jugador 
INNER JOIN estadistica 
ON jugador.codigo = estadistica.jugador
WHERE jugador.nombre = 'Pau Gasol' 
AND estadistica.temporada LIKE '04/05';

#	FORMA 3:
SELECT jug.nombre, estad.Puntos_por_partido, estad.temporada
FROM jugador AS jug
INNER JOIN estadistica AS estad
ON jug.codigo = estad.jugador
WHERE jug.nombre = 'Pau Gasol'
AND estad.temporada LIKE '04/05';

#	10.  Mostrar el número de puntos de cada jugador en toda su carrera.
SELECT jug.codigo, jug.nombre, estad.Puntos_por_partido, estad.temporada
FROM jugador AS jug
INNER JOIN estadistica AS estad
ON jug.codigo = estad.jugador;

#	11.   Mostrar el número de jugadores de cada equipo.
SELECT jug.nombre_equipo AS 'Equipo', count(*) AS 'N° jugadores'
FROM jugador jug
GROUP BY jug.nombre_equipo;
 
#	FORMA 2:
SELECT eqp.nombre AS 'Equipo', count(*) AS 'N° jugadores'
FROM jugador jug, equipo eqp
WHERE jug.nombre_equipo = eqp.nombre 
GROUP BY eqp.nombre;

#	12.  Mostrar el jugador que más puntos ha realizado en toda su carrera.
SELECT distinct nombre
FROM jugador, estadistica
WHERE codigo = (SELECT jugador
                FROM estadistica
                GROUP BY jugador
                HAVING sum(Puntos_por_partido) = (SELECT max(sumas.Total)
                                                  FROM (SELECT sum(Puntos_por_partido) AS 'Total'
                                                        FROM estadistica
                                                        GROUP BY jugador) AS sumas));

#	FORMA 2:
SELECT suma.nombre, round(suma.puntos)
FROM (SELECT jug.nombre, sum(est.Puntos_por_partido) AS 'puntos'
      FROM jugador jug, estadistica est
      WHERE jug.codigo = est.jugador
      GROUP BY jug.nombre) suma
      
WHERE suma.puntos = (SELECT max(suma2.puntos) FROM (SELECT jug.nombre, sum(est.Puntos_por_partido) AS puntos
                                                    FROM jugador jug, estadistica est
                                                    WHERE jug.codigo = est.jugador
                                                    GROUP BY jug.nombre) suma2);

SELECT nombre AS 'Jugador', round(sum(Puntos_por_partido)) AS 'Puntos totales'								
FROM estadistica estad, jugador jug
WHERE estad.jugador = jug.codigo 
AND lower(jug.nombre) = 'Shaquille ONeal';

#	13.  Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.
SELECT jug.nombre AS 'jugador', jug.altura, eqp.nombre AS equipo, eqp.conferencia, eqp.division 
FROM equipo eqp, jugador jug
WHERE eqp.nombre = jug.nombre_equipo 
AND jug.altura = (SELECT max(altura) 
					FROM jugador);

#	14.  Mostrar la media de puntos en partidos de los equipos de la división Pacific.
SELECT part.equipo_local, AVG(part.puntos_local) as 'Media_de_puntos', eqp.division
FROM partido as part
INNER JOIN equipo as eqp
ON part.equipo_local = eqp.nombre
WHERE eqp.division = 'Pacific'
GROUP BY part.equipo_local;

#	15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor diferencia de puntos.
SELECT *
FROM partido
WHERE abs(puntos_local - puntos_visitante) = (SELECT max(abs(puntos_local - puntos_visitante)) FROM partido);

#	16.  Mostrar la media de puntos en partidos de los equipos de la división Pacific.
SELECT eqp.nombre, AVG(puntos_local) AS 'Promedio puntos', eqp.division
FROM partido as part
INNER JOIN equipo as eqp
ON part.equipo_local = eqp.nombre
WHERE eqp.division = 'Pacific'
GROUP BY eqp.nombre;

#	17.  Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante. 
SELECT equipo_local, puntos_local, equipo_visitante, puntos_visitante FROM partido;

#	18.  Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante, equipo_ganador), 
#	en caso de empate sera null.
SELECT codigo, equipo_local, equipo_visitante, IF(puntos_local>puntos_visitante, equipo_local, IF(puntos_local<puntos_visitante, equipo_visitante, null)) as 'equipo_ganador'
FROM partido;