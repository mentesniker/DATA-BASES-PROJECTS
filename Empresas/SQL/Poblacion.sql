COPY empresa.empleado FROM '/tmp/Empleado.csv' WITH DELIMITER ',' CSV HEADER;
COPY empresa.empresa FROM '/tmp/Empresa.csv' WITH DELIMITER ',' CSV HEADER;
COPY empresa.dirigir FROM '/tmp/Dirigir.csv' WITH DELIMITER ',' CSV HEADER;
COPY empresa.Proyecto FROM '/tmp/Proyecto.csv' WITH DELIMITER ',' CSV HEADER;
COPY empresa.supervisar FROM '/tmp/Supervisar.csv' WITH DELIMITER ',' CSV HEADER;
COPY empresa.trabajar FROM '/tmp/Trabajar.csv' WITH DELIMITER ',' CSV HEADER;