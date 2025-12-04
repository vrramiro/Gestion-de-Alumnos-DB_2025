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
IF OBJECT_ID('DB_2025_BI.BI_Hecho_Venta', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Hecho_Venta;

-- Dropeo de tablas de dimensiones
IF OBJECT_ID('DB_2025_BI.BI_Dim_Alumno', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Alumno;
IF OBJECT_ID('DB_2025_BI.BI_Dim_Profesor', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Profesor;
IF OBJECT_ID('DB_2025_BI.BI_Dim_Curso', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Curso;
IF OBJECT_ID('DB_2025_BI.BI_Dim_Sede', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Sede;
IF OBJECT_ID('DB_2025_BI.BI_Dim_Tiempo', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Tiempo;
IF OBJECT_ID('DB_2025_BI.BI_Dim_Medio_Pago', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Medio_Pago;
IF OBJECT_ID('DB_2025_BI.BI_Dim_Estado_Inscripcion', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Estado_Inscripcion;
IF OBJECT_ID('DB_2025_BI.BI_Dim_Bloque_Satisfaccion', 'U') IS NOT NULL DROP TABLE DB_2025_BI.BI_Dim_Bloque_Satisfaccion;


-- Dropeo de vistas
IF OBJECT_ID('DB_2025_BI.BI_VW_Top3_Categorias_Y_Turnos', 'V') IS NOT NULL DROP VIEW DB_2025_BI.BI_VW_Top3_Categorias_Y_Turnos;
IF OBJECT_ID('DB_2025_BI.BI_vw_Tasa_Rechazo_Inscripciones', 'V') IS NOT NULL DROP VIEW DB_2025_BI.BI_vw_Tasa_Rechazo_Inscripciones;
IF OBJECT_ID('DB_2025_BI.BI_vw_Desempeno_Cursada_Sede', 'V') IS NOT NULL DROP VIEW DB_2025_BI.BI_vw_Desempeno_Cursada_Sede;
IF OBJECT_ID('DB_2025_BI.BI_vw_Tiempo_Promedio_Finalizacion_Curso', 'V') IS NOT NULL DROP VIEW DB_2025_BI.BI_vw_Tiempo_Promedio_Finalizacion_Curso;
IF OBJECT_ID('DB_2025_BI.BI_vw_Nota_Promedio_Finales', 'V') IS NOT NULL DROP VIEW DB_2025_BI.BI_vw_Nota_Promedio_Finales;
IF OBJECT_ID('DB_2025_BI.BI_vw_Tasa_Ausentismo_Finales', 'V') IS NOT NULL DROP VIEW DB_2025_BI.BI_vw_Tasa_Ausentismo_Finales;
IF OBJECT_ID('DB_2025_BI.BI_vw_Desvio_Pagos', 'V') IS NOT NULL DROP VIEW DB_2025_BI.BI_vw_Desvio_Pagos;
IF OBJECT_ID('DB_2025_BI.BI_vw_Tasa_De_Morosidad', 'V') IS NOT NULL DROP VIEW DB_2025_BI.BI_vw_Tasa_De_Morosidad;
IF OBJECT_ID('DB_2025_BI.BI_vw_Top3_Ingresos_Categorias', 'V') IS NOT NULL DROP VIEW DB_2025_BI.BI_vw_Top3_Ingresos_Categorias;
IF OBJECT_ID('DB_2025_BI.BI_vw_Indice_Satisfaccion', 'V') IS NOT NULL DROP VIEW DB_2025_BI.BI_vw_Indice_Satisfaccion;

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
    id_fecha BIGINT IDENTITY(1,1) PRIMARY KEY,
    fecha DATE NOT NULL,
    anio INT NOT NULL,
    mes INT NOT NULL,
    cuatrimestre INT NOT NULL      
)
GO

CREATE TABLE DB_2025_BI.BI_Dim_Alumno
(
    id_alumno BIGINT PRIMARY KEY IDENTITY(1,1),
    legajo BIGINT NOT NULL,
    dni BIGINT NULL,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    rango_etario VARCHAR(50)  NULL
)
GO

CREATE TABLE DB_2025_BI.BI_Dim_Profesor
(
    id_profesor BIGINT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    dni BIGINT NULL,
    rango_etario VARCHAR(50) NULL
)
GO

CREATE TABLE DB_2025_BI.BI_Dim_Sede
(
    id_sede BIGINT PRIMARY KEY NOT NULL,
    nombre_sede VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NULL,
    localidad VARCHAR(255) NULL,
    provincia VARCHAR(255) NULL
)
GO

CREATE TABLE DB_2025_BI.BI_Dim_Curso
(
    id_curso BIGINT PRIMARY KEY IDENTITY(1,1), 
    codigo_curso BIGINT NOT NULL,
    nombre_curso VARCHAR(255) NOT NULL,
    categoria NVARCHAR(255) NULL,
    turno VARCHAR(255) NULL,
    fecha_inicio DATE NULL
)
GO


CREATE TABLE DB_2025_BI.BI_Dim_Medio_Pago
(
    id_medio_pago BIGINT PRIMARY KEY NOT NULL,
    nombre_medio VARCHAR(255) NOT NULL
)
GO

CREATE TABLE DB_2025_BI.BI_Dim_Estado_Inscripcion
(
    id_Estado_inscripcion BIGINT IDENTITY(1,1) PRIMARY KEY,
    estado NVARCHAR(255) NOT NULL
)
GO


CREATE TABLE DB_2025_BI.BI_Dim_Bloque_Satisfaccion
(
    id_bloque_satisfaccion BIGINT PRIMARY KEY IDENTITY(1,1),
    nivel_satisfaccion VARCHAR(255) NOT NULL,
    nota_minima INT NOT NULL,
    nota_maxima INT NOT NULL
)
GO

/* =========================================================
= = = = = = = =  2) CREADO DE HECHOS   = = = = = =
========================================================= */

CREATE TABLE DB_2025_BI.BI_Hecho_Pago (
    id_hecho_pago BIGINT IDENTITY (1,1) PRIMARY KEY,
    id_alumno BIGINT NOT NULL,
    id_curso BIGINT NOT NULL,
    id_sede BIGINT NOT NULL,
    id_medio_pago BIGINT NOT NULL,
    id_fecha_pago BIGINT NOT NULL,
    numero_factura VARCHAR(255) NOT NULL,
    importe_pago DECIMAL(18,2) NOT NULL,
    pago_vencido INT NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES DB_2025_BI.BI_Dim_Curso (id_curso),
    FOREIGN KEY (id_alumno) REFERENCES DB_2025_BI.BI_Dim_Alumno (id_alumno),
    FOREIGN KEY (id_sede) REFERENCES DB_2025_BI.BI_Dim_Sede (id_sede),
    FOREIGN KEY (id_medio_pago) REFERENCES DB_2025_BI.BI_Dim_Medio_Pago (id_medio_pago),
    FOREIGN KEY (id_fecha_pago) REFERENCES DB_2025_BI.BI_Dim_Tiempo (id_fecha)
);
GO

CREATE TABLE DB_2025_BI.BI_Hecho_Cursada (
    id_hecho BIGINT IDENTITY (1,1) PRIMARY KEY,
    id_alumno BIGINT NOT NULL,
    id_curso BIGINT NOT NULL,
    id_profesor BIGINT NOT NULL,
    id_fecha_inicio BIGINT NOT NULL,
    id_sede BIGINT NOT NULL,
    es_aprobado INT NOT NULL,
    FOREIGN KEY (id_alumno) REFERENCES DB_2025_BI.BI_Dim_Alumno (id_alumno),
    FOREIGN KEY (id_curso) REFERENCES DB_2025_BI.BI_Dim_Curso (id_curso),
    FOREIGN KEY (id_profesor) REFERENCES DB_2025_BI.BI_Dim_Profesor (id_profesor),
    FOREIGN KEY (id_fecha_inicio) REFERENCES DB_2025_BI.BI_Dim_Tiempo (id_fecha),
    FOREIGN KEY (id_sede) REFERENCES DB_2025_BI.BI_Dim_Sede (id_sede)
);
GO

CREATE TABLE DB_2025_BI.BI_Hecho_Examen_Final (
    id_hecho_final	     BIGINT IDENTITY (1,1) PRIMARY KEY,
    id_alumno	         BIGINT NOT NULL,
    id_curso	         BIGINT NOT NULL,
    id_profesor	         BIGINT NOT NULL,
    id_sede              BIGINT NOT NULL,
    fecha_evaluacion     BIGINT NOT NULL,
    nota_final	         DECIMAL,
    es_presente_final    INT NOT NULL,
    es_aprobado_final    INT NOT NULL,
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
    es_rechazada            INT NOT NULL,
    FOREIGN KEY (id_alumno) REFERENCES DB_2025_BI.BI_Dim_Alumno (id_alumno),
    FOREIGN KEY (id_curso) REFERENCES DB_2025_BI.BI_Dim_Curso (id_curso),
    FOREIGN KEY (id_fecha_inscripcion) REFERENCES DB_2025_BI.BI_Dim_Tiempo (id_fecha),
    FOREIGN KEY (id_sede) REFERENCES DB_2025_BI.BI_Dim_Sede (id_sede),
    FOREIGN KEY (id_estado_inscripcion) REFERENCES DB_2025_BI.BI_Dim_Estado_Inscripcion (id_estado_inscripcion)
)
GO

CREATE TABLE DB_2025_BI.BI_Hecho_Encuesta (
    id_hecho_encuesta       BIGINT IDENTITY(1,1) PRIMARY KEY,
    id_curso                BIGINT NOT NULL,
    id_profesor             BIGINT NOT NULL,
    id_sede                 BIGINT NOT NULL,
    id_fecha_encuesta       BIGINT NOT NULL,
    id_bloque_satisfaccion  BIGINT NOT NULL,
    nota_promedio_encuesta	INT NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES DB_2025_BI.BI_Dim_Curso (id_curso),
    FOREIGN KEY (id_sede) REFERENCES DB_2025_BI.BI_Dim_Sede (id_sede),
    FOREIGN KEY (id_bloque_satisfaccion) REFERENCES DB_2025_BI.BI_Dim_Bloque_Satisfaccion (id_bloque_satisfaccion),
    FOREIGN KEY (id_profesor) REFERENCES DB_2025_BI.BI_Dim_Profesor (id_profesor),
    FOREIGN KEY (id_fecha_encuesta) REFERENCES DB_2025_BI.BI_Dim_Tiempo (id_fecha)
);
GO

CREATE TABLE DB_2025_BI.BI_Hecho_Venta (
   id_hecho_venta	        BIGINT IDENTITY (1,1) PRIMARY KEY,
   id_alumno	            BIGINT NOT NULL,
   id_curso	                BIGINT NOT NULL,
   id_sede	                BIGINT NOT NULL,
   id_fecha_emision	        BIGINT NOT NULL,
   id_fecha_vencimiento	    BIGINT NOT NULL,
   numero_factura	        VARCHAR(255) NOT NULL,
   importe_ventas	        DECIMAL(18,2) NOT NULL,
   FOREIGN KEY (id_alumno) REFERENCES DB_2025_BI.BI_Dim_Alumno (id_alumno),
   FOREIGN KEY (id_curso) REFERENCES DB_2025_BI.BI_Dim_Curso (id_curso),
   FOREIGN KEY (id_sede) REFERENCES DB_2025_BI.BI_Dim_Sede (id_sede),
   FOREIGN KEY (id_fecha_emision) REFERENCES DB_2025_BI.BI_Dim_Tiempo (id_fecha),
   FOREIGN KEY (id_fecha_vencimiento) REFERENCES DB_2025_BI.BI_Dim_Tiempo (id_fecha)
);
GO

/* =========================================================
= = = = = = = =  3) CARGADO DE DIMENSIONES   = = = = = =
========================================================= */

------------------------
-- Dim_Tiempo
------------------------

WITH Fechas AS (
    SELECT CAST(fecha_inscripcion AS DATE) AS fecha FROM DB_2025.inscripcion
    UNION
    SELECT CAST(fecha_respuesta AS DATE)   
    FROM DB_2025.inscripcion
    UNION
    SELECT CAST(fecha AS DATE)            
    FROM DB_2025.evaluacion
    UNION
    SELECT CAST(fecha_emision AS DATE)    
    FROM DB_2025.factura
    UNION
    SELECT CAST(fecha_vencimiento AS DATE)
    FROM DB_2025.factura
    UNION
    SELECT CAST(fecha AS DATE)            
    FROM DB_2025.pago
    UNION
    SELECT CAST(fecha_registro AS DATE)   
    FROM DB_2025.encuesta
    UNION
    SELECT CAST(fecha_final AS DATE)            
    FROM DB_2025.instancia_final
    UNION
    SELECT CAST(fecha_inicio AS DATE)    
    FROM DB_2025.curso
) 

INSERT INTO DB_2025_BI.BI_Dim_Tiempo (fecha, anio, mes, cuatrimestre)
SELECT DISTINCT
    f.fecha,
    YEAR(f.fecha) AS anio,
    MONTH(f.fecha) AS mes,
    CASE 
        WHEN MONTH(f.fecha) BETWEEN 1 AND 4  THEN 1
        WHEN MONTH(f.fecha) BETWEEN 5 AND 8  THEN 2
        ELSE 3
    END AS cuatrimestre
FROM Fechas f
WHERE f.fecha IS NOT NULL;
GO

------------------------
-- Dim_Alumno
------------------------

INSERT INTO DB_2025_BI.BI_Dim_Alumno (legajo, dni, nombre, apellido, rango_etario)
SELECT DISTINCT
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
FROM DB_2025.alumno a;
GO

------------------------
-- Dim_Profesor
------------------------

INSERT INTO DB_2025_BI.BI_Dim_Profesor (nombre, apellido, dni, rango_etario)
SELECT DISTINCT
    p.nombre,
    p.apellido,
    p.dni,
    CASE
        WHEN DATEDIFF(YEAR, p.fecha_nacimiento, GETDATE()) BETWEEN 25 AND 35 THEN '25-35'
        WHEN DATEDIFF(YEAR, p.fecha_nacimiento, GETDATE()) BETWEEN 36 AND 50 THEN '36-50'
        ELSE '>50'
    END AS rango_etario
FROM DB_2025.profesor p;
GO

------------------------
-- Dim_Sede
------------------------

INSERT INTO DB_2025_BI.BI_Dim_Sede (id_sede, nombre_sede, direccion, localidad, provincia)
SELECT DISTINCT
    s.id_sede,
    s.nombre,
    s.direccion,
    l.nombre AS localidad,
    pr.provincia_nombre AS provincia
FROM DB_2025.sede s
LEFT JOIN DB_2025.Localidad l ON l.codigo_localidad = s.codigo_localidad
LEFT JOIN DB_2025.Provincia pr ON pr.provincia_nombre = l.provincia;
GO

------------------------
-- Dim_Curso
------------------------

INSERT INTO DB_2025_BI.BI_Dim_Curso (codigo_curso, nombre_curso, categoria, turno, fecha_inicio)
SELECT DISTINCT
    c.codigo_curso,
    c.nombre,
    cat.nombre_categoria AS categoria,
    c.turno_curso AS turno,
    c.fecha_inicio AS fecha_inicio
FROM DB_2025.curso c
LEFT JOIN DB_2025.categoria cat ON cat.id_categoria = c.categoria;
GO

------------------------
-- Dim_Medio_Pago
------------------------

INSERT INTO DB_2025_BI.BI_Dim_Medio_Pago (id_medio_pago, nombre_medio)
SELECT DISTINCT
    mp.id_medio,
    mp.nombre_medio
FROM DB_2025.medio_pago mp;
GO

------------------------
-- Dim_Estado_Inscripcion
------------------------

INSERT INTO DB_2025_BI.BI_Dim_Estado_Inscripcion (estado)
SELECT DISTINCT 
    ei.estado 
FROM DB_2025.estado_inscripcion ei;
GO

------------------------
-- Dim_Bloque_Satisfaccion 
------------------------
INSERT INTO DB_2025_BI.BI_Dim_Bloque_Satisfaccion (nivel_satisfaccion, nota_minima, nota_maxima)
VALUES
('Insatisfechos', 1, 4),
('Neutrales', 5, 6),
('Satisfechos', 7, 10);
GO

/* =========================================================
= = = = = = = =  4) CARGADO DE HECHOS   = = = = = =
========================================================= */

------------------------
-- Hecho_Pago
------------------------

INSERT INTO DB_2025_BI.BI_Hecho_Pago (id_alumno, id_curso, id_sede, id_medio_pago, id_fecha_pago, numero_factura, importe_pago, pago_vencido)
SELECT
    da.id_alumno,
    dc.id_curso,
    ds.id_sede,
    dmp.id_medio_pago,
    dtp.id_fecha, -- fecha del pago
    f.numero_factura, -- o p.numero_factura, es lo mismo por el JOIN
    p.importe,
    CASE WHEN p.fecha > f.fecha_vencimiento THEN 1  -- pago después del vencimiento
           ELSE 0
      END AS pago_vencido
FROM DB_2025.pago p
JOIN DB_2025.factura f ON f.numero_factura = p.numero_factura
JOIN DB_2025.detalle_factura df ON df.numero_factura = f.numero_factura
JOIN DB_2025.curso c ON c.codigo_curso = df.codigo_curso
JOIN DB_2025.sede s ON s.id_sede = c.sede
JOIN DB_2025.medio_pago mp ON mp.id_medio = p.medio_pago
JOIN DB_2025_BI.BI_Dim_Curso dc ON dc.codigo_curso = c.codigo_curso
JOIN DB_2025_BI.BI_Dim_Alumno da ON da.legajo = f.legajo_alumno
JOIN DB_2025_BI.BI_Dim_Sede ds ON ds.id_sede = s.id_sede
JOIN DB_2025_BI.BI_Dim_Medio_Pago dmp ON dmp.id_medio_pago = mp.id_medio
JOIN DB_2025_BI.BI_Dim_Tiempo dtp ON dtp.fecha = CAST(p.fecha AS DATE);
GO

------------------------
-- Hecho_Cursada
------------------------

WITH Notas_Parciales AS (
    SELECT 
        e.alumno_legajo,
        m.codigo_curso,
		-- Valido el isnull porque en nuestro modelo transaccional si alguien esta ausente NO tiene nota (ella no es 0)
        MIN(ISNULL(e.nota, 0)) as nota_minima --Aca agarro la menor de las notas, con que halla una menor o igual a 4 no aprueba. 
    FROM DB_2025.Evaluacion e
    JOIN DB_2025.Modulo m ON m.id_modulo = e.id_modulo
    GROUP BY e.alumno_legajo, m.codigo_curso
)

INSERT INTO DB_2025_BI.BI_Hecho_Cursada (id_alumno, id_curso, id_profesor, id_fecha_inicio, id_sede, es_aprobado)
SELECT 
    da.id_alumno,
    dc.id_curso,
    dp.id_profesor,
    dt.id_fecha,
    ds.id_sede,
    CASE 
        WHEN tp.nota >= 4 AND np.nota_minima >= 4 THEN 1 
        ELSE 0 
    END AS es_aprobado
FROM DB_2025.Inscripcion i
JOIN DB_2025.Curso c ON c.codigo_curso = i.codigo_curso
LEFT JOIN DB_2025.Trabajo_Practico tp ON (tp.codigo_curso = i.codigo_curso AND tp.legajo_alumno = i.legajo)
LEFT JOIN Notas_Parciales np ON (np.codigo_curso = i.codigo_curso AND np.alumno_legajo = i.legajo)
JOIN DB_2025_BI.BI_Dim_Alumno da ON da.legajo = i.legajo
JOIN DB_2025_BI.BI_Dim_Curso dc ON dc.codigo_curso = i.codigo_curso
JOIN DB_2025_BI.BI_Dim_Profesor dp ON dp.id_profesor = c.profesor
JOIN DB_2025_BI.BI_Dim_Sede ds ON ds.id_sede = c.sede 
JOIN DB_2025_BI.BI_Dim_Tiempo dt ON dt.fecha = CAST(c.fecha_inicio AS DATE);
GO

------------------------
-- Hecho_Inscripcion
------------------------

INSERT INTO DB_2025_BI.BI_Hecho_Inscripcion (id_alumno, id_curso, id_fecha_inscripcion, id_sede, id_estado_inscripcion, es_rechazada)
SELECT DISTINCT
    da.id_alumno,
    dc.id_curso,
    dt.id_fecha,
    ds.id_sede,
    dei.id_estado_inscripcion,

    CASE WHEN i.estado = 'Rechazada' THEN 1 ELSE 0 END AS es_rechazada
FROM DB_2025.Inscripcion i
JOIN DB_2025_BI.BI_Dim_Alumno da ON da.legajo = i.legajo
JOIN DB_2025_BI.BI_Dim_Curso dc ON dc.codigo_curso = i.codigo_curso
JOIN DB_2025_BI.BI_Dim_Tiempo dt ON dt.fecha = CAST(i.fecha_inscripcion AS DATE)
JOIN DB_2025.Curso c ON c.codigo_curso = i.codigo_curso
JOIN DB_2025.Sede s ON s.id_sede = c.sede 
JOIN DB_2025_BI.BI_Dim_Sede ds ON ds.id_sede = s.id_sede
JOIN DB_2025_BI.BI_Dim_Estado_Inscripcion dei ON dei.estado = i.estado;
GO

------------------------
-- Hecho_Encuesta
------------------------

INSERT INTO DB_2025_BI.BI_Hecho_Encuesta(id_curso, id_profesor, id_sede, id_fecha_encuesta, id_bloque_satisfaccion, nota_promedio_encuesta)
SELECT
    dc.id_curso,
    dp.id_profesor,
    ds.id_sede,
    dt.id_fecha,
    dbs.id_bloque_satisfaccion,
    AVG(r.nota_dada)
FROM DB_2025.Respuesta r
JOIN DB_2025.Encuesta e ON e.id_encuesta = r.id_encuesta
JOIN DB_2025.Curso c ON c.codigo_curso = e.codigo_curso
JOIN DB_2025.Profesor p ON p.id_profesor = c.profesor
JOIN DB_2025_BI.BI_Dim_Profesor dp ON dp.id_profesor = p.id_profesor
JOIN DB_2025_BI.BI_Dim_Curso dc ON dc.codigo_curso = c.codigo_curso
JOIN DB_2025.Sede s ON s.id_sede = c.sede
JOIN DB_2025_BI.BI_Dim_Sede ds ON ds.id_sede = s.id_sede
JOIN DB_2025_BI.BI_Dim_Tiempo dt ON dt.fecha = CAST(e.fecha_registro AS DATE)
JOIN DB_2025_BI.BI_Dim_Bloque_Satisfaccion dbs ON r.nota_dada BETWEEN dbs.nota_minima AND dbs.nota_maxima
GROUP BY
    dc.id_curso,
    dp.id_profesor,
    ds.id_sede,
    dt.id_fecha,
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
    ef.nota,
    CASE
        WHEN ef.presente = 1 THEN 1
        ELSE 0
    END AS es_presente_final,
    CASE
        WHEN ef.nota >= 4 THEN 1
        ELSE 0
    END AS es_aprobado_final
FROM DB_2025.Evaluacion_Final ef
JOIN DB_2025.Alumno a ON a.legajo = ef.legajo_alumno
JOIN DB_2025_BI.BI_Dim_Alumno da ON da.legajo = a.legajo
JOIN DB_2025.instancia_final i ON i.id_instancia = ef.id_instancia
JOIN DB_2025.curso c ON c.codigo_curso = i.codigo_curso
JOIN DB_2025_BI.BI_Dim_Curso dc ON dc.codigo_curso = c.codigo_curso
JOIN DB_2025.profesor p ON p.id_profesor = c.profesor
JOIN DB_2025_BI.BI_Dim_Profesor dp ON dp.id_profesor = p.id_profesor
JOIN DB_2025.sede s ON s.id_sede = c.sede
JOIN DB_2025_BI.BI_Dim_Sede ds ON ds.id_sede = s.id_sede
JOIN DB_2025_BI.BI_Dim_Tiempo dt ON dt.fecha = CAST(i.fecha_final AS DATE)
GO

------------------------
-- Hecho_Venta
------------------------

INSERT INTO DB_2025_BI.BI_Hecho_Venta (id_alumno, id_curso, id_sede, id_fecha_emision, id_fecha_vencimiento, numero_factura, importe_ventas)
    SELECT
        da.id_alumno,
        dc.id_curso,
        ds.id_sede,
        dt_emision.id_fecha,
        dt_venc.id_fecha,
        f.numero_factura,
        f.total
    FROM DB_2025.Detalle_Factura df
    JOIN DB_2025.Factura f ON df.numero_factura = f.numero_factura
    JOIN DB_2025.Curso c ON c.codigo_curso = df.codigo_curso
    JOIN DB_2025_BI.BI_Dim_Alumno da ON da.legajo = f.legajo_alumno
    JOIN DB_2025_BI.BI_Dim_Curso dc ON dc.codigo_curso = df.codigo_curso
    JOIN DB_2025_BI.BI_Dim_Sede ds ON ds.id_sede = c.sede
    JOIN DB_2025_BI.BI_Dim_Tiempo dt_emision ON dt_emision.fecha = CAST(f.fecha_emision AS DATE)
    JOIN DB_2025_BI.BI_Dim_Tiempo dt_venc ON dt_venc.fecha = CAST(f.fecha_vencimiento AS DATE);
GO

/* =========================================================
= = = = = = = =  5) CREADO DE VISTAS   = = = = = =
========================================================= */

------------------------
-- VISTA 1 
------------------------

CREATE VIEW DB_2025_BI.BI_VW_Top3_Categorias_Y_Turnos 
AS
    WITH Ranking_Categorias AS (
        SELECT 
            t.anio,
            s.nombre_sede,
            c.categoria AS valor_analizado,
            'Categoria' AS tipo_criterio,
            COUNT(*) AS cantidad_inscriptos,
            DENSE_RANK() OVER (
                PARTITION BY t.anio, s.id_sede
                ORDER BY COUNT(*) DESC
            ) AS ranking
        FROM DB_2025_BI.BI_Hecho_Inscripcion hi
        JOIN DB_2025_BI.BI_Dim_Tiempo t ON hi.id_fecha_inscripcion = t.id_fecha
        JOIN DB_2025_BI.BI_Dim_Sede s ON hi.id_sede = s.id_sede
        JOIN DB_2025_BI.BI_Dim_Curso c ON hi.id_curso = c.id_curso
        GROUP BY t.anio, s.id_sede, s.nombre_sede, c.categoria
    ),
    Ranking_Turnos AS (
        SELECT 
            t.anio,
            s.nombre_sede,
            c.turno AS valor_analizado,
            'Turno' AS tipo_criterio,
            COUNT(*) AS cantidad_inscriptos,
            DENSE_RANK() OVER (
                PARTITION BY t.anio, s.id_sede
                ORDER BY COUNT(*) DESC
            ) AS ranking
        FROM DB_2025_BI.BI_Hecho_Inscripcion hi
        JOIN DB_2025_BI.BI_Dim_Tiempo t ON hi.id_fecha_inscripcion = t.id_fecha
        JOIN DB_2025_BI.BI_Dim_Sede s ON hi.id_sede = s.id_sede
        JOIN DB_2025_BI.BI_Dim_Curso c ON hi.id_curso = c.id_curso
        GROUP BY t.anio, s.id_sede, s.nombre_sede, c.turno
    )

    SELECT * 
    FROM Ranking_Categorias 
    WHERE ranking <= 3
    UNION ALL
    SELECT * 
    FROM Ranking_Turnos 
    WHERE ranking <= 3;
GO

------------------------
-- VISTA 2 
------------------------

CREATE VIEW DB_2025_BI.BI_vw_Tasa_Rechazo_Inscripciones
AS
    SELECT
        s.nombre_sede,
        t.anio,
        t.mes,
        COUNT(*) AS total_inscripciones,
        SUM(hi.es_rechazada) AS total_rechazadas,
        CAST(
            SUM(hi.es_rechazada) * 100.0 / NULLIF(COUNT(*), 0)
            AS DECIMAL(10,2)
        ) AS porcentaje_rechazo
    FROM DB_2025_BI.BI_Hecho_Inscripcion hi
    JOIN DB_2025_BI.BI_Dim_Sede s    ON s.id_sede = hi.id_sede
    JOIN DB_2025_BI.BI_Dim_Tiempo t  ON t.id_fecha = hi.id_fecha_inscripcion
    GROUP BY 
        s.nombre_sede, 
        t.anio, 
        t.mes;
GO

------------------------
-- VISTA 3
------------------------

CREATE VIEW DB_2025_BI.BI_vw_Desempeno_Cursada_Sede
AS
    SELECT
        s.nombre_sede,
        t.anio,
        (SUM(hc.es_aprobado) * 100.0 / NULLIF(COUNT(*), 0)) AS porcentaje_aprobacion
    FROM DB_2025_BI.BI_Hecho_Cursada hc
    JOIN DB_2025_BI.BI_Dim_Sede s   ON s.id_sede = hc.id_sede
    JOIN DB_2025_BI.BI_Dim_Tiempo t ON t.id_fecha = hc.id_fecha_inicio
    GROUP BY
        s.nombre_sede,
        t.anio;
GO

------------------------
-- VISTA 4
------------------------

CREATE VIEW DB_2025_BI.BI_vw_Tiempo_Promedio_Finalizacion_Curso
AS
    SELECT
        YEAR(dc.fecha_inicio) AS anio_inicio_curso,
        dc.categoria,

        CAST(
            AVG(
                CAST(DATEDIFF(DAY, dc.fecha_inicio, dt.fecha) AS DECIMAL(10,2))
            ) 
        AS DECIMAL(10,2)) AS tiempo_promedio_dias
    FROM DB_2025_BI.BI_Hecho_Examen_Final ef
    JOIN DB_2025_BI.BI_Dim_Curso dc  ON dc.id_curso = ef.id_curso
    JOIN DB_2025_BI.BI_Dim_Tiempo dt ON dt.id_fecha = ef.fecha_evaluacion
    WHERE ef.es_aprobado_final = 1      
    GROUP BY
        YEAR(dc.fecha_inicio),
        dc.categoria
GO

------------------------
-- VISTA 5 
------------------------

CREATE VIEW DB_2025_BI.BI_vw_Nota_Promedio_Finales
AS
    SELECT
        da.rango_etario,
        dc.categoria,
        t.anio,
        
        CASE
            WHEN t.mes BETWEEN 1 AND 6 THEN 1
            ELSE 2
        END AS semestre,
        AVG(ef.nota_final) AS nota_promedio_final
        
    FROM DB_2025_BI.BI_Hecho_Examen_Final ef
    JOIN DB_2025_BI.BI_Dim_Alumno da ON da.id_alumno = ef.id_alumno
    JOIN DB_2025_BI.BI_Dim_Curso dc ON dc.id_curso = ef.id_curso
    JOIN DB_2025_BI.BI_Dim_Tiempo t ON t.id_fecha = ef.fecha_evaluacion
    GROUP BY
        da.rango_etario,
        dc.categoria,
        t.anio,
        CASE
            WHEN t.mes BETWEEN 1 AND 6 THEN 1
            ELSE 2
        END;
GO

------------------------
-- VISTA 6 
------------------------

CREATE VIEW DB_2025_BI.BI_vw_Tasa_Ausentismo_Finales 
AS
    SELECT
        t.anio,
        CASE 
            WHEN t.mes BETWEEN 1 AND 6 THEN 1 
            ELSE 2  
        END AS semestre,
        s.nombre_sede,
        
        SUM(CASE WHEN ef.es_presente_final = 0 THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0) AS porcentaje_ausentismo

    FROM DB_2025_BI.BI_Hecho_Examen_Final ef
    JOIN DB_2025_BI.BI_Dim_Tiempo t ON t.id_fecha = ef.fecha_evaluacion
    JOIN DB_2025_BI.BI_Dim_Sede s ON s.id_sede = ef.id_sede
    GROUP BY
        t.anio,
        CASE 
            WHEN t.mes BETWEEN 1 AND 6 THEN 1 
            ELSE 2 END,
        s.nombre_sede;
GO

------------------------
-- VISTA 7
------------------------

CREATE VIEW DB_2025_BI.BI_vw_Desvio_Pagos
AS
    SELECT
        t.anio,
        CASE 
            WHEN t.mes BETWEEN 1 AND 6 THEN 1 
            ELSE 2 
        END AS semestre,

        SUM(hp.pago_vencido) * 100.0 / NULLIF(COUNT(*),0) AS porcentaje_pagos_fuera_termino

    FROM DB_2025_BI.BI_Hecho_Pago hp
    JOIN DB_2025_BI.BI_Dim_Tiempo t ON t.id_fecha = hp.id_fecha_pago
    GROUP BY
        t.anio,
        CASE WHEN t.mes BETWEEN 1 AND 6 THEN 1 ELSE 2 END;
GO

------------------------
-- VISTA 8
------------------------

CREATE VIEW DB_2025_BI.BI_vw_Tasa_De_Morosidad AS
    WITH Venta_Por_Mes AS (
        SELECT
            hv.id_sede,
            te.anio,
            te.mes,
            hv.numero_factura,
            hv.importe_ventas
        FROM DB_2025_BI.BI_Hecho_Venta hv
        JOIN DB_2025_BI.BI_Dim_Tiempo te ON te.id_fecha = hv.id_fecha_emision
    ),
    Pago_Por_Mes AS (
        SELECT DISTINCT
            hp.numero_factura,
            tp.anio,
            tp.mes
        FROM DB_2025_BI.BI_Hecho_Pago hp
        JOIN DB_2025_BI.BI_Dim_Tiempo tp ON tp.id_fecha = hp.id_fecha_pago
    )
    SELECT
        s.nombre_sede,
        v.anio,
        v.mes,
        SUM(v.importe_ventas) AS facturacion_esperada,
        SUM(CASE WHEN pm.numero_factura IS NULL
                THEN v.importe_ventas ELSE 0 END) AS monto_adeudado,
        CAST(
            SUM(CASE WHEN pm.numero_factura IS NULL
                    THEN v.importe_ventas ELSE 0 END) * 100.0
            / NULLIF(SUM(v.importe_ventas), 0)
            AS DECIMAL(10,2)
        ) AS porcentaje_morosidad
    FROM Venta_Por_Mes v
    JOIN DB_2025_BI.BI_Dim_Sede s ON s.id_sede = v.id_sede
    LEFT JOIN Pago_Por_Mes pm ON pm.numero_factura = v.numero_factura
    AND pm.anio = v.anio
    AND pm.mes  = v.mes
    GROUP BY
        s.nombre_sede,
        v.anio,
        v.mes;
GO

------------------------
-- VISTA 9
------------------------

CREATE VIEW DB_2025_BI.BI_vw_Top3_Ingresos_Categorias AS
    WITH RankingIngresos AS (
        SELECT
            t.anio,
            s.nombre_sede,
            c.categoria,
            SUM(hp.importe_pago) AS total_ingresos,
            ROW_NUMBER() OVER (
                PARTITION BY t.anio, s.id_sede
                ORDER BY SUM(hp.importe_pago) DESC
            ) AS ranking
        FROM DB_2025_BI.BI_Hecho_Pago hp
        JOIN DB_2025_BI.BI_Dim_Tiempo t ON t.id_fecha = hp.id_fecha_pago
        JOIN DB_2025_BI.BI_Dim_Sede s ON s.id_sede = hp.id_sede
        JOIN DB_2025_BI.BI_Dim_Curso c ON c.id_curso = hp.id_curso
        GROUP BY t.anio, s.id_sede, s.nombre_sede, c.categoria
    )
    SELECT * FROM RankingIngresos
    WHERE ranking <= 3;
GO

------------------------
-- VISTA 10
------------------------

CREATE VIEW DB_2025_BI.BI_vw_Indice_Satisfaccion AS
    SELECT
        s.nombre_sede,
        dp.rango_etario as rango_etario_profesor,
        t.anio,
        COUNT(*) AS total_encuestas,
        SUM(CASE WHEN he.nota_promedio_encuesta BETWEEN 7 AND 10 THEN 1 ELSE 0 END) AS total_satisfechos,
        SUM(CASE WHEN he.nota_promedio_encuesta BETWEEN 5 AND 6 THEN 1 ELSE 0 END) AS total_neutrales,
        SUM(CASE WHEN he.nota_promedio_encuesta BETWEEN 1 AND 4 THEN 1 ELSE 0 END) AS total_insatisfechos,
        CAST(
            (
                (CAST(SUM(CASE WHEN he.nota_promedio_encuesta BETWEEN 7 AND 10 THEN 1 ELSE 0 END) AS float) * 100.0) / NULLIF(COUNT(*), 0)
                -
                (CAST(SUM(CASE WHEN he.nota_promedio_encuesta BETWEEN 1 AND 4 THEN 1 ELSE 0 END) AS float) * 100.0) / NULLIF(COUNT(*), 0)
                + 100
            ) / 2.0
        AS DECIMAL(10,2)) AS indice_satisfaccion
    FROM DB_2025_BI.BI_Hecho_Encuesta he
    JOIN DB_2025_BI.BI_Dim_Sede s ON s.id_sede = he.id_sede
    JOIN DB_2025_BI.BI_Dim_Profesor dp ON dp.id_profesor = he.id_profesor
    JOIN DB_2025_BI.BI_Dim_Tiempo t ON t.id_fecha = he.id_fecha_encuesta
    GROUP BY
        s.nombre_sede,
        dp.rango_etario,
        t.anio;
GO