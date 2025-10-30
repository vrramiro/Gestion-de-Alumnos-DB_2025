
select * from DB_2025.Provincia
select * from DB_2025.Localidad
select * from DB_2025.Institucion
select * from DB_2025.Sede
select * from DB_2025.Categoria
select * from DB_2025.Turno
select * from DB_2025.Profesor
select * from DB_2025.Estado_Inscripcion
select * from DB_2025.Alumno
select * from DB_2025.Encuesta
select * from DB_2025.Respuesta
select * from DB_2025.Factura
select * from DB_2025.Medio_Pago
select * from DB_2025.Pago
select * from gd_esquema.Maestra

select * from gd_esquema.Maestra where Factura_Numero = '224250'

select
f.total,
df.importe
from DB_2025.Detalle_Factura df 
join DB_2025.Factura f on f.numero_factura = df.numero_factura 

select distinct
m.Evaluacion_Final_Presente,
m.Evaluacion_Final_Nota,
m.Alumno_Legajo,
m.Alumno_Nombre,
m.Profesor_nombre
from gd_esquema.Maestra m
where m.Evaluacion_Final_Presente is not null

select Evaluacion_Curso_Instancia
from gd_esquema.Maestra

select count(distinct m.Alumno_Dni) as dni_distintos from gd_esquema.Maestra m
select count(distinct m.Alumno_Telefono) as telefonos_distinto from gd_esquema.Maestra m
select count(distinct a.legajo) legajos_distintos from DB_2025.Alumno a
select count(distinct m.Alumno_Legajo) from gd_esquema.Maestra m
select count(distinct m.Alumno_Mail) as mails_distintos from gd_esquema.Maestra m
select count(*) from gd_esquema.Maestra m where exists (select 1 from gd_esquema.Maestra m2 where m2.Alumno_Legajo != m.Alumno_Legajo and m2.Alumno_Mail = m.Alumno_Mail)
select * from DB_2025.Curso
select * from DB_2025.Dia
select * from DB_2025.Curso_Dia
select * from DB_2025.Inscripcion
select count(distinct m.Inscripcion_Numero) from gd_esquema.Maestra m
select count(i.nro_inscripcion) from DB_2025.Inscripcion i
GO