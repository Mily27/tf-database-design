-- mostrar la valorolacion de cada docente

select D.nombre, D.apellido_paterno, D.apellido_materno, comentario as Comentario, puntuacion
from docentes D
	join valoraciones V on D.codigo = V.codigo_docente_valorado
go

-- mostar las sesiones de clase y en qué aula y sede se dicta

select C.codigo as Clase, C.dia_semana as Dia, A.codigo as Aula, S.nombre as Sede
from sedes S
	join aulas A on S.codigo=A.codigo_sede
		join sesiones_de_clase C on A.codigo=C.codigo_aula
go

-- funcion donde se ingresa el codigo de la carrera y retorne la cantidad 
-- de estuduantes según la carrera
create function f_cantidad_estudiantes_por_carrera(@carrera int) returns int
as
begin

		declare @cantidad int
		set @cantidad = (select count(codigo)
								from usuarios
								where codigo_carrera = @carrera
								group by codigo)
		return @cantidad
end
go
-- cantidad de estuduantes según la carrera
select codigo_carrera as Carrera, dbo.f_cantidad_estudiantes_por_carrera(1) as Cantidad
from usuarios
where codigo_carrera = 1
go
