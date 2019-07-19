CREATE SCHEMA Empresa;
DROP SCHEMA Public;
--Crea la Tabla Empleado en el esquema Empresa
CREATE TABLE Empresa.Empleado(
	nombre	VARCHAR(30) not null,
	materno	VARCHAR(30),
	paterno	VARCHAR(30),
	f_nac	DATE,
	CURP	char(18),
	num		DECIMAL(4),
	calle	VARCHAR(80),
	ciudad	VARCHAR(40),
	CP 		DECIMAL(5),
	CONSTRAINT	PK_Empleado	PRIMARY KEY(CURP));

COMMENT ON TABLE Empresa.Empleado IS 'Tabla que contiene los Empleados.';
COMMENT ON COLUMN Empresa.Empleado.CURP IS 'Identificador del Empleado.';
COMMENT ON COLUMN Empresa.Empleado.nombre IS 'Nombre del Empleado.';
COMMENT ON COLUMN Empresa.Empleado.materno IS 'Apellido materno del Empleado.';
COMMENT ON COLUMN Empresa.Empleado.materno IS 'Apellido paterno del Empleado.';
COMMENT ON COLUMN Empresa.Empleado.f_nac IS 'fecha de nacimiento del Empleado.';
COMMENT ON COLUMN Empresa.Empleado.num IS 'numero de calle del Empleado.';
COMMENT ON COLUMN Empresa.Empleado.calle IS 'Calle del Empleado.';
COMMENT ON COLUMN Empresa.Empleado.ciudad IS 'Ciudad del Empleado.';
COMMENT ON COLUMN Empresa.Empleado.CP IS 'CP del Empleado.';


--Crea la Tabla empresa en el esquema Empresa
CREATE TABLE Empresa.empresa(
	RFC				char(12),
	razon_social	VARCHAR(50) unique,
	num		DECIMAL(4),
	calle	VARCHAR(80),
	ciudad	VARCHAR(40),
	CP 		DECIMAL(5),
	CONSTRAINT	PK_empresa	PRIMARY KEY(RFC));

COMMENT ON TABLE Empresa.empresa IS 'Tabla que contiene las Empresas.';
COMMENT ON COLUMN Empresa.empresa.RFC IS 'Identificador de la Empresa.';
COMMENT ON COLUMN Empresa.empresa.num IS 'numero de calle de la empresa.';
COMMENT ON COLUMN Empresa.empresa.calle IS 'Calle de la empresa.';
COMMENT ON COLUMN Empresa.empresa.ciudad IS 'Ciudad de la empresa.';
COMMENT ON COLUMN Empresa.empresa.CP IS 'CP de la empresa.';

--Crea la Tabla Empleado en el esquema Empresa
CREATE TABLE Empresa.Proyecto(
	numProy			Decimal(50),
	nombre			VARCHAR(30) not null,
	fecha_inicio	DATE,
	fecha_fin		DATE,
	RFC 			char(12),
	CURP			char(18),
	numHoras		DECIMAL(4),
	CONSTRAINT	PK_Proyecto	PRIMARY KEY(numProy),
	CONSTRAINT FK_1 FOREIGN KEY (RFC) REFERENCES Empresa.empresa(RFC) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE No action,
	CONSTRAINT FK_2 FOREIGN KEY (CURP) REFERENCES Empresa.Empleado(CURP) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE No action); 

COMMENT ON TABLE Empresa.Proyecto IS 'Tabla que contiene los Proyecto.';
COMMENT ON COLUMN Empresa.Proyecto.numProy IS 'Identificador del Proyecto.';
COMMENT ON COLUMN Empresa.Proyecto.fecha_inicio IS 'fecha de inicio del proyecto.';
COMMENT ON COLUMN Empresa.Proyecto.fecha_fin IS 'fecha de fin del proyecto.';
COMMENT ON COLUMN Empresa.Proyecto.RFC IS 'RFC del Empleado.';
COMMENT ON COLUMN Empresa.Proyecto.CURP IS 'CURP del Empleado.';
COMMENT ON COLUMN Empresa.Proyecto.numHoras IS 'numHoras del Proyecto';


CREATE TABLE Empresa.supervisar(
	CURP_Supervisor 		CHAR(18),
	CURP_Supervisado		CHAR(18),
	CONSTRAINT	PK_supervisar	PRIMARY KEY(CURP_Supervisado,CURP_Supervisor),
	CONSTRAINT FK_3 FOREIGN KEY (CURP_Supervisado) REFERENCES Empresa.Empleado(CURP) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE No action,
	CONSTRAINT FK_4 FOREIGN KEY (CURP_Supervisor) REFERENCES Empresa.Empleado(CURP) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE No action);




CREATE TABLE Empresa.Dirigir(
	RFC 				CHAR(12),
	CURP 				CHAR(18),
	fecha_inicio		DATE not null,
	CONSTRAINT PK_Dirigir PRIMARY KEY (RFC,CURP,fecha_inicio),
	CONSTRAINT FK_5 FOREIGN KEY (RFC) REFERENCES Empresa.empresa(RFC) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_6 FOREIGN KEY (CURP) REFERENCES Empresa.Empleado(CURP) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE);
      

COMMENT ON TABLE Empresa.Dirigir IS 'Tabla que contiene los Directores.';
COMMENT ON COLUMN Empresa.Dirigir.RFC IS 'RFC del Empleado.';
COMMENT ON COLUMN Empresa.Dirigir.CURP IS 'CURP del Empleado.';
COMMENT ON COLUMN Empresa.Dirigir.fecha_inicio IS 'fecha_inicio de la direccion del Empleado.';


CREATE TABLE Empresa.Trabajar(
	Salario				DECIMAL(20),
	fecha_ingreso		DATE not null,
	RFC 				CHAR(12),
	CURP 				CHAR(18),
	CONSTRAINT PK_Trabajar PRIMARY KEY (Salario,RFC,CURP,fecha_ingreso),
	CONSTRAINT FK_7 FOREIGN KEY (RFC) REFERENCES Empresa.empresa(RFC) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_8 FOREIGN KEY (CURP) REFERENCES Empresa.Empleado(CURP) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE);
      
COMMENT ON TABLE Empresa.Trabajar IS 'Tabla que contiene los Trabajadores.';
COMMENT ON COLUMN Empresa.Trabajar.RFC IS 'RFC del Empleado.';
COMMENT ON COLUMN Empresa.Trabajar.CURP IS 'CURP del Empleado.';
COMMENT ON COLUMN Empresa.Trabajar.fecha_ingreso IS 'fecha_ingreso del trabajador.';
