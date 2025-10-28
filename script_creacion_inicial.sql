/* =========================================================
= = = = = = = =  0) LIMPIEZA / PREP DEL ESQUEMA  = = = = = =
========================================================= */

IF OBJECT_ID('DB_2025.sp_migrar_tabla_ejemplo', 'P') IS NOT NULL
    DROP PROCEDURE DB_2025.sp_migrar_tabla_ejemplo;
GO

-- Dropear tablas del esquema
IF OBJECT_ID('DB_2025.Respuesta', 'U') IS NOT NULL DROP TABLE DB_2025.Respuesta;
IF OBJECT_ID('DB_2025.Observacion', 'U') IS NOT NULL DROP TABLE DB_2025.Observacion;
IF OBJECT_ID('DB_2025.Pregunta', 'U')   IS NOT NULL DROP TABLE DB_2025.Pregunta;
IF OBJECT_ID('DB_2025.Encuesta', 'U')   IS NOT NULL DROP TABLE DB_2025.Encuesta;

IF OBJECT_ID('DB_2025.Pago', 'U')              IS NOT NULL DROP TABLE DB_2025.Pago;
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

-- 0.3) Dropear y recrear el esquema limpio
IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'DB_2025')
    DROP SCHEMA DB_2025;
GO
CREATE SCHEMA DB_2025;
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
    id_localidad BIGINT IDENTITY(1,1) PRIMARY KEY,
    nombre       NVARCHAR(255),
    provincia    NVARCHAR(255),
    FOREIGN KEY (provincia) REFERENCES DB_2025.Provincia(provincia_nombre)
);
GO

-- 1.2) Institución y Sede (Sede depende de Institución y Localidad)
CREATE TABLE DB_2025.Institucion (
    cuit         NVARCHAR(255) PRIMARY KEY,
    nombre       VARCHAR(255),
    razon_social NVARCHAR(255)
);
GO

CREATE TABLE DB_2025.Sede (
    id_sede           BIGINT IDENTITY(1,1) PRIMARY KEY,
    cuit_institucion  NVARCHAR(255),
    nombre            NVARCHAR(255),
    direccion         NVARCHAR(255),
    localidad         BIGINT,
    telefono          NVARCHAR(255),
    mail              NVARCHAR(255),
    FOREIGN KEY (localidad)        REFERENCES DB_2025.Localidad(id_localidad),
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
    localidad        BIGINT,
    telefono         NVARCHAR(255),
    FOREIGN KEY (localidad) REFERENCES DB_2025.Localidad(id_localidad)
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
    localidad        BIGINT,
    telefono         VARCHAR(255),
    FOREIGN KEY (localidad) REFERENCES DB_2025.Localidad(id_localidad)
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
    id_curso BIGINT,
    dia      VARCHAR(10),
    PRIMARY KEY (id_curso, dia),
    FOREIGN KEY (id_curso) REFERENCES DB_2025.Curso(codigo_curso),
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
    curso_id          BIGINT,
    fecha_inscripcion DATETIME2(6),
    estado            VARCHAR(255),
    fecha_respuesta   DATETIME2(6),
    FOREIGN KEY (estado)  REFERENCES DB_2025.Estado_Inscripcion(estado),
    FOREIGN KEY (legajo)  REFERENCES DB_2025.Alumno(legajo),
    FOREIGN KEY (curso_id)REFERENCES DB_2025.Curso(codigo_curso)
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
    legajo_alumno  BIGINT,
    codigo_curso   BIGINT,
    fecha_registro DATETIME2(6),
    observacion    VARCHAR(255) NULL,
    FOREIGN KEY (codigo_curso)  REFERENCES DB_2025.Curso(codigo_curso),
    FOREIGN KEY (legajo_alumno)  REFERENCES DB_2025.Alumno(legajo)
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
    anio              BIGINT,
    mes               BIGINT,
    legajo_alumno     BIGINT,
    total             DECIMAL(18,2),
    FOREIGN KEY (legajo_alumno) REFERENCES DB_2025.Alumno(legajo)
);
GO

CREATE TABLE DB_2025.Detalle_Factura (
    numero_factura BIGINT,
    id_curso       BIGINT,
    importe        DECIMAL(18,2),
    PRIMARY KEY (numero_factura, id_curso),
    FOREIGN KEY (numero_factura) REFERENCES DB_2025.Factura(numero_factura),
    FOREIGN KEY (id_curso)       REFERENCES DB_2025.Curso(codigo_curso)
);
GO

CREATE TABLE DB_2025.Pago (
    id_pago        BIGINT PRIMARY KEY,
    numero_factura BIGINT,
    fecha          DATETIME2(6),
    importe        DECIMAL(18,2),
    medio_pago     VARCHAR(255),
    FOREIGN KEY (numero_factura) REFERENCES DB_2025.Factura(numero_factura)
);
GO

-- Ubicación / Actores / Catálogos
CREATE INDEX IX_Localidad_provincia      ON DB_2025.Localidad(provincia);
CREATE INDEX IX_Sede_localidad           ON DB_2025.Sede(localidad);
CREATE INDEX IX_Sede_cuit_institucion    ON DB_2025.Sede(cuit_institucion);
CREATE INDEX IX_Profesor_localidad       ON DB_2025.Profesor(localidad);
CREATE INDEX IX_Alumno_localidad         ON DB_2025.Alumno(localidad);

-- Cursos y estructura
CREATE INDEX IX_Curso_profesor           ON DB_2025.Curso(profesor);
CREATE INDEX IX_Curso_categoria          ON DB_2025.Curso(categoria);
CREATE INDEX IX_Curso_sede               ON DB_2025.Curso(sede);
CREATE INDEX IX_Modulo_codigo_curso      ON DB_2025.Modulo(codigo_curso);

-- Inscripciones y evaluación regular
CREATE INDEX IX_Inscripcion_legajo       ON DB_2025.Inscripcion(legajo);
CREATE INDEX IX_Inscripcion_curso        ON DB_2025.Inscripcion(curso_id);
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
CREATE INDEX IX_Encuesta_legajo_alumno   ON DB_2025.Encuesta(legajo_alumno);
CREATE INDEX IX_Encuesta_codigo_curso    ON DB_2025.Encuesta(codigo_curso);
CREATE INDEX IX_Respuesta_id_encuesta    ON DB_2025.Respuesta(id_encuesta);

-- Facturación
CREATE INDEX IX_Factura_legajo_alumno    ON DB_2025.Factura(legajo_alumno);
CREATE INDEX IX_DetalleFactura_id_curso  ON DB_2025.Detalle_Factura(id_curso);
CREATE INDEX IX_Pago_numero_factura      ON DB_2025.Pago(numero_factura);

CREATE INDEX IX_Inscripcion_estado       ON DB_2025.Inscripcion(estado);
CREATE INDEX IX_Curso_turno_curso        ON DB_2025.Curso(turno_curso);
CREATE INDEX IX_Respuesta_id_pregunta    ON DB_2025.Respuesta(id_pregunta);
CREATE INDEX IX_EvalFinal_id_profesor    ON DB_2025.Evaluacion_Final(id_profesor);