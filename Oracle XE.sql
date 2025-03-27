--Oracle, por defecto diferencia entre may y min en sus textos (string/varchar)
--Todo lo que no sea un numero se escribe entre comillas simples '...' 
--Para filtrar se utiliza where  y se escribe solo una vez en toda la consulta despues del from
--MOSTRAR TODOS LOS EMPLEADOS DEL DEP 10
SELECT * FROM EMP where DEPT_NO=10;
--MOSTRAR TODOS LOS EEMPLEADOS CUYO OFICIO SEA DIRECTOR
SELECT * FROM EMP where OFICIO='DIRECTOR';
--MOSTRAR TODOS LOS EMP CUYO OFICIO SEA DIFERENTE A DIRECTOR
SELECT * FROM EMP WHERE OFICIO<>'DIRECTOR';
--TAMBIEN  FUNCIONA != PERO NO ES UN ESTÁNDAR Y HACE LO MISMO
SELECT * FROM EMP WHERE OFICIO!='DIRECTOR';
--Existen tambien operadores relacionales que permiten realizar mas de una pregunta dentro de una consulta
/*
OR --> MUESTRA LOS DATOS DE CADA FILTRO
AND --> TODOS LOS FILTROS DEBEN CUMPLIRSE
NOT -->  NEGACION DE UNA CONDICION (EIVTAR SIEMPRE)
*/
--MOSTRAR EMPLEADOS DEL DEP 10 Y QUE TENGA OFICIO DIRECTOR
SELECT * FROM EMP WHERE OFICIO='DIRECTOR' AND DEPT_NO=10;
--Si uso un OR 
SELECT * FROM EMP WHERE OFICIO='DIRECTOR' OR DEPT_NO=10;
--MOSTRAR LOS EMPLEADOS DEL  DEP 10 Y DEP 20
SELECT * FROM EMP WHERE DEPT_NO=20 AND DEPT_NO=10;
--ESTA COMBINACION NO TIENE SENTIDO 
SELECT * FROM EMP WHERE DEPT_NO=20 OR DEPT_NO=10;

--EXISTEN OTROS OPERADORES ADEMAS DE LOS ESTANDAR
--BETWEEN MUESTRA LOS DATOS ENTRE UN RANGO INCLUIDO
--MOSTRAR EMP CUYO SALARIO ESTE ENTRE 251000 Y 390000
SELECT * FROM EMP WHERE SALARIO BETWEEN 251000 AND 390000;
SELECT * FROM EMP WHERE SALARIO BETWEEN 251000 AND 390000 ORDER BY SALARIO;
--SE PUEDE HACER LA MISMA CONSULTA CON OPERADORES Y ES EFICIENTE
SELECT * FROM EMP WHERE SALARIO>=251000 AND SALARIO<= 390000 ORDER BY SALARIO;
--LA NEGACION ES ALGO DE LO QUE SE DEBE HUIR
--MOSTRAR LOS EMPLEADOS QUE NO SEAN DIRECTOR
SELECT * FROM EMP WHERE NOT OFICIO='DIRECTOR';
--PODEMOS REALIZAR LA CONSULTA CON OPERADOR
SELECT * FROM EMP WHERE OFICIO <>'DIRECTOR';
--EXISTE UN OPERADOR PARA BUSCAR COINCIDENCIAS EN TEXTOS (ESTANDAR)
--PERMITE MEDIANTE CARACTERES ESPECIALES HACER FILTROS EN TEXTOS 
/*
% BUSCA CUALQUIER CARACTER Y LONGITUD
_ CUALQUIER CARACTER
? UN CARACTER NUMERICO
*/
--MOSTRAR EMP CUYO APELLIDO COMIENZA EN s 
SELECT * FROM EMP WHERE APELLIDO LIKE 's%';
--MOSTRAR EMP CUYO APELLIDO COMIENZA EN s Y FINALIZA CON a
SELECT * FROM EMP WHERE APELLIDO LIKE 's%a';
--MOSTRAR TODOS LOS EMPLEADOS CUYO APELLIDO SEA DE 4 LETRAS
SELECT * FROM EMP WHERE APELLIDO LIKE '____';
--EXISTE OTRO OPERADOR PARA BUSCAR COINCIDENCIAS DE IGUALDAD EN UN MISMO CAMPO
--in (valor1, valor2)
--MOSTRAR LOS EMPLEADOS DEL DEP 10 Y DEP 20
SELECT * FROM EMP WHERE DEPT_NO=20 OR DEPT_NO=10;
--MOSTRAR LOS EMPLEADOS DEL DEP 10, 20 Y 30
SELECT * FROM EMP WHERE DEPT_NO=20 OR DEPT_NO=10 OR DEPT_NO=30;
SELECT * FROM EMP WHERE DEPT_NO IN (10,20,30,55,65,77);
--LAS CONSULTAS SON IGUAL DE EFICIENTES 
--TENEMOS EL OPERADOR NOT IN
--MOSTRAR TODOS LOS EMPLEADOS QUE NO ESTEN EN EL DEPARTAMENTO 10 Y 20
SELECT * FROM EMP WHERE NOT DEPT_NO IN (10,20); 
--ES UNA NEGACION DE UNA CONDICION Y HACE DOS CONSULTAS 
SELECT * FROM EMP WHERE DEPT_NO NOT IN (10,20); 
--CAMPOS CALCULADOS
--UN CAMPO CALCULADO ES UNA HERRAMIENTA EN UNA CONSULTA 
--SIRVE PARA GENERAR CAMPOS QUE NO EXSTAN EN LA TABLA Y SE PUEDEN CALCULAR
--MOSTRAR EL APELLIDO, EL SALARIO, COMISION Y SALARIO TOTAL DE EMP 

