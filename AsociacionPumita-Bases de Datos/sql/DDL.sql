CREATE TABLE Asociado(
    RFC 		CHAR(13) 	NOT NULL 	CHECK(RFC SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z]{2}[0-9]{1}'),
    nombre_asociado	VARCHAR(35)	NOT NULL	CHECK(nombre_asociado SIMILAR TO '[^0123456789]+'),
    paterno_asociado	VARCHAR(35)	NOT NULL	CHECK(paterno_asociado SIMILAR TO '[^0123456789]+'),
    materno_asociado 	VARCHAR(35)	NOT NULL	CHECK(materno_asociado SIMILAR TO '[^0123456789]+'),
    ciudad_asociado	VARCHAR(40)	NOT NULL	CHECK(ciudad_asociado SIMILAR TO '[^0123456789]+'),
    calle_asociado	VARCHAR(50)	NOT NULL,
    numero_asociado	INT		NOT NULL	CHECK (numero_asociado >= 0),
    CP_asociado		CHAR(5)		NOT NULL	CHECK(CAST(CP_asociado AS INTEGER) > 0),
    fecha_ingreso 	DATE		NOT NULL	CHECK(fecha_ingreso BETWEEN '01-01-2000' AND NOW()),
    correo_electronico_asociado VARCHAR(50) 	 	CHECK(correo_electronico_asociado SIMILAR TO '[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})'),
    fotografia_asociado	VARCHAR(64)	NOT NULL	CHECK(fotografia_asociado SIMILAR TO '([A-Za-z]+)(\/[A-Za-z]+)+[.a-z]+'),
    esDuenio		BOOLEAN,
    esChofer		BOOLEAN,
    telefono_celular_asociado	CHAR(14)		CHECK(telefono_celular_asociado SIMILAR TO '[5]{2}[-]([0-9]{2}[-]){3}[0-9]{2}'),
    num_licencia CHAR(8)		NOT NULL	CHECK(num_licencia SIMILAR TO '[A-Z]{1}[0-9]{7}'),
    CONSTRAINT 	PK_Asociado 	PRIMARY KEY (RFC));
   
COMMENT ON COLUMN Asociado.RFC IS 'RFC del asociado.';
COMMENT ON COLUMN Asociado.nombre_asociado IS 'Nombre del asociado.';
COMMENT ON COLUMN Asociado.paterno_asociado IS 'Apellido paterno del asociado.';
COMMENT ON COLUMN Asociado.materno_asociado IS 'Apellido materno del asociado.';
COMMENT ON COLUMN Asociado.ciudad_asociado IS 'Ciudad donde vive el asociado.';
COMMENT ON COLUMN Asociado.calle_asociado IS 'Calle donde vive el asociado.';
COMMENT ON COLUMN Asociado.numero_asociado IS 'Numero de donde reside el asociado.';
COMMENT ON COLUMN Asociado.CP_asociado IS 'Código postal de donde vive el asociado.';
COMMENT ON COLUMN Asociado.fecha_ingreso IS 'Fecha en que ingreosó el asociado a la Asociación.';
COMMENT ON COLUMN Asociado.correo_electronico_asociado IS 'Correo electróńico del asociado.';
COMMENT ON COLUMN Asociado.fotografia_asociado IS 'Ruta de la fotografía del asociado.';
COMMENT ON COLUMN Asociado.esDuenio IS 'Nos dice si el asociado es dueño.';
COMMENT ON COLUMN Asociado.esChofer IS 'Nos dice si el asociado es chofer.';
COMMENT ON COLUMN Asociado.telefono_celular_asociado IS 'Teléfono celular del asociado.';
COMMENT ON COLUMN Asociado.num_licencia IS 'Número de licencia del asociado.';

