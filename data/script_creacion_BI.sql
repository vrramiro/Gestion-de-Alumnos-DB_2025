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
IF OBJECT_ID('DB_2025_BI.BI_Dim_Estado_Inscripcion', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Estado_Inscripcion;
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



CREATE TABLE DB_2025_BI.BI_Dim_Tiempo 
(
    id_fecha        BIGINT IDENTITY(1,1)    PRIMARY KEY,
    fecha           DATE                    NOT NULL,
    anio            INT                     NOT NULL,
    mes             INT                     NOT NULL,
    cuatrimestre    INT                     NOT NULL      
)
GO

CREATE TABLE DB_2025_BI.BI_Dim_Alumno
(
    id_alumno    BIGINT       NOT NULL PRIMARY KEY,   -- = legajo
    legajo       BIGINT       NOT NULL,
    dni          BIGINT       NULL,
    nombre       VARCHAR(255) NOT NULL,
    apellido     VARCHAR(255) NOT NULL,
    rango_etario VARCHAR(50)  NULL
)
GO

CREATE TABLE DB_2025_BI.BI_Dim_Profesor
(
    id_profesor  BIGINT       NOT NULL PRIMARY KEY,
    nombre       VARCHAR(255) NOT NULL,
    apellido     VARCHAR(255) NOT NULL,
    dni          BIGINT       NULL,
    rango_etario  VARCHAR(50)  NULL
)
GO

CREATE TABLE DB_2025_BI.BI_Dim_Sede
(
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
    fecha_inicio    DATE          NULL
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
    id_curso	            BIGINT NOT NULL,
    id_profesor	            BIGINT NOT NULL,
    id_fecha_inicio	    BIGINT NOT NULL,
    es_aprobado             INT    NOT NULL
    FOREIGN KEY (id_alumno) REFERENCES DB_2025_BI.BI_Dim_Alumno (id_alumno),
    FOREIGN KEY (id_curso) REFERENCES DB_2025_BI.BI_Dim_Curso (id_curso),
    FOREIGN KEY (id_profesor) REFERENCES DB_2025_BI.BI_Dim_Profesor (id_profesor),
    FOREIGN KEY (id_fecha_inicio) REFERENCES DB_2025_BI.BI_Dim_Tiempo (id_fecha),
);
GO

CREATE TABLE DB_2025_BI.BI_Hecho_Examen_Final (
    id_hecho_final	     BIGINT IDENTITY (1,1) PRIMARY KEY,
    id_alumno	         BIGINT NOT NULL,
    id_curso	         BIGINT NOT NULL,
    id_profesor	         BIGINT NOT NULL,
    id_sede              BIGINT NOT NULL,
    fecha_evaluacion     BIGINT NOT NULL,
    nota_final	         DECIMAL NOT NULL,
    es_presente_final    INT NOT NULL,
    es_aprobado_final    INT NOT NULL
    FOREIGN KEY (id_alumno) REFERENCES DB_2025_BI.BI_Dim_Alumno (id_alumno),
    FOREIGN KEY (id_curso) REFERENCES DB_2025_BI.BI_Dim_Curso (id_curso),
    FOREIGN KEY (id_profesor) REFERENCES DB_2025_BI.BI_Dim_Profesor (id_profesor),
    FOREIGN KEY (id_sede) REFERENCES DB_2025_BI.BI_Dim_Sede (id_sede),
    FOREIGN KEY (fecha_evaluacion) REFERENCES DB_2025_BI.BI_Dim_Tiempo (id_fecha)
);
GO

CREATE TABLE DB_2025_BI.BI_Hecho_Inscripcion (
    id_hecho_inscripcion    BIGINT IDENTITY(1,1) PRIMARY KEY,
    id_alumno               BIGINT NOT NULL,
    id_curso                BIGINT NOT NULL,
    id_fecha_inscripcion    BIGINT NOT NULL,
    id_sede                 BIGINT NOT NULL,
    id_estado_inscripcion   BIGINT NOT NULL,
    es_rechazada            BOOLEAN NOT NULL,
    FOREIGN KEY (id_alumno) REFERENCES DB_2025_BI.BI_Dim_Alumno (id_alumno),
    FOREIGN KEY (id_curso) REFERENCES DB_2025_BI.BI_Dim_Curso (id_curso),
    FOREIGN KEY (id_fecha_inscripcion) REFERENCES DB_2025_BI.BI_Dim_Tiempo (id_fecha),
    FOREIGN KEY (id_sede) REFERENCES DB_2025_BI.BI_Dim_Sede (id_sede),
    FOREIGN KEY (id_estado_inscripcion) REFERENCES DB_2025_BI.BI_Dim_Estado_Inscripcion (id_estado_inscripcion)
)
GO

CREATE TABLE DB_2025_BI.BBI_Hecho_Encuesta (
    id_hecho_encuesta       BIGINT IDENTITY(1,1) PRIMARY KEY,
    id_curso                BIGINT NOT NULL,
    id_sede                 BIGINT NOT NULL,
    id_bloque_satisfacción  BIGINT NOT NULL,
    nota_promedio_encuesta	INT NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES DB_2025_BI.BI_Dim_Curso (id_curso),
    FOREIGN KEY (id_sede) REFERENCES DB_2025_BI.BI_Dim_Sede (id_sede),
    FOREIGN KEY (id_bloque_satisfacción) REFERENCES DB_2025_BI.BI_Dim_Bloque_Satifaccion (id_bloque_satisfaccion)
);
GO



/* =========================================================
= = = = = = = =  3) CARGADO DE DIMENSIONES   = = = = = =
========================================================= */
------------------------
-- Dim_Tiempo
------------------------
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
    UNION
    SELECT CAST(fecha_inicio AS DATE)    FROM curso
) 
------------------------
-- Dim_Tiempo
------------------------
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


