--Obtener los amigos de un usuario:
SELECT u.nombre, u.apellido_paterno, u.apellido_materno
FROM usuarios u
INNER JOIN amistades a ON u.codigo = a.usuario1 OR u.codigo = a.usuario2
WHERE u.codigo = 5; --Usando el codigo del alumno
go

--Buscar mensajes en un chat específico:
SELECT m.fecha_hora, u.nombre, m.contenido
FROM mensajes m
INNER JOIN usuario_chat uc ON m.codigo_usuario_chat = uc.codigo
INNER JOIN usuarios u ON uc.codigo_usuario = u.codigo
WHERE uc.codigo_chat = 1
ORDER BY m.fecha_hora;
go

-- Vista para detalles de valoraciones con comentarios
CREATE VIEW detalle_valoraciones AS
SELECT
    v.codigo AS codigo_valoracion,
    v.codigo_usuario,
    u.nombre AS nombre_usuario,
    v.codigo_docente_valorado,
    d.nombre AS nombre_docente,
    v.codigo_curso,
    c.nombre AS nombre_curso,
    v.comentario,
    v.puntuacion
FROM
    valoraciones v
JOIN
    usuarios u ON v.codigo_usuario = u.codigo
JOIN
    docentes d ON v.codigo_docente_valorado = d.codigo
JOIN
    cursos c ON v.codigo_curso = c.codigo;
go

-- Llamando a la vista
SELECT *
FROM detalle_valoraciones;