CREATE TABLE Informacion_Cliente(
    CURP		CHAR(18)	NOT NULL	CHECK(CURP SIMILAR TO '[A-Z]{4}[0-9]{6}[H,­M][A-Z]{5}[0-9]{2}'),
    nombre_cliente	VARCHAR(35)	NOT NULL	CHECK(nombre_cliente SIMILAR TO '[^0123456789]+'),
    paterno_cliente	VARCHAR(35)	NOT NULL	CHECK(paterno_cliente SIMILAR TO '[^0123456789]+'),
    materno_cliente 	VARCHAR(35)	NOT NULL	CHECK(materno_cliente SIMILAR TO '[^0123456789]+'),
    ciudad_cliente	VARCHAR(40)	NOT NULL	CHECK(ciudad_cliente SIMILAR TO '[^0123456789]+'),
    calle_cliente	VARCHAR(50)	NOT NULL,
    numero_cliente	INT		NOT NULL	CHECK (numero_cliente >= 0),
    CP_cliente		CHAR(5)		NOT NULL	CHECK(CAST(CP_cliente AS INTEGER) > 0),
    tipo_cliente	CHAR(1)		NOT NULL	CHECK(tipo_cliente SIMILAR TO '(E|T|A)'),
    fotografia_cliente	VARCHAR(64)	NOT NULL	CHECK(fotografia_cliente  SIMILAR TO '([A-Za-z]+)(\/[A-Za-z]+)+[.a-z]+'),
    telefono_casa	CHAR(11)			CHECK(telefono_casa SIMILAR TO '([0-9]{2}[-]){3}[0-9]{2}'),
    telefono_celular_cliente	CHAR(14)		CHECK(telefono_celular_cliente SIMILAR TO '[5]{2}[-]([0-9]{2}[-]){3}[0-9]{2}'),
    edificio 		VARCHAR(100)	NOT NULL,
    correo_electronico_cliente VARCHAR(50) 	 	CHECK(correo_electronico_cliente SIMILAR TO '[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})'),
    CONSTRAINT PK_Informacion_Cliente	PRIMARY KEY (CURP));

COMMENT ON COLUMN Informacion_Cliente.CURP IS 'CURP del cliente.';
COMMENT ON COLUMN Informacion_Cliente.nombre_cliente IS 'Nombre del cliente.';
COMMENT ON COLUMN Informacion_Cliente.paterno_cliente IS 'Apellido paterno del cliente.';
COMMENT ON COLUMN Informacion_Cliente.materno_cliente IS 'Apellido materno del cliente.';
COMMENT ON COLUMN Informacion_Cliente.ciudad_cliente IS 'Ciudad donde vive el cliente.';
COMMENT ON COLUMN Informacion_Cliente.calle_cliente IS 'Calle donde vive el cliente.';
COMMENT ON COLUMN Informacion_Cliente.numero_cliente IS 'Numero de donde reside el cliente.';
COMMENT ON COLUMN Informacion_Cliente.CP_cliente IS 'Código postal de donde vive el cliente.';
COMMENT ON COLUMN Informacion_Cliente.tipo_cliente IS 'Si el cliente es Academico, Trabajador o Estudiante.';
COMMENT ON COLUMN Informacion_Cliente.fotografia_cliente IS 'Ruta de la fotografía del cliente.';
COMMENT ON COLUMN Informacion_Cliente.telefono_casa IS 'Teléfono de casa del cliente.';
COMMENT ON COLUMN Informacion_Cliente.telefono_celular_cliente IS 'Teléfono celular del cliente.';
COMMENT ON COLUMN Informacion_Cliente.edificio IS 'Edificio en el que trabaja o estudia el cliente.';
COMMENT ON COLUMN Informacion_Cliente.correo_electronico_cliente IS 'Correo electróńico del cliente.';


CREATE TABLE Cliente(
    CURP	CHAR(18)	NOT NULL	CHECK(CURP SIMILAR TO '[A-Z]{4}[0-9]{6}[H,­M][A-Z]{5}[0-9]{2}'),
    hora_entrada	TIME	NOT NULL 	CHECK(hora_entrada > '07:00:00' AND hora_entrada < '21:00:00'),
    hora_salida		TIME 	NOT NULL	CHECK(hora_salida < '22:00:00' AND hora_salida > '08:00:00'),
    CONSTRAINT PK_Cliente	PRIMARY KEY(CURP));
    
COMMENT ON COLUMN Cliente.CURP IS 'CURP del cliente.';
COMMENT ON COLUMN Cliente.hora_entrada IS 'Hora de entrada del cliente.';
COMMENT ON COLUMN Cliente.hora_salida IS 'Hora de salida del cliente.';

