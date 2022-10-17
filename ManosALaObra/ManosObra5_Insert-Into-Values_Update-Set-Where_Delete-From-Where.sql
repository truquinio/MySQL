/* 
MANOS A LA OBRA 5:
Volveremos a abrir y ejecutar el script “superhéroe”. 
Hasta el momento, nuestra base de datos “superhéroe” se encuentra vacía. Sólo tenemos la 
estructura (tablas y columnas). Por lo que ahora es el turno de insertar registros en cada tabla. 
A continuación, te mostramos el modelo Entidad-Relación de la tabla superhéroe:
*/
USE superheroe;

#	Muestro todas las tablas:
SELECT * FROM creador;
SELECT * FROM personaje;

#	CARGO DATOS EN CREADOR //////////////////////////////////////////////////////////////////////////////
INSERT INTO creador VALUES (1, 'MARVEL');
INSERT INTO creador VALUES (2, 'DC COMICS');

SELECT * FROM creador;

#	CARGO DATOS EN PERSONAJE ////////////////////////////////////////////////////////////////////////////
INSERT INTO personaje VALUES (1, 'Bruce Banner', 'Hulk', 160, '600 mil', 75, 98, 1962, 'Físico nuclear', 1);
INSERT INTO personaje VALUES (2, 'Tony Stark', 'Iron Man', 170, '200 mil', 70, 123, 1963, 'Inventor Industrial', 1);
INSERT INTO personaje VALUES (3, 'Thor Odinson', 'Thor', 145, 'infinita', 100, 235, 1962, 'Rey de Asgard', 1);
INSERT INTO personaje VALUES (4, 'ClarckKent', 'Superman', 165, 'infinita', 120, 182, 1948, 'Reportero', 2);
INSERT INTO personaje VALUES (5, 'Barry Allen', 'Flash', 160, '10 mil', 120, 168, 1956, 'Científico forense', 2);
INSERT INTO personaje VALUES (6, 'Thanos', 'Thanos', 170, 'infinita', 40, 306, 1973, 'Adorador de la muerte', 1);

SELECT * FROM personaje;

#	ACTUALIZAR AÑO a 1938 ////////////////////////////////////////////////////////////////////////////
UPDATE personaje
SET aparicion = 1938
WHERE id_personaje = 4;

#	BORRAR PERSONAJE ///////////////////////////////////////////////////////////////////////////////
delete from personaje where id_personaje = 5;