SELECT APELLIDO, SALARIO, COMISION, (SALARIO+COMISION) FROM EMP;
--SIEMPRE HAY QUE DAR UN ALIAS A LOS CAMPOS CALCULADOS, 
--NO SE PUEDEN REPETIR NOMBRES DE COLUMNAS:
SELECT APELLIDO, SALARIO, COMISION, (SALARIO+COMISION) AS TOTAL FROM EMP;
--UN CAMPO CALCULADO SOLO ES PARA EL CURSOR
--CUYO SALARIO SEA MAYOR DE 344500 --> NO SE PUEDE HACER
--WHERE SOLO BUSCA EN LA TABLA
SELECT APELLIDO, SALARIO, COMISION, (SALARIO+COMISION) AS TOTAL FROM EMP
WHERE (SALARIO + COMISION) >=  344500;
--QUEREMOS LA CONSULTA ORIGINAL Y ORDENAR POR ELLA
SELECT APELLIDO, SALARIO, COMISION, (SALARIO+COMISION) AS TOTAL FROM EMP
ORDER BY TOTAL;
--LA ORDENACION SIEMPRE AFECTA AL SELECT
--WHERE SE HACE SOBRE LOS DATOS DE LA TABLA

--CLAUSULA  DISTINCT: SE UTILIZA PARA EL SELECT,  ELIMINA REPETIDOS DE CONSULTA
--MOSTRAR OFICIO DE EMPLEADOS
SELECT DISTINCT OFICIO FROM EMP;
--MOSTRAR LOS DIFERENTES OFICIOS Y APELLIDOS DE LOS EMPLEADOS. 
SELECT DISTINCT OFICIO, APELLIDO FROM EMP;
--NO TIENE MUCHO SENTIDO PORQUE NO  TIENE NADA QUE VER
SELECT * FROM ENFERMO;
--MOSTRAR TODOS LOS ENFERMOS NACIDOS ANTES DEL 11/01/1970
SELECT APELLIDO, FECHA_NAC FROM  ENFERMO WHERE FECHA_NAC <'11/01/1970';
--MOSTRAR TODOS LOS ENFERMOS NACIDOS ANTES DEL 01/01/1970 
--ORDENADOS POR  NUMERO DE INSCRIPCION
SELECT INSCRIPCION, APELLIDO, FECHA_NAC FROM ENFERMO WHERE FECHA_NAC <'01/01/1970'
ORDER BY inscripcion;
--LISTADO TODOS LOS DATOS DE LA PLANTILLA DEL HOSPITAL DEL TURNO DE MAÑANA
SELECT * FROM plantilla;
SELECT * FROM plantilla where TURNO='M';
--LISTADO TODOS LOS DATOS DE LA PLANTILLA DEL HOSPITAL DEL TURNO DE NOCHE
SELECT * FROM plantilla where TURNO='N';
--LISTADO DE LOS DOCTORES CUYO SALARIO ANUAL SUPERE LOS 3.000.000€
SELECT * FROM doctor;
SELECT APELLIDO, SALARIO, (SALARIO*12) AS SALARIO_ANUAL FROM DOCTOR 
WHERE (SALARIO*12)>3000000;
--VISUALIZAR EMPLEADOS DE PLANTILLA DE T/M 
--QUE TENGAN SALARIO ENTRE 2000000 Y 2250000
SELECT APELLIDO,TURNO, SALARIO, (SALARIO*12) AS SALARIO_ANUAL FROM PLANTILLA 
WHERE turno='M' AND (SALARIO*12) BETWEEN 2000000 AND 2250000;