CREATE TABLE Agente(
    num_agente		INT2		NOT NULL	CHECK(num_agente >= 0),
    nombre_agente	VARCHAR(35)	NOT NULL	CHECK(nombre_agente SIMILAR TO '[^0123456789]+'),
    paterno_agente	VARCHAR(35)	NOT NULL	CHECK(paterno_agente SIMILAR TO '[^0123456789]+'),
    materno_agente	VARCHAR(35)	NOT NULL	CHECK(materno_agente SIMILAR TO '[^0123456789]+'),
    ciudad_agente	VARCHAR(40)	NOT NULL	CHECK(ciudad_agente SIMILAR TO '[^0123456789]+'),
    calle_agente	VARCHAR(50)	NOT NULL,
    numero_agente	INT		NOT NULL	CHECK (numero_agente >= 0),
    CP_agente		CHAR(5)		NOT NULL	CHECK(CAST(CP_agente AS INTEGER) > 0),
    telefono_celular_cliente	CHAR(14)		CHECK(telefono_celular_cliente SIMILAR TO '[5]{2}[-]([0-9]{2}[-]){3}[0-9]{2}'),
    correo_electronico_cliente VARCHAR(50) 	 	CHECK(correo_electronico_cliente SIMILAR TO '[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})'),
    CONSTRAINT PK_Agente	PRIMARY KEY (num_agente));

COMMENT ON COLUMN Agente.num_agente IS 'Número del agente.';
COMMENT ON COLUMN Agente.nombre_agente IS 'Nombre del agente.';
COMMENT ON COLUMN Agente.paterno_agente IS 'Apellido paterno del agente.';
COMMENT ON COLUMN Agente.materno_agente IS 'Apellido materno del agente.';
COMMENT ON COLUMN Agente.ciudad_agente IS 'Ciudad donde vive el agente.';
COMMENT ON COLUMN Agente.calle_agente IS 'Calle donde vive el agente.';
COMMENT ON COLUMN Agente.numero_agente IS 'Numero de donde reside el agente.';
COMMENT ON COLUMN Agente.CP_agente IS 'Código postal de donde vive el agente.';

CREATE TABLE Vehiculo(
    num_serie		CHAR(17)	NOT NULL	CHECK (num_serie SIMILAR TO'[0-9][A-Z][0-9][A-Z]{2}[0-9]{4}[A-Z]{2}[0-9]{6}'),
    anio		INT2		NOT NULL	CHECK (anio BETWEEN 1995 AND 2019),
    capacidad		DECIMAL(4)	NOT NULL	CHECK (capacidad > 0),
    marca		VARCHAR(30)	NOT NULL,
    modelo		VARCHAR(40)	NOT NULL,
    num_cilindros	INT2		NOT NULL	CHECK (num_cilindros > 0),
    num_puertas		INT2		NOT NULL	CHECK (num_cilindros >= 2),
    llanta_refaccion	BOOLEAN		NOT NULL,
    tipo_transmision	CHAR(1)		NOT NULL	CHECK (tipo_transmision SIMILAR TO '[EA]'),
    tipo_combustible	CHAR(1)		NOT NULL	CHECK (tipo_combustible SIMILAR TO '[GH]'),
    pasajeros		INT2		NOT NULL	CHECK (pasajeros > 0),
    CONSTRAINT PK_Vehiculo PRIMARY KEY (num_serie));

COMMENT ON COLUMN Vehiculo.num_serie IS 'Número de serie del vehículo';
COMMENT ON COLUMN Vehiculo.anio IS 'Año de fabricación del vehiculo';
COMMENT ON COLUMN Vehiculo.capacidad IS 'Capacidad de tanque del vehiculo';
COMMENT ON COLUMN Vehiculo.marca IS 'Marca del vehiculo';
COMMENT ON COLUMN Vehiculo.modelo IS 'Modelo del vehiculo';
COMMENT ON COLUMN Vehiculo.num_cilindros IS 'Número de cilindros que tiene el vehiculo';
COMMENT ON COLUMN Vehiculo.num_puertas IS 'Número de puertas que tiene el vehiculo';
COMMENT ON COLUMN Vehiculo.llanta_refaccion IS 'Nos permite saber si un vehiculo tiene llanta de refaccion';
COMMENT ON COLUMN Vehiculo.tipo_transmision IS 'Tipo de transmision del vehiculo';
COMMENT ON COLUMN Vehiculo.tipo_combustible IS 'Tipo de combustible del vehiculo';
COMMENT ON COLUMN Vehiculo.pasajeros IS 'Capacidad de pasajeros en el vehiculo';