------------------------
-- Dim_Alumno
------------------------
INSERT INTO DB_2025_BI.BI_Dim_Alumno (Id_alumno, legajo, dni, nombre, apellido)
SELECT DISTINCT
    a.legajo AS Id_alumno,
    a.legajo,
    a.dni,
    a.nombre,
    a.apellido,
    CASE 
        WHEN DATEDIFF(YEAR, a.fecha_nacimiento, GETDATE()) < 25 THEN '<25'
        WHEN DATEDIFF(YEAR, a.fecha_nacimiento, GETDATE()) BETWEEN 25 AND 35 THEN '25-35'
        WHEN DATEDIFF(YEAR, a.fecha_nacimiento, GETDATE()) BETWEEN 36 AND 50 THEN '36-50'
        ELSE '>50'
    END AS rango_etario
FROM alumno a;
GO


------------------------
-- Dim_Profesor
------------------------
INSERT INTO bi.Dim_Profesor (id_profesor, nombre, apellido, dni)
SELECT DISTINCT
    p.id_profesor,
    p.nombre,
    p.apellido,
    p.dni,
    CASE
        WHEN DATEDIFF(YEAR, p.fecha_nacimiento, GETDATE()) BETWEEN 25 AND 35 THEN '25-35'
        WHEN DATEDIFF(YEAR, p.fecha_nacimiento, GETDATE()) BETWEEN 36 AND 50 THEN '36-50'
        ELSE '>50'
    END AS rango_etario
FROM profesor p;
GO


------------------------
-- Dim_Sede
------------------------
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


------------------------
-- Dim_Curso
------------------------


INSERT INTO DB_2025_BI.BI_Dim_Curso (id_curso, codigo_curso, nombre_curso, categoria, turno, fecha_inicio)
SELECT DISTINCT
    c.codigo_curso AS id_curso,
    c.codigo_curso,
    c.nombre_curso,
    cat.nombe        AS categoria,
    c.turno_curso    AS turno,
    c.fecha_inicio   AS fecha_inicio
FROM curso c
LEFT JOIN categoria cat ON cat.id_categoria = c.categoria_curso
LEFT JOIN Dias d        ON d.codigo_curso   = c.codigo_curso;
GO


------------------------
-- Dim_Medio_Pago
------------------------
INSERT INTO DB_2025_BI.BI_Dim_Medio_Pago (id_medio_pago, nombre_medio)
SELECT DISTINCT
    mp.id_medio,
    mp.nombre_medio
