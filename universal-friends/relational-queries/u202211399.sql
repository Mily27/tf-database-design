-- Muestra todos los cursos en los que enseña un docente junto a su respectivo cargo y la cantidad de alumnos matriculados
CREATE FUNCTION f_cantidad_alumnos_por_seccion_de_docente(@codigo_docente INT)
RETURNS TABLE
AS
RETURN
(
    SELECT
        CONCAT(d.nombre, ' ', d.apellido_paterno, ' ', d.apellido_materno) AS nombre_docente,
        sc.nombre AS codigo_seccion,
        c.nombre AS nombre_curso,
        sd.codigo_cargo,
        COUNT(sa.codigo_alumno) AS cantidad_alumnos
    FROM
        seccion_docente sd
    INNER JOIN docentes AS d ON sd.codigo_docente = d.codigo
    INNER JOIN secciones AS sc ON sd.codigo_seccion = sc.codigo
    INNER JOIN cursos AS c ON sc.codigo_curso = c.codigo
    LEFT JOIN seccion_alumno AS sa ON sc.codigo = sa.codigo_seccion
    WHERE
        sd.codigo_docente = @codigo_docente
    GROUP BY
        CONCAT(d.nombre, ' ', d.apellido_paterno, ' ', d.apellido_materno),
        sc.nombre,
        c.nombre,
        sd.codigo_cargo
)
------------------------------------------------------------------------------------------------------------------------------ 

-- Muestra el curso, seccion y los detalles referentes a cada curso que le toca a un alumno en un día específico
CREATE FUNCTION f_clases_alumno_por_dia(
    @codigo_alumno INT,
    @dia_semana VARCHAR(10)
)
    RETURNS TABLE
        AS
        RETURN
            (
                SELECT c.nombre  AS curso,
                       sc.nombre AS seccion,
                       sdc.hora_inicio,
                       sdc.hora_fin,
                       a.codigo  AS codigo_aula,
                       a.piso,
                       a.pabellon,
                       s.nombre  AS nombre_sede
                FROM seccion_alumno AS sa
                         INNER JOIN secciones AS sc ON sa.codigo_seccion = sc.codigo
                         INNER JOIN cursos AS c ON sc.codigo_curso = c.codigo
                         INNER JOIN sesiones_de_clase AS sdc ON sc.codigo = sdc.codigo_seccion
                         INNER JOIN aulas AS a ON sdc.codigo_aula = a.codigo
                         INNER JOIN sedes AS s ON a.codigo_sede = s.codigo
                WHERE SA.codigo_alumno = @codigo_alumno
                  AND sdc.dia_semana = @dia_semana
            )

SELECT *
FROM f_clases_alumno_por_dia(1, 'Martes')
------------------------------------------------------------------------------------------------------------------------------ 
  
-- Cuenta la cantidad de mensajes intercambiados por cada amigo de un usuario específico.
CREATE FUNCTION f_cantidad_mensajes_intercambiados_por_amistad(@codigo INT)
RETURNS TABLE
AS
RETURN
(
    SELECT
        p.nombre_perfil AS nombre_amigo,
        COUNT(M.codigo) AS cantidad_mensajes
    FROM
        amistades AS a
    INNER JOIN usuarios AS u ON a.usuario2 = u.codigo OR a.usuario1 = u.codigo
    INNER JOIN usuario_chat AS uc ON u.codigo = uc.codigo_usuario
    INNER JOIN mensajes AS m ON uc.codigo = m.codigo_usuario_chat
    INNER JOIN perfiles_de_usuario AS p ON u.codigo = p.codigo_usuario
    WHERE u.codigo <> @codigo -- lo utilizamos para no contar los mensajes que el usuario podría enviarse a sí mismo
        AND (a.usuario1 = @codigo OR a.usuario2 = @codigo)
    GROUP BY p.nombre_perfil
);

SELECT * FROM f_cantidad_mensajes_intercambiados_por_amistad(1)
