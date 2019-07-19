-- CONSULTA 1 
SELECT num_serie, anio, capacidad, marca, modelo, num_cilindros, num_puertas, llanta_refaccion, tipo_transmision, tipo_combustible, pasajeros
FROM 
(SELECT num_economico, COUNT(num_economico) AS no_veh1
FROM Viaje
GROUP BY num_economico) SUB NATURAL JOIN Vehiculo_asociado NATURAL JOIN Ser NATURAL JOIN Vehiculo
WHERE no_veh1 = (SELECT MAX(no_veh)
FROM (SELECT num_economico, COUNT(num_economico) AS no_veh
FROM Viaje
GROUP BY num_economico) SUB1);

--CONSULTA 2
SELECT * 
FROM Asociado
NATURAL JOIN
(SELECT RFC, COUNT(RFC) AS num_unidades
FROM Vehiculo_Asociado
GROUP BY RFC
HAVING COUNT(RFC) > 1) AS tr;

-- CONSULTA 3
SELECT num_economico, COUNT(num_economico) AS num_Multas
FROM Multa
GROUP BY num_economico;

--CONSULTA 4
SELECT AVG(CAST(monto_final AS NUMERIC))
FROM Cobro NATURAL JOIN Viaje NATURAL JOIN
(SELECT *
FROM Cliente NATURAL JOIN Informacion_Cliente
WHERE tipo_cliente = 'E') AS SUB;

-- CONSULTA 5
SELECT num_serie, anio, capacidad, marca, modelo, num_cilindros, num_puertas, llanta_refaccion, tipo_transmision, tipo_combustible, pasajeros
FROM Viaje NATURAL JOIN Vehiculo_asociado NATURAL JOIN Ser NATURAL JOIN Vehiculo
WHERE distancia=(SELECT MIN(distancia)
FROM Viaje);

--CONSULTA 6
SELECT *
FROM Informacion_Cliente
ORDER BY tipo_cliente ASC,paterno_cliente ASC,materno_cliente ASC,
nombre_cliente DESC;

-- CONSULTA 7
SELECT tipo_cliente, COUNT(tipo_cliente) AS Cantidad
FROM Informacion_cliente
GROUP BY tipo_cliente;

--CONSULTA 8
SELECT *
FROM Asociado
WHERE fecha_ingreso >= '2005/01/01' AND
(nombre_Asociado LIKE 'A%' OR
nombre_Asociado LIKE 'S%' OR
nombre_Asociado LIKE 'G%' OR
nombre_Asociado LIKE 'R%');

-- CONSULTA 9
SELECT num_multa, fecha_infraccion, num_serie
FROM Multa NATURAL JOIN Vehiculo_asociado NATURAL JOIN Ser NATURAL JOIN Vehiculo
WHERE fecha_infraccion >= '01-01-2017' AND fecha_infraccion <= '31-12-2017' AND marca='NISSAN';

--CONSULTA 10
SELECT ciudad_cliente, COUNT(CURP) AS num_Clientes
FROM Informacion_Cliente
GROUP BY ciudad_cliente;

-- CONSULTA 11
SELECT RFC, paterno_Asociado, materno_Asociado, nombre_Asociado, edad
FROM
(SELECT RFC, paterno_Asociado, materno_Asociado, nombre_Asociado, esDuenio, esChofer,
DATE_PART('YEAR',AGE(TO_DATE(año||'-'||mes||'-'||dia,'YYYY-MM-DD'))) AS edad
FROM
(SELECT RFC, '19'||substr(RFC,5,2) AS año, substr(RFC,7,2) AS mes, substr(RFC,9,2) AS dia,
paterno_Asociado, materno_Asociado, nombre_Asociado,esDuenio, esChofer
FROM Asociado
WHERE esDuenio=TRUE AND esChofer=TRUE) SUB) SUB2
WHERE edad>25;

--CONSULTA 12
SELECT num_agente, COUNT(num_agente)
FROM Multa
GROUP BY num_agente;

--  CONSULTA 13
SELECT RFC, SUM(ganancia) AS Ingresos
FROM Ganancias
GROUP BY RFC;

--CONSULTA 14
SELECT edificio, COUNT(CURP)
FROM Informacion_Cliente
GROUP BY edificio;

-- CONSULTA 15
SELECT genero, COUNT(CURP)
FROM
(SELECT CURP,
CASE WHEN substr(CURP,11,1) = 'H' THEN 'HOMBRE'
     WHEN substr(CURP,11,1) = 'M' THEN 'MUJER' END AS genero
FROM Informacion_Cliente) SUB
GROUP BY genero;