--VISUALIZAR EMP QUE  NO SE DIERON DE ALTA ENTRE 01/01/1980 Y 12/12/1982
SELECT * FROM emp;
SELECT APELLIDO, OFICIO, FECHA_ALT FROM EMP WHERE 
OFICIO='EMPLEADO' AND fecha_alt NOT IN ('01/01/80','12/12/82');
--MOSTRAR LOS NOMBRES DE LOS DEPARTAMENTOS SITUADOS EN MADRID O EN BARCELONA
SELECT  * FROM dept;
SELECT DNOMBRE, LOC FROM dept WHERE LOC='MADRID' OR LOC='BARCELONA';
desc ENFERMO;


--1. Seleccionar el apellido, oficio, salario, numero de departamento y su
--nombre de todos los empleados cuyo salario sea mayor de 300000

SELECT e.apellido, e.oficio, e.salario, d.dept_no, d.dnombre
FROM emp e
JOIN dept d
ON e.dept_no = d.dept_no
WHERE salario>300000;

--2. Mostrar todos los nombres de Hospital con sus nombres
--de salas correspondientes.
SELECT  h.nombre as NOMBRE_HOSPITAL, s.nombre as NOMBRE_SALA
FROM hospital h
JOIN sala s
ON h.hospital_cod = s.hospital_cod;

--3. Calcular cuántos trabajadores de la empresa hay en cada ciudad.
SELECT count(apellido) as TRABAJADORES, d.loc as CIUDAD
FROM emp e
RIGHT JOIN dept d
ON d.dept_no = e.dept_no
GROUP BY d.loc;

--4. Visualizar cuantas personas realizan cada oficio en cada departamento 
--mostrando el nombre del departamento.

SELECT count(apellido) as PERSONAS, e.oficio, d.dnombre
FROM emp e
RIGHT JOIN dept d
ON d.dept_no = e.dept_no
GROUP BY d.dnombre, e.oficio;

--5. Contar cuantas salas hay en cada hospital, 
--mostrando el nombre de las salas y el nombre del hospital. 

SELECT count(sala_cod) as NUMERO_SALAS, h.nombre, s.nombre
FROM hospital h
JOIN sala s
ON h.hospital_cod = s.hospital_cod
GROUP BY h.nombre, s.nombre;

--6. Queremos saber cuántos trabajadores se dieron de alta
--entre el año 1997 y 1998 y en qué departamento.

SELECT count(e.EMP_NO) as ALTAS, d.dnombre
FROM emp e
JOIN dept d
ON d.dept_no = e.dept_no
WHERE fecha_alt BETWEEN '01/01/1997' AND '31/12/1998'
GROUP BY d.dnombre;

--7. Buscar aquellas ciudades con cuatro o más personas trabajando.

SELECT count(e.EMP_NO) as TRABAJADORES, d.loc as CIUDAD
FROM emp e
JOIN dept d
ON d.dept_no = e.dept_no
GROUP BY d.loc
HAVING count(e.apellido)>=4;

--8. bCalcular la media salarial por ciudad.  
--Mostrar solamente la media para Madrid y Elche.

SELECT AVG(e.salario) as MEDIA_SALARIAL, d.loc as CIUDAD
FROM emp e
JOIN dept d
ON d.dept_no = e.dept_no
GROUP BY d.loc
HAVING d.loc in ('MADRID', 'SEVILLA');

--9. Mostrar los doctores junto con el nombre de hospital en el que ejercen, 
--la dirección y el teléfono del mismo.

SELECT d.apellido, h.nombre, h.direccion, h.telefono
FROM doctor d
JOIN hospital h
ON d.hospital_cod = h.hospital_cod;

--10.     10. Mostrar los nombres de los hospitales junto con el mejor salario 
--de los empleados de la plantilla de cada hospital.

SELECT h.nombre as HOSPITAL, max(p.salario) as MEJOR_SALARIO
FROM hospital h
JOIN plantilla p
ON h.hospital_cod = p.hospital_cod
GROUP BY h.nombre;

--11. Visualizar el Apellido, función y turno de los empleados de la plantilla 
--junto con el nombre de la sala y el nombre del hospital con el teléfono.

SELECT h.nombre as HOSPITAL, h.telefono, p.funcion, p.turno, s.nombre as SALA
FROM plantilla p
JOIN hospital h
ON h.hospital_cod = p.hospital_cod
JOIN sala s
ON h.hospital_cod = s.hospital_cod and p.sala_cod=s.sala_cod;


