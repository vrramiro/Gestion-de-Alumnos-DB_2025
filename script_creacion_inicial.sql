/* =========================================================
= = = = = = = =  0) LIMPIEZA / PREP DEL ESQUEMA  = = = = = =
========================================================= */

-- Dropeo de procedures
IF OBJECT_ID('DB_2025.migrar_provincia', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_provincia;
IF OBJECT_ID('DB_2025.migrar_localidad', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_localidad;
IF OBJECT_ID('DB_2025.migrar_institucion', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_institucion;
IF OBJECT_ID('DB_2025.migrar_sede', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_sede;
IF OBJECT_ID('DB_2025.migrar_categoria', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_categoria;
IF OBJECT_ID('DB_2025.migrar_turno', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_turno;
IF OBJECT_ID('DB_2025.migrar_profesor', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_profesor;
IF OBJECT_ID('DB_2025.migrar_alumno', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_alumno;
IF OBJECT_ID('DB_2025.migrar_curso', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_curso;
IF OBJECT_ID('DB_2025.migrar_dia', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_dia;
IF OBJECT_ID('DB_2025.migrar_curso_dia', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_curso_dia;
IF OBJECT_ID('DB_2025.migrar_modulo', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_modulo;
IF OBJECT_ID('DB_2025.migrar_estado_inscripcion', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_estado_inscripcion;
IF OBJECT_ID('DB_2025.migrar_inscripcion', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_inscripcion;
IF OBJECT_ID('DB_2025.migrar_evaluacion', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_evaluacion;
IF OBJECT_ID('DB_2025.migrar_trabajo_practico', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_trabajo_practico;
IF OBJECT_ID('DB_2025.migrar_instancia_final', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_instancia_final;
IF OBJECT_ID('DB_2025.migrar_evaluacion_final', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_evaluacion_final;
IF OBJECT_ID('DB_2025.migrar_inscripcion_final', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_inscripcion_final;
IF OBJECT_ID('DB_2025.migrar_pregunta', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_pregunta;
IF OBJECT_ID('DB_2025.migrar_encuesta', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_encuesta;
IF OBJECT_ID('DB_2025.migrar_respuesta', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_respuesta;
IF OBJECT_ID('DB_2025.migrar_factura', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_factura;
IF OBJECT_ID('DB_2025.migrar_detalle_factura', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_detalle_factura;
IF OBJECT_ID('DB_2025.migrar_medio_pago', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migrar_medio_pago;
IF OBJECT_ID('DB_2025.migra_pago', 'P') IS NOT NULL DROP PROCEDURE DB_2025.migra_pago;
GO

-- Dropear de tablas
IF OBJECT_ID('DB_2025.Respuesta', 'U') IS NOT NULL DROP TABLE DB_2025.Respuesta;
IF OBJECT_ID('DB_2025.Pregunta', 'U')   IS NOT NULL DROP TABLE DB_2025.Pregunta;
IF OBJECT_ID('DB_2025.Encuesta', 'U')   IS NOT NULL DROP TABLE DB_2025.Encuesta;

IF OBJECT_ID('DB_2025.Pago', 'U')              IS NOT NULL DROP TABLE DB_2025.Pago;
IF OBJECT_ID('DB_2025.Medio_Pago', 'U')        IS NOT NULL DROP TABLE DB_2025.Medio_Pago;
IF OBJECT_ID('DB_2025.Detalle_Factura', 'U')   IS NOT NULL DROP TABLE DB_2025.Detalle_Factura;
IF OBJECT_ID('DB_2025.Factura', 'U')           IS NOT NULL DROP TABLE DB_2025.Factura;

IF OBJECT_ID('DB_2025.Evaluacion', 'U')        IS NOT NULL DROP TABLE DB_2025.Evaluacion;
IF OBJECT_ID('DB_2025.Modulo', 'U')            IS NOT NULL DROP TABLE DB_2025.Modulo;
IF OBJECT_ID('DB_2025.Curso_Dia', 'U')         IS NOT NULL DROP TABLE DB_2025.Curso_Dia;
IF OBJECT_ID('DB_2025.Dia', 'U')               IS NOT NULL DROP TABLE DB_2025.Dia;
IF OBJECT_ID('DB_2025.Inscripcion', 'U')       IS NOT NULL DROP TABLE DB_2025.Inscripcion;
IF OBJECT_ID('DB_2025.Estado_Inscripcion', 'U')IS NOT NULL DROP TABLE DB_2025.Estado_Inscripcion;
IF OBJECT_ID('DB_2025.Inscripcion_Final', 'U') IS NOT NULL DROP TABLE DB_2025.Inscripcion_Final;
IF OBJECT_ID('DB_2025.Evaluacion_Final', 'U')  IS NOT NULL DROP TABLE DB_2025.Evaluacion_Final;
IF OBJECT_ID('DB_2025.Instancia_Final', 'U')   IS NOT NULL DROP TABLE DB_2025.Instancia_Final;
IF OBJECT_ID('DB_2025.Trabajo_Practico', 'U')  IS NOT NULL DROP TABLE DB_2025.Trabajo_Practico;

IF OBJECT_ID('DB_2025.Curso', 'U')             IS NOT NULL DROP TABLE DB_2025.Curso;
IF OBJECT_ID('DB_2025.Turno', 'U')             IS NOT NULL DROP TABLE DB_2025.Turno;
IF OBJECT_ID('DB_2025.Categoria', 'U')         IS NOT NULL DROP TABLE DB_2025.Categoria;

IF OBJECT_ID('DB_2025.Sede', 'U')              IS NOT NULL DROP TABLE DB_2025.Sede;
IF OBJECT_ID('DB_2025.Institucion', 'U')       IS NOT NULL DROP TABLE DB_2025.Institucion;
IF OBJECT_ID('DB_2025.Alumno', 'U')            IS NOT NULL DROP TABLE DB_2025.Alumno;
IF OBJECT_ID('DB_2025.Profesor', 'U')          IS NOT NULL DROP TABLE DB_2025.Profesor;
IF OBJECT_ID('DB_2025.Localidad', 'U')         IS NOT NULL DROP TABLE DB_2025.Localidad;
IF OBJECT_ID('DB_2025.Provincia', 'U')         IS NOT NULL DROP TABLE DB_2025.Provincia;
GO

-- Dropear y recrear el esquema limpio
IF SCHEMA_ID('DB_2025') IS NULL
BEGIN
    EXEC('CREATE SCHEMA DB_2025;');
END
GO

/* =========================================================
= = = = = = = =  1) UBICACIÓN / ACTORES / CATÁLOGOS  = = = =
= (Provincia, Localidad, Institucion, Sede, Categoria,     =
=  Turno, Profesor, Alumno)                                =
========================================================= */

-- 1.1) Provincia y Localidad (Localidad depende de Provincia)
CREATE TABLE DB_2025.Provincia (
    provincia_nombre NVARCHAR(255) PRIMARY KEY
);
GO

CREATE TABLE DB_2025.Localidad (
    codigo_localidad BIGINT IDENTITY(1,1) PRIMARY KEY,
    nombre           NVARCHAR(255),
    provincia        NVARCHAR(255),
    FOREIGN KEY (provincia) REFERENCES DB_2025.Provincia(provincia_nombre)
);
GO

-- 1.2) Institución y Sede (Sede depende de Institución y Localidad)
CREATE TABLE DB_2025.Institucion (
    cuit         NVARCHAR(255) PRIMARY KEY,
    nombre       NVARCHAR(255),
    razon_social NVARCHAR(255)
);
GO

CREATE TABLE DB_2025.Sede (
    id_sede           BIGINT IDENTITY(1,1) PRIMARY KEY,
    cuit_institucion  NVARCHAR(255),
    nombre            NVARCHAR(255),
    direccion         NVARCHAR(255),
    codigo_localidad         BIGINT,
    telefono          NVARCHAR(255),
    mail              NVARCHAR(255),
    FOREIGN KEY (codigo_localidad)        REFERENCES DB_2025.Localidad(codigo_localidad),
    FOREIGN KEY (cuit_institucion) REFERENCES DB_2025.Institucion(cuit)
);
GO

-- 1.3) Catálogos varios (Categoria, Turno)
CREATE TABLE DB_2025.Categoria (
    id_categoria     BIGINT IDENTITY(1,1) PRIMARY KEY,
    nombre_categoria VARCHAR(255)
);
GO

CREATE TABLE DB_2025.Turno (
    nombre VARCHAR(255) PRIMARY KEY
);
GO

-- 1.4) Actores (Profesor, Alumno) — ojo con tipos de DNI
CREATE TABLE DB_2025.Profesor (
    id_profesor      BIGINT IDENTITY(1,1) PRIMARY KEY,
    nombre           NVARCHAR(255),
    apellido         NVARCHAR(255),
    dni              NVARCHAR(255),  -- según Maestra, NVARCHAR
    fecha_nacimiento DATETIME2(6),
    mail             NVARCHAR(255),
    direccion        NVARCHAR(255),
    codigo_localidad BIGINT,
    telefono         NVARCHAR(255),
    FOREIGN KEY (codigo_localidad) REFERENCES DB_2025.Localidad(codigo_localidad)
);
GO

CREATE TABLE DB_2025.Alumno (
    legajo           BIGINT PRIMARY KEY,
    dni              BIGINT,         -- según Maestra, BIGINT
    nombre           VARCHAR(255),
    apellido         VARCHAR(255),
    fecha_nacimiento DATETIME2(6),
    mail             VARCHAR(255),
    direccion        VARCHAR(255),
    codigo_localidad        BIGINT,
    telefono         VARCHAR(255),
    FOREIGN KEY (codigo_localidad) REFERENCES DB_2025.Localidad(codigo_localidad)
);
GO


/* =========================================================
= = = = = = = = = =  2) CURSOS Y ESTRUCTURA  = = = = = = = =
= (Curso, Dia, Curso_Dia, Modulo)                           =
========================================================= */

CREATE TABLE DB_2025.Curso (
    codigo_curso   BIGINT PRIMARY KEY,
    nombre         VARCHAR(255),
    fecha_inicio   DATETIME2(6),
    fecha_fin      DATETIME2(6),
    duracion_meses BIGINT,
    precio_mensual DECIMAL(38,2),
    profesor       BIGINT,
    categoria      BIGINT,
    sede           BIGINT,
    turno_curso    VARCHAR(255),
    descripcion    VARCHAR(255),
    FOREIGN KEY (categoria)   REFERENCES DB_2025.Categoria(id_categoria),
    FOREIGN KEY (profesor)    REFERENCES DB_2025.Profesor(id_profesor),
    FOREIGN KEY (sede)        REFERENCES DB_2025.Sede(id_sede),
    FOREIGN KEY (turno_curso) REFERENCES DB_2025.Turno(nombre)
);
GO

CREATE TABLE DB_2025.Dia (
    nombre_dia VARCHAR(10) PRIMARY KEY
);
GO

CREATE TABLE DB_2025.Curso_Dia (
    codigo_curso BIGINT,
    dia      VARCHAR(10),
    PRIMARY KEY (codigo_curso, dia),
    FOREIGN KEY (codigo_curso) REFERENCES DB_2025.Curso(codigo_curso),
    FOREIGN KEY (dia)      REFERENCES DB_2025.Dia(nombre_dia)
);
GO

CREATE TABLE DB_2025.Modulo (
    id_modulo    BIGINT IDENTITY(1,1) PRIMARY KEY,
    codigo_curso BIGINT,
    nombre       VARCHAR(255),
    descripcion  VARCHAR(255),
    FOREIGN KEY (codigo_curso) REFERENCES DB_2025.Curso(codigo_curso)
);
GO

/* =========================================================
= = = = = = =  3) INSCRIPCIONES Y EVALUACIÓN REGULAR  = = = =
= (Estado_Inscripcion, Inscripcion, Evaluacion, TP)         =
========================================================= */

CREATE TABLE DB_2025.Estado_Inscripcion (
    estado VARCHAR(255) PRIMARY KEY
);
GO

CREATE TABLE DB_2025.Inscripcion (
    nro_inscripcion   BIGINT PRIMARY KEY,
    legajo            BIGINT,
    codigo_curso          BIGINT,
    fecha_inscripcion DATETIME2(6),
    estado            VARCHAR(255),
    fecha_respuesta   DATETIME2(6),
    FOREIGN KEY (estado)  REFERENCES DB_2025.Estado_Inscripcion(estado),
    FOREIGN KEY (legajo)  REFERENCES DB_2025.Alumno(legajo),
    FOREIGN KEY (codigo_curso)REFERENCES DB_2025.Curso(codigo_curso)
);
GO

CREATE TABLE DB_2025.Evaluacion (
    id_evaluacion BIGINT IDENTITY(1,1) PRIMARY KEY,
    id_modulo     BIGINT,
    alumno_legajo BIGINT,
    nota          BIGINT,
    fecha         DATETIME2(6),
    instancia     BIGINT,
    presente      BIT,
    FOREIGN KEY (id_modulo) REFERENCES DB_2025.Modulo(id_modulo),
    FOREIGN KEY (alumno_legajo) REFERENCES DB_2025.Alumno(legajo)
);
GO

CREATE TABLE DB_2025.Trabajo_Practico (
    id_trabajo_practico BIGINT IDENTITY(1,1) PRIMARY KEY,
    legajo_alumno       BIGINT,
    codigo_curso        BIGINT,
    nota                BIGINT,
    fecha_evaluacion    DATETIME2(6),
    FOREIGN KEY (legajo_alumno) REFERENCES DB_2025.Alumno(legajo),
    FOREIGN KEY (codigo_curso)  REFERENCES DB_2025.Curso(codigo_curso)
);
GO


/* =========================================================
= = = = = = = =  4) FINALES / INSTANCIAS / EXÁMENES  = = = =
= (Instancia_Final, Evaluacion_Final, Inscripcion_Final)    =
========================================================= */

CREATE TABLE DB_2025.Instancia_Final (
    id_instancia BIGINT IDENTITY(1,1) PRIMARY KEY,
    codigo_curso BIGINT,
    fecha_final  DATETIME2(6),
    hora_final   VARCHAR(255),
    FOREIGN KEY (codigo_curso) REFERENCES DB_2025.Curso(codigo_curso)
);
GO

CREATE TABLE DB_2025.Evaluacion_Final (
    id_examen_final BIGINT IDENTITY(1,1) PRIMARY KEY,
    id_profesor     BIGINT,
    id_instancia    BIGINT,
    legajo_alumno   BIGINT,
    nota            BIGINT,
    presente        BIT,
    descripcion     VARCHAR(255),
    FOREIGN KEY (id_profesor)   REFERENCES DB_2025.Profesor(id_profesor),
    FOREIGN KEY (id_instancia)  REFERENCES DB_2025.Instancia_Final(id_instancia),
    FOREIGN KEY (legajo_alumno) REFERENCES DB_2025.Alumno(legajo)
);
GO

CREATE TABLE DB_2025.Inscripcion_Final (
    numero_inscripcion BIGINT PRIMARY KEY,
    legajo_alumno      BIGINT,
    id_instancia       BIGINT,
    fecha_inscripcion  DATETIME2(6),
    FOREIGN KEY (legajo_alumno) REFERENCES DB_2025.Alumno(legajo),
    FOREIGN KEY (id_instancia)  REFERENCES DB_2025.Instancia_Final(id_instancia)
);
GO


/* =========================================================
= = = = =  5) ENCUESTAS / PREGUNTAS / RESPUESTAS  = = = = =
= (Pregunta, Encuesta, Observacion, Respuesta)              =
========================================================= */

CREATE TABLE DB_2025.Pregunta (
    id_pregunta    BIGINT IDENTITY(1,1) PRIMARY KEY,
    pregunta_texto VARCHAR(255)
);
GO

CREATE TABLE DB_2025.Encuesta (
    id_encuesta    BIGINT IDENTITY(1,1) PRIMARY KEY,
    codigo_curso   BIGINT,
    fecha_registro DATETIME2(6),
    observacion    VARCHAR(255) NULL,
    FOREIGN KEY (codigo_curso)  REFERENCES DB_2025.Curso(codigo_curso)
);
GO

CREATE TABLE DB_2025.Respuesta (
    id_respuesta BIGINT IDENTITY(1,1) PRIMARY KEY,
    id_encuesta  BIGINT,
    id_pregunta  BIGINT,
    nota_dada    BIGINT,
    FOREIGN KEY (id_encuesta) REFERENCES DB_2025.Encuesta(id_encuesta),
    FOREIGN KEY (id_pregunta) REFERENCES DB_2025.Pregunta(id_pregunta)
);
GO


/* =========================================================
= = = = = = = = = = =  6) FACTURACIÓN  = = = = = = = = = = =
= (Factura, Detalle_Factura, Pago)                          =
========================================================= */

CREATE TABLE DB_2025.Factura (
    numero_factura    BIGINT PRIMARY KEY,
    fecha_emision     DATETIME2(6),
    fecha_vencimiento DATETIME2(6),
    legajo_alumno     BIGINT,
    total             DECIMAL(18,2),
    FOREIGN KEY (legajo_alumno) REFERENCES DB_2025.Alumno(legajo)
);
GO

CREATE TABLE DB_2025.Detalle_Factura (
    numero_factura BIGINT,
    codigo_curso   BIGINT,
    periodo_anio   BIGINT,
    periodo_mes    BIGINT,
    importe        DECIMAL(18,2),
    PRIMARY KEY (numero_factura, codigo_curso),
    FOREIGN KEY (numero_factura) REFERENCES DB_2025.Factura(numero_factura),
    FOREIGN KEY (codigo_curso)       REFERENCES DB_2025.Curso(codigo_curso)
);
GO

CREATE TABLE DB_2025.Medio_Pago (
    id_medio     BIGINT PRIMARY KEY IDENTITY(1, 1),
    nombre_medio VARCHAR(255)
)

CREATE TABLE DB_2025.Pago (
    id_pago        BIGINT PRIMARY KEY IDENTITY(1, 1),
    numero_factura BIGINT,
    fecha          DATETIME2(6),
    importe        DECIMAL(18,2),
    medio_pago     BIGINT,
    FOREIGN KEY (numero_factura) REFERENCES DB_2025.Factura(numero_factura),
    FOREIGN KEY (medio_pago) REFERENCES DB_2025.Medio_Pago(id_medio)
);
GO

-- Ubicación / Actores / Catálogos
CREATE INDEX IX_Localidad_provincia      ON DB_2025.Localidad(provincia);
CREATE INDEX IX_Sede_localidad           ON DB_2025.Sede(codigo_localidad);
CREATE INDEX IX_Sede_cuit_institucion    ON DB_2025.Sede(cuit_institucion);
CREATE INDEX IX_Profesor_localidad       ON DB_2025.Profesor(codigo_localidad);
CREATE INDEX IX_Alumno_localidad         ON DB_2025.Alumno(codigo_localidad);

-- Cursos y estructura
CREATE INDEX IX_Curso_profesor           ON DB_2025.Curso(profesor);
CREATE INDEX IX_Curso_categoria          ON DB_2025.Curso(categoria);
CREATE INDEX IX_Curso_sede               ON DB_2025.Curso(sede);
CREATE INDEX IX_Modulo_codigo_curso      ON DB_2025.Modulo(codigo_curso);

-- Inscripciones y evaluación regular
CREATE INDEX IX_Inscripcion_legajo       ON DB_2025.Inscripcion(legajo);
CREATE INDEX IX_Inscripcion_curso        ON DB_2025.Inscripcion(codigo_curso);
CREATE INDEX IX_Evaluacion_id_modulo     ON DB_2025.Evaluacion(id_modulo);
CREATE INDEX IX_Evaluacion_alumno_legajo ON DB_2025.Evaluacion(alumno_legajo);
CREATE INDEX IX_TP_legajo_alumno         ON DB_2025.Trabajo_Practico(legajo_alumno);
CREATE INDEX IX_TP_codigo_curso          ON DB_2025.Trabajo_Practico(codigo_curso);

-- Finales / Instancias
CREATE INDEX IX_InstanciaFinal_codigo_curso   ON DB_2025.Instancia_Final(codigo_curso);
CREATE INDEX IX_EvalFinal_id_instancia        ON DB_2025.Evaluacion_Final(id_instancia);
CREATE INDEX IX_EvalFinal_legajo_alumno       ON DB_2025.Evaluacion_Final(legajo_alumno);
CREATE INDEX IX_InsFinal_id_instancia         ON DB_2025.Inscripcion_Final(id_instancia);
CREATE INDEX IX_InsFinal_legajo_alumno        ON DB_2025.Inscripcion_Final(legajo_alumno);

-- Encuestas
CREATE INDEX IX_Encuesta_codigo_curso    ON DB_2025.Encuesta(codigo_curso);
CREATE INDEX IX_Respuesta_id_encuesta    ON DB_2025.Respuesta(id_encuesta);

-- Facturación
CREATE INDEX IX_Factura_legajo_alumno    ON DB_2025.Factura(legajo_alumno);
CREATE INDEX IX_DetalleFactura_codigo_curso  ON DB_2025.Detalle_Factura(codigo_curso);
CREATE INDEX IX_Pago_numero_factura      ON DB_2025.Pago(numero_factura);
CREATE INDEX IX_Pago_medio_pago          ON DB_2025.Pago(medio_pago)

CREATE INDEX IX_Inscripcion_estado       ON DB_2025.Inscripcion(estado);
CREATE INDEX IX_Curso_turno_curso        ON DB_2025.Curso(turno_curso);
CREATE INDEX IX_Respuesta_id_pregunta    ON DB_2025.Respuesta(id_pregunta);
CREATE INDEX IX_EvalFinal_id_profesor    ON DB_2025.Evaluacion_Final(id_profesor);
GO

----------------------
------PROCEDURES------
----------------------

CREATE PROCEDURE DB_2025.migrar_provincia AS
BEGIN TRANSACTION

    INSERT INTO Provincia (provincia_nombre)
    SELECT p.provincia
    FROM (
        SELECT DISTINCT m.Sede_Provincia as provincia
        FROM gd_esquema.Maestra m
        UNION
        SELECT DISTINCT m.Alumno_Provincia as provincia
        FROM gd_esquema.Maestra m
        UNION
        SELECT DISTINCT m.Profesor_Provincia as provincia
        FROM gd_esquema.Maestra m
    ) p
    WHERE p.provincia IS NOT NULL

COMMIT;
GO

CREATE PROCEDURE DB_2025.migrar_localidad AS
BEGIN

    INSERT INTO DB_2025.Localidad(nombre, provincia)
    SELECT l.localidad, l.provincia
    FROM (
        SELECT m.Sede_Localidad as localidad, m.Sede_Provincia as provincia from gd_esquema.Maestra m
        UNION
        SELECT m.Alumno_Localidad as localidad, m.Alumno_Provincia as provincia from gd_esquema.Maestra m
        UNION
        SELECT m.Profesor_Localidad as localidad, m.Profesor_Provincia as provincia from gd_esquema.Maestra m
    ) l
    WHERE l.localidad IS NOT NULL AND l.provincia IS NOT NULL

END;
GO

CREATE PROCEDURE DB_2025.migrar_institucion AS
BEGIN

    INSERT INTO DB_2025.Institucion (cuit, nombre, razon_social)
    SELECT
    DISTINCT m.Institucion_Cuit cuit,
    m.Institucion_Nombre nombre,
    m.Institucion_RazonSocial razon_social
    FROM gd_esquema.Maestra m
    WHERE m.Institucion_Cuit IS NOT NULL

END;
GO

CREATE PROCEDURE DB_2025.migrar_sede AS
BEGIN

    INSERT INTO DB_2025.Sede (cuit_institucion, nombre, direccion, codigo_localidad, telefono, mail)
    SELECT DISTINCT
    m.Institucion_Cuit AS cuit_institucion,
    m.Sede_Nombre AS nombre,
    m.Sede_Direccion AS direccion,
    l.codigo_localidad AS codigo_localidad,
    m.Sede_Telefono AS telefono,
    m.Sede_Mail AS mail
    FROM gd_esquema.Maestra m
    JOIN DB_2025.Localidad l on m.Sede_Provincia = l.provincia and m.Sede_Localidad = l.nombre

END;
GO

CREATE PROCEDURE DB_2025.migrar_categoria AS
BEGIN

    INSERT INTO DB_2025.Categoria (nombre_categoria)
    SELECT DISTINCT m.Curso_Categoria as nombre_categoria
    FROM gd_esquema.Maestra m
    WHERE m.Curso_Categoria IS NOT NULL

END;
GO

CREATE PROCEDURE DB_2025.migrar_turno AS
BEGIN

    INSERT INTO DB_2025.Turno (nombre)
    SELECT DISTINCT m.Curso_Turno as nombre
    FROM gd_esquema.Maestra m
    WHERE m.Curso_Turno IS NOT NULL

END;
GO

CREATE PROCEDURE DB_2025.migrar_profesor AS
BEGIN

    INSERT INTO DB_2025.Profesor (nombre, apellido, dni, fecha_nacimiento, mail, direccion, codigo_localidad, telefono)
    SELECT DISTINCT
    m.Profesor_nombre AS nombre,
    m.Profesor_Apellido AS apellido,
    m.Profesor_Dni AS dni,
    m.Profesor_FechaNacimiento AS fecha_nacimiento,
    m.Profesor_Mail AS mail,
    m.Profesor_Direccion AS direccion,
    l.codigo_localidad AS codigo_localidad,
    m.Profesor_Telefono AS telefono
    FROM gd_esquema.Maestra m
    JOIN DB_2025.Localidad l ON m.Profesor_Localidad = l.nombre AND m.Profesor_Provincia = l.provincia

END;
GO

CREATE PROCEDURE DB_2025.migrar_alumno AS
BEGIN

    INSERT INTO DB_2025.Alumno (legajo, dni, nombre, apellido, fecha_nacimiento, mail, direccion, codigo_localidad, telefono)
    SELECT DISTINCT 
    m.Alumno_Legajo AS legajo,
    m.Alumno_Dni AS dni,
    m.Alumno_Nombre AS nombre,
    m.Alumno_Apellido AS apellido,
    m.Alumno_FechaNacimiento AS fecha_nacimiento,
    m.Alumno_Mail AS mail,
    m.Alumno_Direccion AS direccion,
    l.codigo_localidad AS numero,
    m.Alumno_Telefono AS telefono
    FROM gd_esquema.Maestra m
    JOIN DB_2025.Localidad l ON m.Alumno_Localidad = l.nombre AND m.Alumno_Provincia = l.provincia

END;
GO

CREATE PROCEDURE DB_2025.migrar_curso AS
BEGIN

    INSERT INTO DB_2025.Curso (codigo_curso, nombre, fecha_inicio, fecha_fin, duracion_meses, precio_mensual, profesor, categoria, sede, turno_curso, descripcion)
    SELECT DISTINCT 
    m.Curso_Codigo AS codigo_curso,
    m.Curso_Nombre AS nombre,
    m.Curso_FechaInicio AS fecha_inicio,
    m.Curso_FechaFin AS fecha_fin,
    m.Curso_DuracionMeses AS duracion_meses,
    m.Curso_PrecioMensual AS precio_mensual,
    p.id_profesor AS profesor,
    c.id_categoria AS categoria,
    s.id_sede AS sede,
    t.nombre AS turno,
    m.Curso_Descripcion AS descripcion
    FROM gd_esquema.Maestra m
    JOIN DB_2025.Profesor p ON p.nombre = m.Profesor_nombre AND p.apellido = m.Profesor_Apellido AND p.mail = m.Profesor_Mail AND p.dni = m.Profesor_Dni
    JOIN DB_2025.Categoria c ON m.Curso_Categoria = c.nombre_categoria
    JOIN DB_2025.Sede s ON s.cuit_institucion = m.Institucion_Cuit AND s.nombre = m.Sede_Nombre AND s.direccion = m.Sede_Direccion
    JOIN DB_2025.Turno t ON t.nombre = m.Curso_Turno

END;
GO

CREATE PROCEDURE DB_2025.migrar_dia AS
BEGIN

    INSERT INTO DB_2025.Dia (nombre_dia)
    SELECT DISTINCT
    m.Curso_Dia
    FROM gd_esquema.Maestra m
    WHERE m.Curso_Dia IS NOT NULL

END;
GO

CREATE PROCEDURE DB_2025.migrar_curso_dia AS
BEGIN

    INSERT INTO DB_2025.Curso_Dia (codigo_curso, dia)
    SELECT DISTINCT
    c.codigo_curso AS codigo_curso,
    d.nombre_dia AS dia
    FROM DB_2025.Curso c
    JOIN gd_esquema.Maestra m ON m.Curso_Codigo = c.codigo_curso
    JOIN DB_2025.Dia d ON d.nombre_dia = m.Curso_Dia  

END;
GO

CREATE PROCEDURE DB_2025.migrar_modulo AS
BEGIN

    INSERT INTO DB_2025.Modulo (codigo_curso, nombre, descripcion)
    SELECT DISTINCT
    c.codigo_curso AS codigo_curso,
    m.Modulo_Nombre AS nombre,
    m.Modulo_Descripcion AS descripcion
    FROM DB_2025.Curso c
    JOIN gd_esquema.Maestra m on m.Curso_Codigo = c.codigo_curso
    WHERE m.Modulo_Nombre IS NOT NULL AND m.Modulo_Descripcion IS NOT NULL

END;
GO

CREATE PROCEDURE DB_2025.migrar_estado_inscripcion AS
BEGIN

    INSERT INTO DB_2025.Estado_Inscripcion (estado)
    SELECT DISTINCT 
    m.Inscripcion_Estado AS estado
    FROM gd_esquema.Maestra m
    WHERE m.Inscripcion_Estado IS NOT NULL

END;
GO

CREATE PROCEDURE DB_2025.migrar_inscripcion AS
BEGIN

  INSERT INTO DB_2025.Inscripcion (nro_inscripcion, legajo, codigo_curso, fecha_inscripcion, estado, fecha_respuesta)
  SELECT DISTINCT 
  m.Inscripcion_Numero AS nro_inscripcion,
  a.legajo AS legajo,
  c.codigo_curso AS codigo_curso,
  m.Inscripcion_Fecha AS fecha_inscripcion,
  e.estado AS estado,
  m.Inscripcion_FechaRespuesta AS fecha_respuesta
  FROM gd_esquema.Maestra m
  JOIN DB_2025.Alumno a ON a.legajo = m.Alumno_Legajo
  JOIN DB_2025.Curso c ON c.codigo_curso = m.Curso_Codigo
  JOIN DB_2025.Estado_Inscripcion e ON e.estado = m.Inscripcion_Estado
  WHERE m.Inscripcion_Numero IS NOT NULL

END;
GO

CREATE PROCEDURE DB_2025.migrar_evaluacion AS
BEGIN

    INSERT INTO DB_2025.Evaluacion (id_modulo, alumno_legajo, nota, fecha, instancia, presente)
    SELECT DISTINCT 
    m.id_modulo AS id_modulo, 
    ma.Alumno_Legajo AS alumno_legajo, 
    ma.Evaluacion_Curso_Nota AS nota, 
    ma.Evaluacion_Curso_fechaEvaluacion AS fecha, 
    ma.Evaluacion_Curso_Instancia AS instancia,
    ma.Evaluacion_Curso_Presente AS presente
    FROM gd_esquema.Maestra ma 
    JOIN DB_2025.Modulo m ON m.nombre =  ma.Modulo_Nombre AND m.codigo_curso = ma.Curso_Codigo
    JOIN DB_2025.Alumno a ON a.legajo = ma.Alumno_Legajo
    WHERE ma.Evaluacion_Curso_fechaEvaluacion IS NOT NULL

END;
GO

CREATE PROCEDURE DB_2025.migrar_trabajo_practico AS
BEGIN

    INSERT INTO DB_2025.Trabajo_Practico (legajo_alumno, codigo_curso, nota, fecha_evaluacion)
    SELECT DISTINCT 
    a.legajo AS legajo, 
    c.codigo_curso AS codigo_curso, 
    m.Trabajo_Practico_Nota AS nota, 
    m.Trabajo_Practico_FechaEvaluacion AS fecha_evaluacion
    FROM gd_esquema.Maestra m
    JOIN DB_2025.Alumno a ON a.legajo = m.Alumno_Legajo
    JOIN DB_2025.Curso c ON c.codigo_curso = m.Curso_Codigo
    WHERE m.Trabajo_Practico_FechaEvaluacion IS NOT NULL
    AND m.Trabajo_Practico_Nota IS NOT NULL

END;
GO

CREATE PROCEDURE DB_2025.migrar_instancia_final AS
BEGIN

    INSERT INTO DB_2025.Instancia_Final (codigo_curso, fecha_final, hora_final)
    SELECT DISTINCT
    c.codigo_curso AS codigo_curso, 
    m.Examen_Final_Fecha AS fecha_final, 
    m.Examen_Final_Hora AS hora_final
    FROM gd_esquema.Maestra m
    JOIN DB_2025.Curso c ON c.codigo_curso = m.Curso_Codigo 
    WHERE m.Examen_Final_Fecha IS NOT NULL
    AND m.Examen_Final_Hora IS NOT NULL

END;
GO

CREATE PROCEDURE DB_2025.migrar_evaluacion_final AS
BEGIN

    INSERT INTO DB_2025.Evaluacion_Final (id_profesor, id_instancia, legajo_alumno, nota, presente, descripcion)
    SELECT DISTINCT 
    p.id_profesor AS id_profesor,
    i.id_instancia AS id_instancia, 
    a.legajo AS legajo_alumno, 
    m.Evaluacion_Final_Nota AS nota, 
    m.Evaluacion_Final_Presente AS presente, 
    m.Examen_Final_Descripcion AS descripcion
    FROM gd_esquema.Maestra m 
    JOIN DB_2025.Profesor p ON p.dni = m.Profesor_Dni AND p.nombre = m.Profesor_Nombre AND p.apellido = m.Profesor_Apellido AND p.mail = m.Profesor_Mail
    JOIN DB_2025.Instancia_Final i ON m.Curso_Codigo = i.codigo_curso AND m.Examen_Final_Fecha = i.fecha_final AND m.Examen_Final_Hora = i.hora_final
    JOIN DB_2025.Alumno a ON a.legajo = m.Alumno_Legajo
    WHERE m.Evaluacion_Final_Presente IS NOT NULL

END;
GO

CREATE PROCEDURE DB_2025.migrar_inscripcion_final AS
BEGIN

    INSERT INTO DB_2025.Inscripcion_Final (numero_inscripcion, legajo_alumno, id_instancia, fecha_inscripcion)
    SELECT DISTINCT 
    m.Inscripcion_Final_Nro AS numero_inscripcion, 
    a.legajo AS legajo_alumno, 
    i.id_instancia AS id_instancia, 
    m.Inscripcion_Final_Fecha AS fecha_inscripcion
    FROM gd_esquema.Maestra m 
    JOIN DB_2025.Instancia_Final i ON m.Curso_Codigo = i.codigo_curso AND m.Examen_Final_Fecha = i.fecha_final
    JOIN DB_2025.Alumno a ON a.legajo = m.Alumno_Legajo
    WHERE m.Inscripcion_Final_Nro IS NOT NULL
    AND m.Inscripcion_Final_Fecha IS NOT NULL

END;
GO

CREATE PROCEDURE DB_2025.migrar_pregunta AS
BEGIN

    INSERT INTO DB_2025.Pregunta (pregunta_texto)
    SELECT 
    p.pregunta AS pregunta
    FROM (
        SELECT Encuesta_Pregunta1 AS pregunta FROM gd_esquema.Maestra
        UNION 
        SELECT Encuesta_Pregunta2 AS pregunta FROM gd_esquema.Maestra
        UNION
        SELECT Encuesta_Pregunta3 AS pregunta FROM gd_esquema.Maestra
    ) p
    WHERE p.pregunta IS NOT NULL

END;
GO

CREATE PROCEDURE DB_2025.migrar_encuesta AS
BEGIN

    INSERT INTO DB_2025.Encuesta (codigo_curso, fecha_registro, observacion)
    SELECT DISTINCT
    c.codigo_curso codigo_curso, 
    m.Encuesta_FechaRegistro AS fecha_registro, 
    m.Encuesta_Observacion AS observacion
    FROM gd_esquema.Maestra m
    JOIN DB_2025.Curso c ON c.codigo_curso = m.Curso_Codigo
    WHERE m.Encuesta_FechaRegistro IS NOT NULL

END;
GO

CREATE PROCEDURE DB_2025.migrar_respuesta AS
BEGIN

    INSERT INTO DB_2025.Respuesta (id_encuesta, id_pregunta, nota_dada)
    SELECT DISTINCT e.id_encuesta, p.id_pregunta, m.Encuesta_Nota1 
    FROM gd_esquema.Maestra m 
    JOIN DB_2025.Encuesta e ON (m.Curso_Codigo = e.codigo_curso AND m.Encuesta_FechaRegistro = e.fecha_registro)
    JOIN DB_2025.Pregunta p ON (m.Encuesta_Pregunta1 = p.pregunta_texto)
    WHERE m.Encuesta_Nota1 IS NOT NULL
    UNION 
    SELECT DISTINCT e.id_encuesta, p.id_pregunta, m.Encuesta_Nota2 
    FROM gd_esquema.Maestra m
    JOIN DB_2025.Encuesta e ON (m.Curso_Codigo = e.codigo_curso AND m.Encuesta_FechaRegistro = e.fecha_registro)
    JOIN DB_2025.Pregunta p ON (m.Encuesta_Pregunta2 = p.pregunta_texto)
    WHERE m.Encuesta_Nota2 IS NOT NULL
    UNION
    SELECT DISTINCT e.id_encuesta, p.id_pregunta, m.Encuesta_Nota3 
    FROM gd_esquema.Maestra m
    JOIN DB_2025.Encuesta e ON (m.Curso_Codigo = e.codigo_curso AND m.Encuesta_FechaRegistro = e.fecha_registro)
    JOIN DB_2025.Pregunta p ON (m.Encuesta_Pregunta3 = p.pregunta_texto)
    WHERE m.Encuesta_Nota3 IS NOT NULL
    UNION
    SELECT DISTINCT e.id_encuesta, p.id_pregunta, m.Encuesta_Nota4 
    FROM gd_esquema.Maestra m
    JOIN DB_2025.Encuesta e ON (m.Curso_Codigo = e.codigo_curso AND m.Encuesta_FechaRegistro = e.fecha_registro)
    JOIN DB_2025.Pregunta p ON (m.Encuesta_Pregunta4 = p.pregunta_texto)
    WHERE m.Encuesta_Nota4 IS NOT NULL

END;
GO

CREATE PROCEDURE DB_2025.migrar_factura AS
BEGIN

    INSERT INTO DB_2025.Factura (numero_factura, fecha_emision, fecha_vencimiento, legajo_alumno, total)
    SELECT DISTINCT 
    m.Factura_Numero AS numero_factura, 
    m.Factura_FechaEmision AS fecha_emision, 
    m.Factura_FechaVencimiento AS fecha_vencimiento,
    a.legajo AS legajo_alumno,
    m.Factura_Total AS total
    FROM gd_esquema.Maestra m
    JOIN DB_2025.Alumno a ON a.legajo = m.Alumno_Legajo
    WHERE m.Factura_Numero IS NOT NULL
    AND m.Detalle_Factura_Importe IS NULL

END;
GO

CREATE PROCEDURE DB_2025.migrar_detalle_factura AS
BEGIN

    INSERT INTO DB_2025.Detalle_Factura (numero_factura, codigo_curso, periodo_anio, periodo_mes, importe)
    SELECT DISTINCT 
    f.numero_factura AS numero_factura, 
    c.codigo_curso AS codigo_curso,
    m.Periodo_Anio AS periodo_anio,
    m.Periodo_Mes AS periodo_mes, 
    m.Detalle_Factura_Importe as importe
    FROM gd_esquema.Maestra m 
    JOIN DB_2025.Factura f ON f.numero_factura = m.Factura_Numero AND f.legajo_alumno = m.Alumno_Legajo
    JOIN DB_2025.Curso c ON c.codigo_curso = m.Curso_Codigo
    WHERE m.Detalle_Factura_Importe IS NOT NULL

END;
GO

CREATE PROCEDURE DB_2025.migrar_medio_pago AS
BEGIN

    INSERT INTO DB_2025.Medio_Pago (nombre_medio)
    SELECT DISTINCT
    m.Pago_MedioPago AS nombre_medio
    FROM gd_esquema.Maestra m
    WHERE m.Pago_MedioPago IS NOT NULL

END;
GO

CREATE PROCEDURE DB_2025.migra_pago AS
BEGIN

    INSERT INTO DB_2025.Pago (numero_factura, fecha, importe, medio_pago)
    SELECT DISTINCT 
    f.numero_factura AS numero_factura, 
    m.Pago_Fecha AS fecha, 
    m.Pago_Importe AS importe,
    mp.id_medio medio_pago
    FROM gd_esquema.Maestra m
    JOIN DB_2025.Factura f ON f.numero_factura = m.Factura_Numero AND f.legajo_alumno = m.Alumno_Legajo
    JOIN DB_2025.Medio_Pago mp ON mp.nombre_medio = m.Pago_MedioPago
    WHERE m.Pago_Importe IS NOT NULL

END;
GO

BEGIN TRANSACTION

    EXECUTE DB_2025.migrar_provincia
    EXECUTE DB_2025.migrar_localidad
    EXECUTE DB_2025.migrar_institucion
    EXECUTE DB_2025.migrar_sede
    EXECUTE DB_2025.migrar_categoria
    EXECUTE DB_2025.migrar_turno
    EXECUTE DB_2025.migrar_profesor
    EXECUTE DB_2025.migrar_alumno
    EXECUTE DB_2025.migrar_curso
    EXECUTE DB_2025.migrar_dia
    EXECUTE DB_2025.migrar_curso_dia
    EXECUTE DB_2025.migrar_modulo
    EXECUTE DB_2025.migrar_estado_inscripcion
    EXECUTE DB_2025.migrar_inscripcion
    EXECUTE DB_2025.migrar_evaluacion
    EXECUTE DB_2025.migrar_trabajo_practico
    EXECUTE DB_2025.migrar_instancia_final
    EXECUTE DB_2025.migrar_evaluacion_final
    EXECUTE DB_2025.migrar_inscripcion_final
    EXECUTE DB_2025.migrar_pregunta
    EXECUTE DB_2025.migrar_encuesta
    EXECUTE DB_2025.migrar_respuesta
    EXECUTE DB_2025.migrar_factura
    EXECUTE DB_2025.migrar_detalle_factura
    EXECUTE DB_2025.migrar_medio_pago
    EXECUTE DB_2025.migra_pago

COMMIT;