FROM medio_pago mp;
GO


------------------------
-- Dim_Estado_Inscripcion
------------------------
INSERT INTO DB_2025_BI.BI_Dim_Estado_Inscripcion (estado)
SELECT DISTINCT estado 
FROM estado_inscripcion;
GO


------------------------
-- Dim_Bloque_Satisfaccion 
------------------------
INSERT INTO DB_2025_BI.BI_Dim_Bloque_Satisfaccion (id_bloque_satisfaccion, nivel_satisfaccion, nota_minima, nota_maxima)
VALUES
(1, 'Insatisfechos',      1, 4),
(2, 'Neutrales',          5, 6),
(3, 'Satisfechos',        7, 10);
GO

/* =========================================================
= = = = = = = =  4) CARGADO DE HECHOS   = = = = = =
========================================================= */
------------------------
-- Hecho_Pago
------------------------
INSERT INTO DB_2025_BI.BI_Hecho_Pago(id_curso, id_alumno, id_sede, id_medio_pago, id_fecha_pago, id_fecha_emision, id_fecha_vencimiento, importe_pago, importe_factura, pago_vencido)
SELECT
    dc.id_curso,
    da.id_alumno,
    ds.id_sede,
    dmp.id_medio_pago,
    dtp.id_fecha,
    dte.id_fecha,
    dtv.id_fecha,
    p.importe_pago,
    f.importe_total AS importe_factura,
    CASE 
        WHEN p.fecha_pago > f.fecha_vencimiento THEN 1
        ELSE 0
    END AS pago_vencido
FROM DB_2025.Pago p
JOIN DB_2025.Factura f ON f.numero_factura = p.numero_factura
JOIN DB_2025.Detalle_Factura df ON df.numero_factura = f.numero_factura
JOIN DB_2025.Curso c ON c.codigo_curso = df.codigo_curso
JOIN DB_2025.Sede s ON s.id_sede = c.id_sede
GO


------------------------
-- Hecho_Cursada
------------------------
WITH Notas_Parciales AS (
    SELECT 
        e.alumno_legajo,
        m.codigo_curso,
        MIN(e.nota) as nota -- Esto es para sacar la nota mas baja, si esa llega a ser menor a 4 en el case entonces reprobo
    FROM DB_2025.Evaluacion e
    JOIN DB_2025.Modulo m ON m.id_modulo = e.id_modulo
    GROUP BY e.alumno_legajo, m.codigo_curso
)

INSERT INTO DB_2025_BI.BI_Hecho_Cursada(id_alumno, id_curso, id_profesor, id_fecha_inicio, es_aprobado)
SELECT DISTINCT
    a.id_alumno,
    c.id_curso,
    p.id_profesor,
    t.id_fecha_inicio,
    CASE
        WHEN tp.nota >= 4 AND np.nota >= 4 THEN 1
        ELSE 0
    END AS es_aprobado

FROM BD_2025.inscripcion i
JOIN BD_2025.Curso c ON (c.codigo_curso = i.codigo_curso)
LEFT JOIN DB_2025.Trabajo_Practico tp ON (tp.codigo_curso = i.codigo_curso AND tp.legajo_alumno = i.legajo)
LEFT JOIN DB_2025.Notas_Parciales np ON (np.codigo_curso = i.codigo_curso AND np.alumno_legajo = i.legajo)
JOIN BD_2025_BI.BI_Dim_Alumno a ON (a.legajo = i.legajo)
JOIN BD_2025_BI.BI_Dim_Profesor p ON (p.id_profesor = c.profesor)
JOIN BD_2025_BI.BI_Dim_Tiempo t ON ()
GO


------------------------
-- Hecho_Inscripcion
------------------------
INSERT INTO DB_2025_BI.BI_Hecho_Inscripcion(id_alumno, id_curso, id_fecha_inscripcion, id_sede, id_estado_inscripcion, es_rechazada)
SELECT DISTINCT
    da.id_alumno,
    dc.id_curso,
    dt.id_fecha,
    ds.id_sede,
    dei.id_estado_inscripcion,

    CASE WHEN i.estado = 'Rechazada' THEN 1 ELSE 0 END AS es_rechazada

