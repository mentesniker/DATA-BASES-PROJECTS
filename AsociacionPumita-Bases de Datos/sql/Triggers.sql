-- Función que utilizará el distaparador para no permitir borrar del histórico.
CREATE OR REPLACE FUNCTION borrarHistorico() RETURNS TRIGGER AS $borrar$
BEGIN
RAISE EXCEPTION 'No puedes borrar los historicos';
END;
$borrar$ LANGUAGE plpgsql;

-- Creamos disparador para no permitir borrar del histórico.
CREATE TRIGGER ConservarHistoricos AFTER DELETE OR UPDATE ON Log_vehiculo
FOR EACH ROW EXECUTE PROCEDURE borrarHistorico();

-- Función que utilizará el disparador para guardar en historicos.
CREATE OR REPLACE FUNCTION guardaEnHistorico() RETURNS TRIGGER AS $guardaHis$
DECLARE
    id_nuevo INT2;
    num_ec INT2;
    raz char(150);
BEGIN
IF (TG_OP = 'DELETE') THEN
    num_ec := OLD.num_economico;
    raz := OLD.razon;
END IF;
SELECT MAX(id_log_vehiculo) FROM Log_vehiculo INTO id_nuevo;
INSERT INTO Log_vehiculo VALUES(id_nuevo+1, num_ec, raz, CURRENT_DATE);
RETURN NEW;
END;
$guardaHis$ LANGUAGE plpgsql;

-- Creamos disparador para poder guardar a los vehiculo eliminados de la base en históricos.
CREATE TRIGGER AgregaHistorico AFTER DELETE OR UPDATE ON Borrar
FOR EACH ROW EXECUTE PROCEDURE guardaEnHistorico();

-- Función que utilizará el distaparador para agregar el cobro y la gananciaF de un Cliente.
CREATE OR REPLACE FUNCTION insertaCobro() RETURNS TRIGGER AS $insertCobro$
DECLARE
    id_nuevo INT2;
    descu INT2;
    montoA MONEY;
    montoF MONEY;
    tipo CHAR(1);
    dist INT2;
    destin VARCHAR(250) := NEW.lugar_origen;
    origin VARCHAR(250) := NEW.lugar_destino;
    costoKilom INT2;
    pasaj INT2;
    viajes_realizados INT2;
    gananciaF MONEY;
    viajes_por_mes INT2;
    id_gan_nuevo INT2;
    bono MONEY;
    id_bono INT2;
    id_viaje_temporal INT2:=NEW.id_viaje;
    RFC_temporal VARCHAR(13):=NEW.RFC;
    fecha_temporal DATE:= NEW.fecha_viaje;
BEGIN
SELECT COUNT(id_viaje) FROM Viaje WHERE id_viaje = NEW.id_viaje INTO pasaj;
IF (pasaj > 2) THEN
    descu=10*(pasaj-1);
ELSE
    SELECT tipo_cliente FROM Informacion_Cliente WHERE CURP=NEW.CURP INTO tipo;
    IF (tipo='E') THEN
      descu=15;
    ELSE
      descu=10;
    END IF;
END IF;
dist = NEW.distancia;
SELECT COUNT(CURP) FROM Viaje WHERE CURP = NEW.CURP INTO viajes_realizados;
SELECT COUNT(RFC) FROM Ganancias NATURAL JOIN
(SELECT id_viaje,CURP,RFC, EXTRACT(YEAR FROM fecha_viaje) AS anioR,
      EXTRACT(MONTH FROM fecha_viaje) AS mes
      FROM Viaje
      WHERE RFC=NEW.RFC) SUB
      WHERE EXTRACT(YEAR FROM fecha_temporal)=anioR AND EXTRACT(MONTH FROM fecha_temporal)=mes INTO viajes_por_mes;
SELECT MAX(id_ganancia) FROM Ganancias INTO id_gan_nuevo;
IF ((UPPER(origin) LIKE '%FACULTAD%' OR
    UPPER(origin) LIKE '%INSTITUTO%' OR
    UPPER(origin) LIKE '%UNIDAD%') AND
    (UPPER(destin) LIKE '%FACULTAD%' OR
    UPPER(destin) LIKE '%INSTITUTO%' OR
    UPPER(destin) LIKE '%UNIDAD%')) THEN
      IF ((viajes_realizados%6)=0) THEN
        montoA=10;
      ELSE
        montoA = 15;
      END IF;
        gananciaF=montoA*8/100;
ELSE
      IF ((viajes_realizados%6)=0) THEN
        montoA = (dist*6)+15;
      ELSE
        montoA = (dist*8)+15;
      END IF;
        gananciaF=montoA*12/100;
END IF;
montoF = montoA-(montoA*descu/100);
SELECT MAX(id_cobro) FROM Cobro INTO id_nuevo;
INSERT INTO Cobro VALUES(id_nuevo+1, id_viaje_temporal, NEW.CURP, descu, montoA, montoF);
INSERT INTO Ganancias VALUES(id_gan_nuevo+1,id_viaje_temporal,NEW.CURP,RFC_temporal,gananciaF,'false');
SELECT SUM(ganancia) FROM Ganancias NATURAL JOIN 
(SELECT id_viaje,CURP,RFC, EXTRACT(YEAR FROM fecha_viaje) AS anioR,
      EXTRACT(MONTH FROM fecha_viaje) AS mes
      FROM Viaje
      WHERE RFC=RFC_temporal) SUB
      WHERE EXTRACT(YEAR FROM fecha_temporal)=anioR AND EXTRACT(MONTH FROM fecha_temporal)=mes AND esBono=FALSE INTO bono;
IF (viajes_por_mes > 21) THEN
    SELECT id_ganancia FROM Ganancias NATURAL JOIN
      (SELECT id_viaje, CURP, RFC, EXTRACT(YEAR FROM fecha_viaje) AS anioR,
      EXTRACT(MONTH FROM fecha_viaje) AS mes
      FROM Viaje
      WHERE RFC=RFC_temporal) SUB
      WHERE EXTRACT(YEAR FROM fecha_temporal)=anioR AND EXTRACT(MONTH FROM fecha_temporal)=mes AND esBono=TRUE INTO id_bono;
    UPDATE Ganancias SET ganancia=bono*10/100, id_viaje=id_viaje_temporal, CURP=NEW.CURP, RFC=RFC_temporal WHERE id_ganancia=id_bono;
END IF;
IF (viajes_por_mes = 21) THEN
    INSERT INTO Ganancias VALUES(id_gan_nuevo+2,id_viaje_temporal,NEW.CURP,RFC_temporal,bono*10/100,'true');
END IF;
RETURN NEW;
END;
$insertCobro$ LANGUAGE plpgsql;

-- Creamos disparador para poder guardar el cobro de un viaje.
CREATE TRIGGER InsertaViaje AFTER INSERT ON Viaje
FOR EACH ROW EXECUTE PROCEDURE insertaCobro();