CREATE TABLE Vehiculo_Asociado(
    num_economico	INT2		NOT NULL	CHECK(num_economico > 0),
    RFC			VARCHAR(13)	NOT NULL,
    CONSTRAINT PK_Vehiculo_Asociado PRIMARY KEY (num_economico),
    CONSTRAINT FK_Vehiculo_Asociado_RFC FOREIGN KEY (RFC)  REFERENCES Asociado(RFC) 
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE);

COMMENT ON COLUMN Vehiculo_Asociado.num_economico IS 'Número economico de un vehiculo en la compañia';
COMMENT ON COLUMN Vehiculo_Asociado.RFC IS 'RFC del dueño de un vehiculo en la compañia';

CREATE TABLE Ser(
    num_economico 	INT2			NOT NULL,
    num_serie		CHAR(17)		NOT NULL,
    CONSTRAINT PK_Ser PRIMARY KEY (num_economico, num_serie),
    CONSTRAINT FK_Ser_num_economico FOREIGN KEY (num_economico)  REFERENCES Vehiculo_Asociado(num_economico) 
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_Ser_num_serie FOREIGN KEY (num_serie)  REFERENCES Vehiculo(num_serie) 
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE);

COMMENT ON COLUMN Ser.num_economico IS 'Número economico de un vehiculo en la compañía';
COMMENT ON COLUMN Ser.num_serie IS 'Número de serie de un vehiculo';


CREATE TABLE Conducir(
    num_economico 	INT2		NOT NULL,
    RFC			CHAR(13)	NOT NULL,
    CONSTRAINT PK_Conducir 	PRIMARY KEY (num_economico, RFC),
    CONSTRAINT FK_Conducir_RFC FOREIGN KEY (RFC)  REFERENCES Asociado(RFC) 
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_Conducir_num_economico FOREIGN KEY (num_economico)  REFERENCES Vehiculo_Asociado(num_economico) 
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE);

COMMENT ON COLUMN Conducir.num_economico IS 'Número economico del vehículo que maneja el chofer';
COMMENT ON COLUMN Conducir.RFC IS 'RFC del chofer';
    
CREATE TABLE Viaje(
    id_viaje		INT2		NOT NULL	CHECK(id_viaje >= 0),
    CURP		CHAR(18)	NOT NULL,
    RFC 		CHAR(13)	NOT NULL, 
    num_economico 	INT2		NOT NULL,
    tiempo		TIME		NOT NULL,
    distancia		DECIMAL(4)	NOT NULL	CHECK(distancia > 0.25),
    lugar_origen	VARCHAR(250)	NOT NULL,
    lugar_destino	VARCHAR(250)	NOT NULL,
    fecha_viaje		DATE		NOT NULL	CHECK(fecha_viaje BETWEEN '01-01-2000' AND NOW()),
    CONSTRAINT PK_Viaje	PRIMARY KEY (id_viaje, CURP),
    CONSTRAINT FK_CURP_Viaje FOREIGN KEY (CURP) REFERENCES Cliente(CURP) 
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT FK_num_economico_Viaje FOREIGN KEY (num_economico) REFERENCES	Vehiculo_Asociado(num_economico) 
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_RFC_Viaje FOREIGN KEY (RFC) REFERENCES Asociado(RFC)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE);
    
COMMENT ON COLUMN Viaje.id_viaje IS 'Identificador para cada viaje.';
COMMENT ON COLUMN Viaje.CURP IS 'CURP del pasajero.';
COMMENT ON COLUMN Viaje.num_economico IS 'número económico del vehículo del viaje.';
COMMENT ON COLUMN Viaje.tiempo IS 'Tiempo que duró el viaje.';
COMMENT ON COLUMN Viaje.distancia IS 'Distancia del viaje';
COMMENT ON COLUMN Viaje.lugar_origen IS 'Origenes que tuvo.';
COMMENT ON COLUMN Viaje.lugar_destino IS 'Destinos que tuvo.';
COMMENT ON COLUMN Viaje.fecha_viaje IS 'Fecha en que serealizó el viaje.';

 CREATE TABLE Cobro(
    id_cobro	INT2	NOT NULL	CHECK (id_cobro >= 0),
    id_viaje	INT2	NOT NULL,
    CURP	CHAR(18)	NOT NULL,
    descuento 	INT2	NOT NULL	CHECK (descuento > 0),
    monto	MONEY	NOT NULL	CHECK (monto > CAST(5 AS MONEY)),
    monto_final	MONEY	NOT NULL	CHECK (monto_final > CAST(5 AS MONEY)),
    CONSTRAINT PK_Cobro PRIMARY KEY (id_cobro, id_viaje),
    CONSTRAINT FK_Cobro_Viaje FOREIGN KEY (id_viaje, CURP) REFERENCES Viaje(id_viaje, CURP)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT);