FROM DB_2025.Inscripcion i
JOIN DB_2025_BI.BI_Dim_Alumno da ON da.legajo = i.legajo
JOIN DB_2025_BI.BI_Dim_Curso dc ON dc.id_curso = i.codigo_curso
JOIN DB_2025_BI.BI_Dim_Tiempo dt ON dt.fecha = CAST(i.fecha_inscripcion AS DATE)
JOIN DB_2025.Curso c ON c.codigo_curso = i.codigo_curso
JOIN DB_2025.Sede s ON s.id_sede = c.sede 
JOIN DB_2025_BI.BI_Dim_Sede ds ON ds.id_sede = s.id_sede
JOIN DB_2025_BI.BI_Dim_Estado_Inscripcion dei ON dei.estado = i.estado;
GO

------------------------
-- Hecho_Encuesta
------------------------
INSERT INTO DB_2025_BI.BI_Hecho_Encuesta(id_curso,id_profesor,id_sede,id_bloque_satisfaccion,nota_promedio_encuesta)
SELECT
    dc.id_curso,
    dp.id_profesor,
    ds.id_sede,
    dbs.id_bloque_satisfaccion,
    AVG(r.nota_dada)

FROM DB_2025.Respuesta r
JOIN DB_2025.Encuesta e ON e.id_encuesta = r.id_encuesta
JOIN DB_2025.Curso c ON c.codigo_curso = e.codigo_curso
JOIN DB_2025.Profesor p ON p.id_profesor = c.profesor
JOIN DB_2025_BI.BI_Dim_Profesor dp ON dp.id_profesor = p.id_profesor
JOIN DB_2025_BI.BI_Dim_Curso dc ON dc.id_curso = c.codigo_curso
JOIN DB_2025.Sede s ON s.id_sede = c.sede
JOIN DB_2025_BI.BI_Dim_Sede ds ON ds.id_sede = s.id_sede
JOIN DB_2025_BI.BI_Dim_Bloque_Satifaccion dbs ON r.nota_dada BETWEEN dbs.nota_minima AND dbs.nota_maxima
GROUP BY
    dc.id_curso,
    dp.id_profesor,
    ds.id_sede,
    dbs.id_bloque_satisfaccion;
GO


------------------------
-- Hecho_Examen_Final
------------------------
INSERT INTO DB_2025_BI.BI_Hecho_Examen_Final(id_alumno, id_curso, id_profesor, id_sede, fecha_evaluacion, nota_final, es_presente_final, es_aprobado_final)
SELECT 
    da.id_alumno,
    dc.id_curso,
    dp.id_profesor,
    ds.id_sede,
    dt.id_fecha,
    ef.nota_final,
    CASE
        WHEN ef.es_presente = 1 THEN 1
        ELSE 0
    END AS es_presente_final,
    CASE
        WHEN ef.nota_final >= 4 THEN 1
        ELSE 0
    END AS es_aprobado_final
FROM DB_2025.Evaluacion_Final ef
JOIN alumno a ON a.legajo = ef.legajo_alumno
JOIN BD_2025_BI.Dim_Alumno da ON da.legajo = a.legajo
JOIN instancia_final i ON i.id_instancia_final = ef.id_instancia_final
JOIN curso c ON c.codigo_curso = i.codigo_curso
JOIN BD_2025_BI.Dim_Curso dc ON dc.codigo_curso = c.codigo_curso
JOIN profesor p ON p.id_profesor = c.profesor
JOIN BD_2025_BI.Dim_Profesor dp ON dp.id_profesor = p.id_profesor
JOIN sede s ON s.id_sede = c.sede
JOIN BD_2025_BI.Dim_Sede ds ON ds.id_sede = s.id_sede
JOIN BD_2025_BI.Dim_Tiempo dt ON dt.fecha = CAST(i.fecha AS DATE)

GO


------------------------
-- Hecho_
------------------------
INSERT INTO DB_2025_BI.BI_()
SELECT DISTINCT
GO