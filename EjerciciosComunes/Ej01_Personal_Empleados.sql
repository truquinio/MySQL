/*
Abrir el script llamado “personal” y ejecutarlo de modo tal que se cree la base de datos “personal”, 
se creen las tablas y se inserten todos los datos en las tablas para que quede de la siguiente manera:

a)   A continuación, realizar las siguientes consultas sobre la base de datos personal:
*/ 
USE personal;

#	1.    Obtener los datos completos de los empleados.
SELECT * FROM empleado;

#	2.   Obtener los datos completos de los departamentos.
SELECT * FROM departamento;

#	3.   Listar el nombre de los departamentos.
SELECT nombre_depto FROM departamento;

#	Tabla ordenada x Nombre Dptos.:
SELECT * FROM departamento ORDER BY nombre_depto ASC;
SELECT * FROM departamento ORDER BY nombre_depto DESC;

#	4.   Obtener el nombre y salario de todos los empleados.
SELECT nombre, salario FROM empleado;

#	5.   Listar todas las comisiones.
SELECT comision FROM empleado;

#	PRUEBA: Tabla ordenada x comisiones: Ascendente
SELECT * FROM empleado ORDER BY comision ASC;

#	6.   Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’.
SELECT * FROM empleado WHERE cargo LIKE 'Secretaria';

#	7.   Obtener los datos de los empleados vendedores, ordenados por nombre alfabéticamente.
SELECT * FROM empleado WHERE cargo LIKE 'Vendedor' ORDER BY nombre ASC;

#	8.   Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a mayor.
SELECT nombre, cargo, salario FROM empleado ORDER BY salario ASC;

#	9.   Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las respectivas tablas de empleados.
SELECT nombre, cargo FROM empleado;

SELECT nombre AS 'NOMBRE:', cargo AS 'CARGO:' FROM empleado;

#	10.  Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión de menor a mayor.
SELECT salario, comision, id_depto FROM empleado WHERE id_depto = 2000 ORDER BY comision ASC;

#	11.   Obtener el valor total a pagar que resulta de sumar el salario y la comisión de los empleados del departamento 3000 una bonificación de 500, en orden alfabético del empleado.
SELECT salario, comision, (salario + 500) AS 'Salario + Comisión' FROM empleado 
WHERE id_depto = '3000' ORDER BY nombre ASC;

#	12.  Muestra los empleados cuyo nombre empiece con la letra J.
SELECT * FROM empleado WHERE nombre LIKE 'j%';

#	13.  Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos empleados que tienen comisión superior a 1000.
SELECT nombre, salario, comision, (salario + comision) AS 'Salario total' FROM empleado WHERE comision > 1000;

#	14.  Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión.
SELECT nombre, salario, comision, (salario + comision) AS 'Salario total' FROM empleado WHERE comision = 0;

#	15.  Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
SELECT nombre, salario, comision FROM empleado WHERE comision > salario;

#	16.  Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
SELECT nombre, comision, salario FROM empleado WHERE comision <= (salario * 0.3);

#	17.  Hallar los empleados cuyo nombre no contiene la cadena “MA”
SELECT nombre FROM empleado WHERE nombre NOT LIKE '%ma%';

#	18.  Obtener los nombres de los departamentos que sean “Ventas”, “Investigación”, “Mantenimiento”.
SELECT nombre_depto FROM departamento WHERE nombre_depto IN ('ventas', 'investigación', 'mantenimiento');

#	19.  Obtener los nombres de los departamentos que NO sean “Ventas”, “Investigación”, “Mantenimiento”.
SELECT nombre_depto FROM departamento WHERE nombre_depto NOT IN ('ventas', 'investigación', 'mantenimiento');

#	20. Mostrar el salario más alto de la empresa.
SELECT nombre, MAX(salario) AS 'Salario Max' FROM empleado;

#	21.  Mostrar el nombre del último empleado de la lista por orden alfabético.
SELECT MAX(nombre) AS 'Último alfabeticamente' FROM empleado;

#	22. Hallar el salario más alto, el más bajo y la diferencia entre ellos.
SELECT max(salario) AS 'Salario Max', min(salario) AS 'Salario Min', max(salario) - min(salario) AS 'Diferencia' FROM empleado;

#	23. Hallar el salario promedio por departamento.
SELECT AVG(salario) AS 'Salario Promedio' FROM empleado ORDER BY id_depto;

#	HAVING:
#	24. Hallar los departamentos que tienen más de tres empleados. Mostrar el número de empleados de esos departamentos.
SELECT id_depto, COUNT(*) as 'Num_Empleados' 
FROM empleado 
GROUP BY id_depto 
HAVING Num_Empleados > 3;

#	25. Mostrar el código y nombre de cada jefe, junto al número de empleados que dirige. Solo los que tengan más de dos empleados (2 incluido).
SELECT *, COUNT(*) AS 'Num_Empleados' 
FROM empleado 
GROUP BY id_depto 
HAVING Num_Empleados > 2 AND cargo LIKE 'Jefe%';

#	26. Hallar los departamentos que no tienen empleados
SELECT *, COUNT(*)
FROM empleado
GROUP BY id_depto
HAVING COUNT(*) = 0;

#	27. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la empresa. Ordenarlo por departamento.
SELECT id_depto, nombre, salario
FROM empleado
WHERE salario >= (SELECT AVG(salario) FROM empleado)
ORDER BY id_depto;

#	OTRA FORMA con INNER JOIN:
SELECT *
FROM empleado AS empl
INNER JOIN departamento as dpto
ON empl.id_depto = dpto.id_depto
WHERE empl.salario >= (SELECT AVG(salario) FROM empleado)
ORDER BY dpto.nombre_depto;