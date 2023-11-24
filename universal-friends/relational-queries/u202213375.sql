--mostrar los alumnos y la carrera a la q pertenecen

select u.nombre, u.apellido_paterno, u.apellido_materno, c.nombre as carrera
from usuarios u
	join carreras c on u.codigo_carrera = c.codigo

--mostrar docentes, curso q enseñan y comentarios del mismo

select d.nombre as Nombre_docente, d.apellido_paterno, d.apellido_materno,
       c.nombre as Nombre_curso, v.Comentario
from valoraciones v
	join docentes d on v.codigo_docente_valorado = d.codigo
	join cursos c on v.codigo_curso = c.codigo
go

-- Crear vista para detalles de usuarios con perfiles
create view view_usuarios_con_perfiles as
select
    u.codigo as codigo_usuario,
    u.nombre,
    u.apellido_paterno,
    u.apellido_materno,
    u.correo_electronico,
    u.fecha_de_registro,
    c.nombre as nombre_carrera,
    p.nombre_perfil,
    p.descripcion as descripcion_perfil,
    p.url_foto_perfil
from
    usuarios u
		JOIN carreras c on u.codigo_carrera = c.codigo
		LEFT JOIN perfiles_de_usuario p on u.codigo = p.codigo_usuario
----- Consultar detalles de usuarios con perfiles
SELECT *
FROM view_usuarios_con_perfiles