COMMENT ON COLUMN Cobro.id_cobro IS 'Identificador del cobro.';
COMMENT ON COLUMN Cobro.id_viaje IS 'Identificador del viaje del cobro';
COMMENT ON COLUMN Cobro.descuento IS 'Descuento del cobro';
COMMENT ON COLUMN Cobro.monto IS 'Monto a pagar por el cobro';
COMMENT ON COLUMN Cobro.monto_final IS 'Monto final a pagar del cobro';

CREATE TABLE Ganancias(
    id_ganancia INT2		NOT NULL	CHECK(id_ganancia>0),
    id_viaje	INT2		NOT NULL,
    CURP	CHAR(18)	NOT NULL,
    RFC		CHAR(13)	NOT NULL,
    ganancia	MONEY		NOT NULL	CHECK (ganancia >= CAST(1 AS MONEY)),
    esBono	BOOLEAN		NOT NULL,
    CONSTRAINT PK_Ganancias PRIMARY KEY (id_ganancia),
    CONSTRAINT FK_Ganancias_Viaje FOREIGN KEY (id_viaje,CURP) REFERENCES Viaje(id_viaje,CURP)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT FK_Ganancias_Asociado FOREIGN KEY (RFC) REFERENCES Asociado(RFC)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_Ganancias_Cliente FOREIGN KEY (CURP) REFERENCES Cliente(CURP)
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE);

COMMENT ON COLUMN Ganancias.id_ganancia IS 'Identificador de la ganancia.';
COMMENT ON COLUMN Ganancias.id_viaje IS 'Identificador del viaje que generó la ganancia.';
COMMENT ON COLUMN Ganancias.CURP IS 'Cliente que utilizó el servicio.';
COMMENT ON COLUMN Ganancias.RFC IS 'Chofer a quien se le da la ganancia.';
COMMENT ON COLUMN Ganancias.ganancia IS 'Ganancia del chofer respecto al viaje y cobro';
COMMENT ON COLUMN Ganancias.esBono IS 'Nos permite saber si una ganancia es un bono.';

CREATE TABLE Multa(
    num_multa		INT2		NOT NULL	CHECK (num_multa > 0),
    num_economico	INT2		NOT NULL,
    num_agente		INT2		NOT NULL,
    RFC			CHAR(13)	NOT NULL,
    articulo		INT2		NOT NULL	CHECK (articulo > 0),
    hora		TIME		NOT NULL,
    monto		MONEY		NOT NULL	CHECK (monto > CAST(0 AS MONEY)),
    fecha_infraccion	DATE		NOT NULL	CHECK (fecha_infraccion <= NOW()),
    calle_infraccion	VARCHAR(40)	NOT NULL,
    ciudad_infraccion	VARCHAR(40)	NOT NULL,
    CP_infraccion	CHAR(5)		NOT NULL	CHECK(CAST(CP_infraccion AS INTEGER) > 0),
    monto_final		MONEY		NOT NULL	CHECK (monto_final > CAST(0 AS MONEY)),
    CONSTRAINT PK_Multa PRIMARY KEY (num_multa),
    CONSTRAINT FK_Multa_num_economico FOREIGN KEY (num_economico)  REFERENCES Vehiculo_Asociado(num_economico) 
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_Multa_num_agente FOREIGN KEY (num_agente)  REFERENCES Agente(num_agente) 
    MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT FK_Multa_RFC FOREIGN KEY (RFC)  REFERENCES Asociado(RFC) 
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE);

COMMENT ON COLUMN Multa.num_multa IS 'Número de la multa';
COMMENT ON COLUMN Multa.num_economico IS 'Número económico del vehículo al que se le asigna la multa';
COMMENT ON COLUMN Multa.num_agente IS 'Número de agente que pone la multa';
COMMENT ON COLUMN Multa.RFC IS 'RFC del conductor que cometió la multa';
COMMENT ON COLUMN Multa.articulo IS 'Número del artículo que no se cumplió';
COMMENT ON COLUMN Multa.hora IS 'Hora en que se cometió la multa';
COMMENT ON COLUMN Multa.monto IS 'Monto por la multa';
COMMENT ON COLUMN Multa.fecha_infraccion IS 'Fecha en que se cometió la multa';
COMMENT ON COLUMN Multa.calle_infraccion IS 'Calle donde se cometió la multa';
COMMENT ON COLUMN Multa.ciudad_infraccion IS 'Ciudad donde se cometió la multa';
COMMENT ON COLUMN Multa.CP_infraccion IS 'Código postal donde se cometió la multa';