SELECT * FROM PLANTILLA;


--12. Visualizar el máximo salario, mínimo salario de los Directores dependiendo
--de la ciudad en la que trabajen. 
--Indicar el número total de directores por ciudad.
SELECT max(e.salario) as SALARIO_MAX, min(e.salario) as SALARIO_MIN,
count(e.apellido) as DIRECTORES, d.loc as CIUDAD 
FROM emp e
JOIN dept d
ON d.dept_no = e.dept_no
WHERE e.oficio= 'DIRECTOR'
GROUP BY d.loc;



--13. Averiguar la combinación de que salas podría haber 
--por cada uno de los hospitales.

SELECT  h.nombre as HOSPITAL, s.nombre as SALA
FROM hospital h
CROSS JOIN sala s;

--SUBCONSULTAS

/*
SON AQUELLAS QUE NECESITAN DEL RESULTADO DE OTRA CONSULTA PARA PODER SER
EJECUTADAS. NO SON AUTONOMAS, NECESITAN DE ALGUN VALOR.
NO IMMPORTA EL NIVEL DE ANIDAMIENTO DE SUBCONSULTAS, AUNQUE PUEDEN RALENTIZAR
LA RESPUESTA.
Generan bloqueos en consultas select, lo que tambien ralentiza las respuestas.

*/


--Quiero visualizar los datos del empleado que mas cobra de la empresa (EMP).
select max(SALARIO) from EMP;
--650000
select * from EMP where SALARIO=650000;

/*
Se ejecutan las dos consultas a la vez y se anida el resultado de una consulta
con la igualdad de la respuesta  de otra consulta
las subconsultas van entre parentesis.
*/
select * from EMP where SALARIO=(select max(SALARIO) from EMP);

/*
Debemos evitarlas en la medida de lo posible con select, generan bloqueos 

Se pueden hacer tantas subconsultas como quiera

Mostrar los Empleados que tienen el mismo oficio que el empleado GIL y que 
jimenez

Si una subconsulta devuelve mas de un valor utilizaremos el operador in
*/

select * from EMP where OFICIO in
(select OFICIO from EMP where APELLIDO = 'gil' or APELLIDO='jimenez');

--Mostrar apellido y oficio de los empleados del dep de madrid. 
select APELLIDO, OFICIO from EMP where DEPT_NO=
(select DEPT_NO from DEPT where loc='MADRID');

--Esto no se debe hacer

--Consultas de union 
--Muestran en un mismo cursor un mismo conjunto de resultados. 
--Se utilizan como concepto y no como relacion.
/*
Hay que seguir 3 NORMAS

1)  la primera consulta es la jefa. 
2)  TOdas las consultas deben tener el mismo numero de columnas
3)Todas las columnas deben tener el mismo tipo de dato entre si

En nuestra base de datos, tenemos datos de personas en diferentes tablas
EMP; PLANTILLA; DOCTOR

Se obtienen todos los valores en  un solo cursor 

*/

select APELLIDO, OFICIO, SALARIO from EMP
union
select DNOMBRE, LOC, DEPT_NO from DEPT
union
select APELLIDO, FUNCION, SALARIO from PLANTILLA;

--Se puede ordenar tambien
select APELLIDO, OFICIO, SALARIO from EMP
union
select APELLIDO, ESPECIALIDAD, SALARIO from DOCTOR
union
select APELLIDO, FUNCION, SALARIO from PLANTILLA
order by SALARIO;


/*
En las consultas union siempre se deberia utilizar order by numerando
como recomendacion si ponemos un alias no funciona
Cuando np se llaman igual los campos en todas las consultas no se puede
ordenar por nombre.
*/


select APELLIDO, OFICIO, SALARIO from EMP
union
select APELLIDO, FUNCION, SALARIO from PLANTILLA
union
select APELLIDO, ESPECIALIDAD, SALARIO from DOCTOR
where SALARIO <300000
order by 1;

/*
Por supuesto se puede filtrar los datos de la consulta
Por ejemplo, mostrar los datos de las personas que cobren menos de 300000

Cada where es indep de cada consulta
*/

select APELLIDO, OFICIO, SALARIO from EMP
union
select APELLIDO, OFICIO, SALARIO from EMP;

-- Union elimina los resultados repetidos.
--Si queremos repetidos debemos utilizar union all

select APELLIDO, OFICIO, SALARIO from EMP
union all
select APELLIDO, OFICIO, SALARIO from EMP;



















