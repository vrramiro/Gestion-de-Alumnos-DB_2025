/* =========================================================
= = = = = = = =  0) LIMPIEZA / PREP DEL ESQUEMA  = = = = = =
========================================================= */
USE GD2C2025
GO

-- Dropeo de tablas Hechos
IF OBJECT_ID('DB_2025_BI.BI_Hecho_Pago', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Hecho_Pago;
IF OBJECT_ID('DB_2025_BI.BI_Hecho_Cursada', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Hecho_Cursada;
IF OBJECT_ID('DB_2025_BI.BI_Hecho_Inscripcion', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Hecho_Inscripcion;
IF OBJECT_ID('DB_2025_BI.BI_Hecho_Encuesta', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Hecho_Encuesta;
IF OBJECT_ID('DB_2025_BI.BI_Hecho_Examen_Final', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Hecho_Examen_Final;

-- Dropeo de tablas de dimensiones
IF OBJECT_ID('DB_2025_BI.BI_Dim_Alumno', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Alumno;
IF OBJECT_ID('DB_2025_BI.BI_Dim_Profesor', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Profesor;
IF OBJECT_ID('DB_2025_BI.BI_Dim_Curso', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Curso;
IF OBJECT_ID('DB_2025_BI.BI_Dim_Sede', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Sede;
IF OBJECT_ID('DB_2025_BI.BI_Dim_Tiempo', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Tiempo;
IF OBJECT_ID('DB_2025_BI.BI_Dim_Medio_Pago', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Medio_Pago;
IF OBJECT_ID('DB_2025_BI.BI_Dim_Modulo', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Modulo;
IF OBJECT_ID('DB_2025_BI.BI_Dim_Instancia_Evaluacion', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Instancia_Evaluacion;
IF OBJECT_ID('DB_2025_BI.BI_Dim_Estado_Inscripcion', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Estado_Inscripcion;
IF OBJECT_ID('DB_2025_BI.BI_Dim_Pregunta', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Pregunta;
IF OBJECT_ID('DB_2025_BI.BI_Dim_Bloque_Satifaccion', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Bloque_Satifaccion;


-- Dropeo de vistas
IF OBJECT_ID('DB_2025_BI.BI_', 'V') IS NOT NULL DROP VIEW DB_2025_BI.BI_;


-- Dropear y recrear el esquema limpio
IF SCHEMA_ID('DB_2025_BI') IS NULL
BEGIN
    EXEC('CREATE SCHEMA DB_2025_BI;');
END
GO

/* =========================================================
= = = = = = = =  1) CREADO DE DIMENSIONES  = = = = = =
========================================================= */



CREATE TABLE DB_2025_BI.BI_Dim_Tiempo (
    id_fecha        BIGINT IDENTITY(1,1)    PRIMARY KEY,
    fecha           DATE                    NOT NULL,
    anio            INT                     NOT NULL,
    mes             INT                     NOT NULL,
    cuatrimestre    INT                     NOT NULL      
)
GO

CREATE TABLE DB_2025_BI.BI_Dim_Alumno(
    id_alumno    BIGINT       NOT NULL PRIMARY KEY,   -- = legajo
    legajo       BIGINT       NOT NULL,
    dni          BIGINT       NULL,
    nombre       VARCHAR(255) NOT NULL,
    apellido     VARCHAR(255) NOT NULL,
    rango_etario VARCHAR(50)  NULL
)
GO

CREATE TABLE DB_2025_BI.BI_Dim_Profesor(
    id_profesor  BIGINT       NOT NULL PRIMARY KEY,
    nombre       VARCHAR(255) NOT NULL,
    apellido     VARCHAR(255) NOT NULL,
    dni          BIGINT       NULL,
    rangoEtario  VARCHAR(50)  NULL
)
GO

CREATE TABLE DB_2025_BI.BI_Dim_Sede(
    id_sede      BIGINT       NOT NULL PRIMARY KEY,
    nombre_sede  VARCHAR(255) NOT NULL,
    direccion    VARCHAR(255) NULL,
    localidad    VARCHAR(255) NULL,
    provincia    VARCHAR(255) NULL
)
GO

CREATE TABLE DB_2025_BI.BI_Dim_Curso
(
    id_curso       BIGINT        NOT NULL PRIMARY KEY,  -- = codigo_curso
    codigo_curso   BIGINT        NOT NULL,
    nombre_curso   VARCHAR(255)  NOT NULL,
    categoria      NVARCHAR(255) NULL,
    turno          VARCHAR(255)  NULL,
    dias_cursada   VARCHAR(255)  NULL,
    duracion_meses BIGINT        NULL,
)
GO

CREATE TABLE DB_2025_BI.BI_Dim_Modulo
(
    id_modulo     BIGINT       NOT NULL PRIMARY KEY,
    nombre_modulo VARCHAR(255) NOT NULL,
    numero_modulo INT          NULL,
    id_curso      BIGINT       NOT NULL,
    descripcion   VARCHAR(255) NULL
)
GO

CREATE TABLE DB_2025_BI.BI_Dim_Medio_Pago
(
    id_medio_pago BIGINT       NOT NULL PRIMARY KEY,
    nombre_medio  VARCHAR(255) NOT NULL
)
GO

CREATE TABLE DB_2025_BI.BI_Dim_Estado_Inscripcion
(
    id_Estado_inscripcion BIGINT IDENTITY(1,1) PRIMARY KEY,
    estado                NVARCHAR(255) NOT NULL
)
GO

CREATE TABLE DB_2025_BI.BI_Dim_Instancia_Evaluacion
(
    id_instancia_eval BIGINT       NOT NULL PRIMARY KEY,
    nombre_instancia  VARCHAR(50)  NULL,
    descripcion       VARCHAR(255) NULL
)
GO

CREATE TABLE DB_2025_BI.BI_Dim_Bloque_Satifaccion
(
    id_bloque_satisfaccion BIGINT       NOT NULL PRIMARY KEY,
    nivel_satisfaccion     VARCHAR(255) NOT NULL,
    nota_minima            INT          NOT NULL,
    nota_maxima            INT          NOT NULL
)
GO


/* =========================================================
= = = = = = = =  2) CREADO DE HECHOS   = = = = = =
========================================================= */


CREATE TABLE DB_2025_BI.BI_Hecho_Pago (
    id_hecho_pago        BIGINT IDENTITY (1,1) PRIMARY KEY,
    id_curso             BIGINT NOT NULL,
    id_alumno            BIGINT NOT NULL,
    id_sede              BIGINT NOT NULL,
    id_medio_pago        BIGINT NOT NULL,
    id_fecha_pago        BIGINT NOT NULL,
    id_fecha_emision     BIGINT NOT NULL,
    id_fecha_vencimiento BIGINT NOT NULL,
    importe_pago	     DECIMAL(18,2) NOT NULL,
    importe_factura	     DECIMAL(18,2) NOT NULL,
    pago_vencido	     INT NOT NULL
    FOREIGN KEY (id_curso) REFERENCES DB_2025_BI.BI_Dim_Curso (id_curso),
    FOREIGN KEY (id_alumno) REFERENCES DB_2025_BI.BI_Dim_Alumno (id_alumno),
    FOREIGN KEY (id_sede) REFERENCES DB_2025_BI.BI_Dim_Sede (id_sede),
    FOREIGN KEY (id_medio_pago) REFERENCES DB_2025_BI.BI_Dim_Medio_Pago (id_medio_pago),
    FOREIGN KEY (id_fecha_pago) REFERENCES DB_2025_BI.BI_Dim_Tiempo (id_fecha),
    FOREIGN KEY (id_fecha_emision) REFERENCES DB_2025_BI.BI_Dim_Tiempo (id_fecha),
    FOREIGN KEY (id_fecha_vencimiento) REFERENCES DB_2025_BI.BI_Dim_Tiempo (id_fecha),
);
GO

CREATE TABLE DB_2025_BI.BI_Hecho_Cursada (
    id_hecho	            BIGINT IDENTITY (1,1) PRIMARY KEY,
    id_alumno	            BIGINT NOT NULL,
    id_modulo	            BIGINT NOT NULL,
    id_curso	            BIGINT NOT NULL,
    id_profesor	            BIGINT NOT NULL,
    id_fecha_evaluacion	    BIGINT NOT NULL,
    id_instancia	        BIGINT NOT NULL,
    es_aprobado             INT    NOT NULL
    FOREIGN KEY (id_alumno) REFERENCES DB_2025_BI.BI_Dim_Alumno (id_alumno),
    FOREIGN KEY (id_modulo) REFERENCES DB_2025_BI.BI_Dim_Modulo (id_modulo),
    FOREIGN KEY (id_curso) REFERENCES DB_2025_BI.BI_Dim_Curso (id_curso),
    FOREIGN KEY (id_profesor) REFERENCES DB_2025_BI.BI_Dim_Profesor (id_profesor),
    FOREIGN KEY (id_fecha_evaluacion) REFERENCES DB_2025_BI.BI_Dim_Tiempo (id_fecha),
    FOREIGN KEY (id_instancia) REFERENCES DB_2025_BI.BI_Dim_Instancia_Evaluacion (id_instancia_eval),
);
GO

CREATE TABLE DB_2025_BI.BI_Hecho_Examen_Final (
    id_hecho_final	     BIGINT IDENTITY (1,1) PRIMARY KEY,
    id_alumno	         BIGINT NOT NULL,
    id_curso	         BIGINT NOT NULL,
    id_profesor	         BIGINT NOT NULL,
    id_instancia_final   BIGINT NOT NULL,
    id_fecha_final	     BIGINT NOT NULL,
    nota_final	         DECIMAL NOT NULL,
    es_presente_final    INT NOT NULL,
    es_aprobado_final    INT NOT NULL
);
GO

CREATE TABLE DB_2025_BI.BI_Hecho_Inscripcion (
    id_hecho_inscripcion    BIGINT IDENTITY(1,1) PRIMARY KEY,
    id_alumno               BIGINT NOT NULL,
    id_curso                BIGINT NOT NULL,
    id_fecha_inscripcion    BIGINT NOT NULL,
    id_sede                 BIGINT NOT NULL,
    id_estado_inscripcion   BIGINT NOT NULL,
    cant_inscripciones      INT    NOT NULL DEFAULT(1)
)
GO

CREATE TABLE DB_2025_BI.BBI_Hecho_Encuesta (
    id_hecho_encuesta       BIGINT IDENTITY(1,1) PRIMARY KEY,
    id_curso                BIGINT NOT NULL,
    id_profesor             BIGINT NOT NULL,
    id_sede                 BIGINT NOT NULL,
    id_bloque_satisfacción  BIGINT NOT NULL,
    nota_promedio_encuesta	INT NOT NULL
);
GO



/* =========================================================
= = = = = = = =  3) CARGADO DE TABLAS   = = = = = =
========================================================= */

WITH Fechas AS (
    SELECT CAST(fecha_inscripcion AS DATE) AS fecha FROM inscripcion
    UNION
    SELECT CAST(fecha_respuesta AS DATE)   FROM inscripcion
    UNION
    SELECT CAST(fecha AS DATE)            FROM evaluacion
    UNION
    SELECT CAST(fecha_emision AS DATE)    FROM factura
    UNION
    SELECT CAST(fecha_vencimiento AS DATE)FROM factura
    UNION
    SELECT CAST(fecha AS DATE)            FROM pago
    UNION
    SELECT CAST(fecha_registro AS DATE)   FROM encuesta
    UNION
    SELECT CAST(fecha AS DATE)            FROM instancia_final
) 

INSERT INTO DB_2025_BI.BI_Dim_Tiempo (fecha, anio, mes, cuatrimestre)
SELECT DISTINCT
    f.fecha,
    YEAR(f.fecha)              AS anio,
    MONTH(f.fecha)             AS mes,
    CASE 
        WHEN MONTH(f.fecha) BETWEEN 1 AND 4  THEN 1
        WHEN MONTH(f.fecha) BETWEEN 5 AND 8  THEN 2
        ELSE 3
    END                        AS cuatrimestre
FROM Fechas f
WHERE f.fecha IS NOT NULL;
GO

INSERT INTO DB_2025_BI.BI_Dim_Alumno (Id_alumno, legajo, dni, nombre, apellido)
SELECT DISTINCT
    a.legajo                        AS Id_alumno,
    a.legajo,
    a.dni,
    a.nombre,
    a.apellido
FROM alumno a;
GO

INSERT INTO bi.Dim_Profesor (id_profesor, nombre, apellido, dni)
SELECT DISTINCT
    p.id_profesor,
    p.nombre,
    p.apellido,
    TRY_CAST(p.dni AS BIGINT)
FROM profesor p;
GO

INSERT INTO bi.Dim_Sede (id_sede, nombre_sede, direccion, localidad, provincia)
SELECT DISTINCT
    s.id_sede,
    s.nombre,
    s.direccion,
    l.nombre         AS localidad,
    pr.provincia_nombre AS provincia
FROM sede s
LEFT JOIN Localidad l      ON l.codigo_localidad = s.id_localidad
LEFT JOIN Provincia pr     ON pr.provincia_nombre = l.provincia;
GO

---------------------------------

;WITH Dias AS (
    SELECT 
        cd.codigo_curso,
        STRING_AGG(d.nombre_dia, ',') AS dias_cursada
    FROM curso_dia cd
    JOIN dia d ON d.nombre_dia = cd.dia
    GROUP BY cd.codigo_curso
)

INSERT INTO DB_2025_BI.BI_Dim_Curso (id_curso, codigo_curso, nombre_curso, categoria, turno, dias_cursada, duracion_meses, precio_mensual)
SELECT DISTINCT
    c.codigo_curso AS id_curso,
    c.codigo_curso,
    c.nombre_curso,
    cat.nombe        AS categoria,
    c.turno_curso    AS turno,
    d.dias_cursada,
    c.duracion_meses,
    c.precio_mensual
FROM curso c
LEFT JOIN categoria cat ON cat.id_categoria = c.categoria_curso
LEFT JOIN Dias d        ON d.codigo_curso   = c.codigo_curso;
GO

--------------------------------

INSERT INTO DB_2025_BI.BI_Dim_Modulo (id_modulo, nombre_modulo, numero_modulo, id_curso, descripcion)
SELECT DISTINCT
    m.id_modulo,
    m.nombre,
    NULL AS numero_modulo,      
    m.codigo_curso,
    m.descripcion
FROM modulo m;
GO

------------------------
-- 3.7 Dim_Medio_Pago
------------------------
INSERT INTO DB_2025_BI.BI_Dim_Medio_Pago (id_medio_pago, nombre_medio)
SELECT DISTINCT
    mp.id_medio,
    mp.nombre_medio
FROM medio_pago mp;
GO

------------------------
-- 3.8 Dim_Estado_Inscripcion
------------------------
INSERT INTO DB_2025_BI.BI_Dim_Estado_Inscripcion (estado)
SELECT DISTINCT estado 
FROM estado_inscripcion;
GO

------------------------
-- 3.9 Dim_Instancia_Evaluacion
------------------------
INSERT INTO DB_2025_BI.BI_Dim_Instancia_Evaluacion (id_instancia_eval, nombre_instancia, descripcion)
SELECT DISTINCT
    e.instancia,
    CONCAT('Instancia ', e.instancia),
    NULL
FROM evaluacion e
WHERE e.instancia IS NOT NULL;
GO


------------------------
-- 3.11 Dim_Bloque_Satisfaccion (definimos manualmente rangos)
------------------------
INSERT INTO DB_2025_BI.BI_Dim_Bloque_Satisfaccion (id_bloque_satisfaccion, nivel_satisfaccion, nota_minima, nota_maxima)
VALUES
(1, 'Baja',      1, 4),
(2, 'Media',     5, 6),
(3, 'Alta',      7, 8),
(4, 'Muy Alta',  9, 10);
GO