--CONSULTA 16
SELECT RFC, paterno_Asociado, materno_Asociado, nombre_Asociado, DATE_PART('YEAR',AGE(TO_DATE(año||'-'||mes||'-'||dia,'YYYY-MM-DD'))) AS edad
FROM
(SELECT RFC, '19'||substr(RFC,5,2) AS año, substr(RFC,7,2) AS mes, substr(RFC,9,2) AS dia,
paterno_Asociado, materno_Asociado, nombre_Asociado
FROM Asociado) SUB
ORDER BY edad ASC, paterno_Asociado ASC;

-- CONSULTA 17
SELECT RFC, unidades
FROM Asociado NATURAL JOIN (SELECT RFC, COUNT(RFC) AS unidades
FROM Conducir
GROUP BY RFC) SUB
WHERE esChofer = true AND unidades > 1;

--CONSULTA 18
SELECT descuento, COUNT(id_viaje)
FROM Cobro
WHERE CAST(descuento AS NUMERIC) IN (10, 15, 20)
GROUP BY descuento;

-- CONSULTA 19
SELECT marca, COUNT(marca)
FROM Asociado NATURAL JOIN Vehiculo_asociado NATURAL JOIN Ser NATURAL JOIN Vehiculo
WHERE fecha_ingreso > '01-01-2015'
GROUP BY marca;

--CONSULTA 20
SELECT *
FROM
(SELECT COUNT(RFC) AS duenos
FROM Asociado
WHERE esDuenio = TRUE) AS Duenios
CROSS JOIN
(SELECT COUNT(RFC) AS choferes
FROM Asociado
WHERE esChofer = TRUE) AS Choferes
CROSS JOIN
(SELECT COUNT(CURP) AS Numclientes
FROM Informacion_Cliente) AS clien;

-- CONSULTA 21
SELECT RFC, nombre_asociado, paterno_asociado, materno_asociado
FROM Asociado NATURAL JOIN
(SELECT RFC, SUM(ganancia) AS Ingresos
FROM Ganancias
GROUP BY RFC
HAVING SUM(CAST(ganancia AS NUMERIC)) > (SELECT AVG(CAST(ingresos_asoc AS NUMERIC)) FROM 
(SELECT RFC, SUM(ganancia) AS ingresos_asoc FROM Ganancias GROUP BY RFC) SUB)) SUB2;

-- CONSULTA 22
SELECT anio, COUNT(RFC) AS num_asociados
FROM
(SELECT EXTRACT(YEAR FROM fecha_ingreso) AS anio, RFC
FROM Asociado) SUB
GROUP BY anio
ORDER BY anio;

-- Consulta 23
SELECT anio, articulo, COUNT(articulo)
FROM
(SELECT EXTRACT(YEAR FROM fecha_infraccion) AS anio, articulo
FROM Multa) SUB
GROUP BY anio, articulo
ORDER BY anio, articulo;

-- CONSULTA 24
SELECT lugar_destino, CASE
			WHEN tipo_cliente='E' THEN 'ESTUDIANTES'
			WHEN tipo_cliente='A' THEN 'ACADEMICOS'
			WHEN tipo_cliente='T' THEN 'TRABAJADORES' END AS tipoCliente,
			COUNT(lugar_destino)
FROM Viaje NATURAL JOIN Cliente NATURAL JOIN Informacion_Cliente
WHERE UPPER(lugar_destino) LIKE '%FACULTAD%' OR
      UPPER(lugar_destino) LIKE '%INSTITUTO%' OR
      UPPER(lugar_destino) LIKE '%UNIDAD%'
GROUP BY lugar_destino, tipo_cliente
ORDER BY lugar_destino, tipo_cliente;

-- CONSULTA 25
SELECT anio_viaje, COUNT(id_viaje)
FROM
(SELECT id_viaje, EXTRACT(YEAR FROM fecha_viaje) AS anio_viaje
FROM Viaje) SUB
GROUP BY anio_viaje
ORDER BY anio_viaje;

-- CONSULTA 26
SELECT monto, monto_final, descuento
FROM Cobro NATURAL JOIN Viaje NATURAL JOIN Cliente NATURAL JOIN Informacion_Cliente 
WHERE monto_final > CAST(300 AS MONEY) AND monto > CAST(370 AS MONEY);