CREATE TABLE Aseguradora(
    num_sucursal	INT2		NOT NULL	CHECK (num_sucursal > 0),
    nombre		VARCHAR(50)	NOT NULL,
    horario_apertura	TIME		NOT NULL,
    horario_cierre	TIME		NOT NULL,
    CONSTRAINT PK_Aseguradora PRIMARY KEY (num_sucursal));

COMMENT ON COLUMN Aseguradora.num_sucursal IS 'Número de la sucursal de la aseguradora';
COMMENT ON COLUMN Aseguradora.nombre IS 'Nombre de la aseguradora';
COMMENT ON COLUMN Aseguradora.horario_apertura IS 'Horario de apertura de la aseguradora';
COMMENT ON COLUMN Aseguradora.horario_cierre IS 'Horario de cierre de la aseguradora';

CREATE TABLE Log_vehiculo(
    id_log_vehiculo	INT2		NOT NULL	CHECK (id_log_vehiculo>0),
    num_economico	INT2		NOT NULL	CHECK(num_economico > 0),
    razon		VARCHAR(150)	NOT NULL,
    baja		DATE		NOT NULL	CHECK (baja <= NOW()),
    CONSTRAINT PK_Log_vehiculo PRIMARY KEY (id_log_vehiculo));

COMMENT ON COLUMN Log_vehiculo.id_log_vehiculo IS 'Identificador del vehículo';
COMMENT ON COLUMN Log_vehiculo.num_economico IS 'Número económico del vehículo';
COMMENT ON COLUMN Log_vehiculo.razon IS 'Razón por la que el vehículo deja la compañia';
COMMENT ON COLUMN Log_vehiculo.baja IS 'Fecha en la que el vehículo se da de baja';

CREATE TABLE Borrar(
    num_economico	INT2		NOT NULL,
    id_log_vehiculo	INT2		NOT NULL,
    razon		VARCHAR(50)	NOT NULL,
    fecha_baja		DATE		NOT NULL	CHECK (fecha_baja <= NOW()),
    CONSTRAINT PK_Borrar PRIMARY KEY (num_economico, id_log_vehiculo),
    CONSTRAINT FK_Borrar_num_economico FOREIGN KEY (num_economico)  REFERENCES Vehiculo_Asociado(num_economico) 
    MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_Ser_id_log_vehiculo FOREIGN KEY (id_log_vehiculo)  REFERENCES Log_vehiculo(id_log_vehiculo) 
    MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION);

COMMENT ON COLUMN Borrar.num_economico IS 'Número económico del vehículo a borrar';
COMMENT ON COLUMN Borrar.id_log_vehiculo IS 'Identificador del historico del vehículo a borrar';
COMMENT ON COLUMN Borrar.razon IS 'Razón por la que el vehículo deja la compañía';
COMMENT ON COLUMN Borrar.fecha_baja IS 'Fecha en que se borra el vehiculo';


CREATE TABLE Seguro_vehiculo(
    num_serie		CHAR(17)	NOT NULL	CHECK (num_serie SIMILAR TO'[0-9][A-Z][0-9][A-Z]{2}[0-9]{4}[A-Z]{2}[0-9]{6}'),
    num_sucursal	INT2		NOT NULL	CHECK (num_sucursal > 0),
    cobertura		VARCHAR(30)	NOT NULL,
    CONSTRAINT PK_Seguro_vehiculo 	PRIMARY KEY (num_serie),
    CONSTRAINT FK_Seguro_vehiculo_num_sucursal FOREIGN KEY (num_sucursal)  REFERENCES Aseguradora(num_sucursal) 
    MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION);

COMMENT ON COLUMN Seguro_vehiculo.num_serie IS 'Número de serie del vehículo a asegurar';
COMMENT ON COLUMN Seguro_vehiculo.num_sucursal IS 'Sucursal que asegura al vehículo';
COMMENT ON COLUMN Seguro_vehiculo.cobertura IS 'Tipo de servicio que cubre la aseguradora';


