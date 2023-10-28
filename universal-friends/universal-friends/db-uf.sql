CREATE DATABASE universal_friends
GO

USE universal_friends
GO


CREATE TABLE carreras
(
    codigo INT          NOT NULL IDENTITY (1,1),
    nombre VARCHAR(100) NOT NULL
    CONSTRAINT pk_carreras PRIMARY KEY (codigo)
)
GO

CREATE TABLE usuarios
(
    codigo              INT          NOT NULL IDENTITY (1,1),
    nombre              VARCHAR(100) NOT NULL,
    apellido_paterno    VARCHAR(100) NOT NULL,
    apellido_materno    VARCHAR(100) NOT NULL,
    correo_electronico  VARCHAR(100) NOT NULL,
    contrasenia         VARCHAR(100) NOT NULL,
    fecha_de_registro   DATE DEFAULT CONVERT(DATE, GETDATE()),
    codigo_carrera      INT          NOT NULL,
    fecha_de_nacimiento DATE         NOT NULL
    CONSTRAINT pk_usuarios PRIMARY KEY (codigo),
    CONSTRAINT fk_usuarios_carreras FOREIGN KEY (codigo_carrera) REFERENCES carreras(codigo)
)
GO

CREATE TABLE perfiles_de_usuario
(
    codigo          INT          NOT NULL IDENTITY (1,1),
    codigo_usuario  INT          NOT NULL,
    nombre_perfil   VARCHAR(15)  NOT NULL,
    descripcion     VARCHAR(200) NOT NULL,
    url_foto_perfil VARCHAR(200) NOT NULL,
    CONSTRAINT pk_perfiles_de_usuario PRIMARY KEY (codigo),
    CONSTRAINT fk_perfiles_de_usuario_usuarios FOREIGN KEY (codigo_usuario) REFERENCES usuarios(codigo)
)
GO

CREATE TABLE intereses
(
    codigo INT          NOT NULL IDENTITY (1,1),
    nombre VARCHAR(100) NOT NULL,
    CONSTRAINT pk_intereses PRIMARY KEY (codigo)
)
GO

CREATE TABLE interes_usuario
(
    codigo         INT NOT NULL IDENTITY (1,1),
    codigo_usuario INT NOT NULL,
    codigo_interes INT NOT NULL,
    CONSTRAINT pk_interes_usuario PRIMARY KEY (codigo),
    CONSTRAINT fk_interes_usuario_usuarios FOREIGN KEY (codigo_usuario) REFERENCES usuarios(codigo),
    CONSTRAINT fk_interes_usuario_intereses FOREIGN KEY (codigo_interes) REFERENCES intereses(codigo)
)
GO

CREATE TABLE amistades
(
    usuario1     INT      NOT NULL,
    usuario2     INT      NOT NULL,
    FOREIGN KEY (usuario1) REFERENCES usuarios (codigo),
    FOREIGN KEY (usuario2) REFERENCES usuarios (codigo),
    fecha_inicio DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT pk_amistades PRIMARY KEY (usuario1, usuario2),
    CONSTRAINT fk_amistades_usuarios_1 FOREIGN KEY (usuario1) REFERENCES usuarios(codigo),
    CONSTRAINT fk_amistades_usuarios_2 FOREIGN KEY (usuario2) REFERENCES usuarios(codigo)
)
GO

CREATE TABLE sedes
(
    codigo    INT          NOT NULL IDENTITY (1,1),
    nombre    VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    CONSTRAINT pk_sedes PRIMARY KEY (codigo)
)
GO

CREATE TABLE aulas
(
    codigo      INT     NOT NULL  IDENTITY (1,1),
    piso        INT     NOT NULL,
    pabellon    CHAR(1) NOT NULL,
    codigo_sede INT     NOT NULL,
    CONSTRAINT pk_aulas PRIMARY KEY (codigo),
    CONSTRAINT fk_aulas_sedes FOREIGN KEY (codigo_sede) REFERENCES sedes(codigo)
)
GO

CREATE TABLE cursos
(
    codigo INT          NOT NULL IDENTITY (1,1),
    nombre VARCHAR(100) NOT NULL,
    CONSTRAINT pk_cursos PRIMARY KEY (codigo)
)
GO

CREATE TABLE chats
(
    codigo INT NOT NULL IDENTITY (1,1),
    CONSTRAINT pk_chats PRIMARY KEY (codigo)
)
GO

CREATE TABLE usuario_chat
(
    codigo         INT NOT NULL IDENTITY (1,1),
    codigo_usuario INT NOT NULL,
    codigo_chat    INT NOT NULL,
    CONSTRAINT pk_usuario_chat PRIMARY KEY (codigo),
    CONSTRAINT fk_usuario_chat_usuarios FOREIGN KEY (codigo_usuario) REFERENCES usuarios(codigo),
    CONSTRAINT fk_usuario_chat_chats FOREIGN KEY (codigo_chat) REFERENCES chats(codigo)
)
GO

CREATE TABLE mensajes
(
    codigo              INT      NOT NULL IDENTITY (1,1),
    fecha_hora          DATETIME NOT NULL DEFAULT GETDATE(),
    codigo_usuario_chat INT      NOT NULL,
    contenido           TEXT     NOT NULL,
    CONSTRAINT pk_mensajes PRIMARY KEY (codigo),
    CONSTRAINT fk_mensajes_usuario_chat FOREIGN KEY (codigo_usuario_chat) REFERENCES usuario_chat(codigo)
)
GO

CREATE TABLE docentes
(
    codigo           INT          NOT NULL IDENTITY (1,1),
    nombre           VARCHAR(100) NOT NULL,
    apellido_paterno VARCHAR(100) NOT NULL,
    apellido_materno VARCHAR(100) NOT NULL
    CONSTRAINT pk_docentes PRIMARY KEY (codigo)
)
GO

CREATE TABLE tipos_notificacion
(
    codigo INT          NOT NULL IDENTITY (1,1),
    tipo   VARCHAR(100) NOT NULL,
    CONSTRAINT pk_tipos_notificacion PRIMARY KEY (codigo)
)
GO

CREATE TABLE notificaciones
(
    codigo                   INT          NOT NULL IDENTITY (1,1),
    codigo_receptor          INT          NOT NULL,
    codigo_tipo_notificacion INT          NOT NULL,
    contenido                VARCHAR(100) NOT NULL,
    fecha_hora               DATETIME     NOT NULL DEFAULT GETDATE(),
    CONSTRAINT pk_notificaciones PRIMARY KEY (codigo),
    CONSTRAINT fk_notificaciones_usuarios FOREIGN KEY (codigo_receptor) REFERENCES usuarios(codigo),
    CONSTRAINT fk_notificaciones_tipos_notificacion FOREIGN KEY (codigo_tipo_notificacion) REFERENCES tipos_notificacion(codigo)
)
GO

CREATE TABLE secciones
(
    codigo       INT        NOT NULL IDENTITY (1,1),
    nombre       VARCHAR(4) NOT NULL,
    codigo_curso INT        NOT NULL,
    CONSTRAINT pk_secciones PRIMARY KEY (codigo),
    CONSTRAINT fk_secciones_cursos FOREIGN KEY (codigo_curso) REFERENCES cursos(codigo)
)
GO

CREATE TABLE sesiones_de_clase
(
    codigo         INT         NOT NULL IDENTITY (1,1),
    hora_inicio    TIME        NOT NULL,
    hora_fin       TIME        NOT NULL,
    dia_semana     VARCHAR(10) NOT NULL,
    codigo_seccion INT         NOT NULL,
    codigo_aula    INT         NOT NULL,
    CONSTRAINT pk_sesiones_de_clase PRIMARY KEY (codigo),
    CONSTRAINT fk_sesiones_de_clase_secciones FOREIGN KEY (codigo_seccion) REFERENCES secciones(codigo),
    CONSTRAINT fk_sesiones_de_clase_aula FOREIGN KEY (codigo_aula) REFERENCES aulas(codigo)
)
GO

CREATE TABLE cargos
(
    codigo      INT          NOT NULL IDENTITY (1,1),
    nombre      VARCHAR(100) NOT NULL,
    descripcion VARCHAR(100) NOT NULL
    CONSTRAINT pk_cargos PRIMARY KEY (codigo)
)
GO

CREATE TABLE seccion_docente
(
    codigo         INT NOT NULL IDENTITY (1,1),
    codigo_seccion INT NOT NULL,
    codigo_docente INT NOT NULL,
    codigo_cargo   INT NOT NULL,
    CONSTRAINT pk_seccion_docente PRIMARY KEY (codigo),
    CONSTRAINT fk_seccion_docente_secciones FOREIGN KEY (codigo_seccion) REFERENCES secciones(codigo),
    CONSTRAINT fk_seccion_docente_docentes FOREIGN KEY (codigo_docente) REFERENCES docentes(codigo),
    CONSTRAINT fk_seccion_docente_cargos FOREIGN KEY (codigo_cargo) REFERENCES cargos(codigo),
)
GO

CREATE TABLE seccion_alumno
(
    codigo         INT NOT NULL IDENTITY (1,1),
    codigo_seccion INT NOT NULL,
    codigo_alumno  INT NOT NULL,
    CONSTRAINT pk_seccion_alumno PRIMARY KEY (codigo),
    CONSTRAINT fk_seccion_alumno_secciones FOREIGN KEY (codigo_seccion) REFERENCES secciones(codigo),
    CONSTRAINT fk_seccion_alumno_usuarios FOREIGN KEY (codigo_alumno) REFERENCES usuarios(codigo)
)
GO

CREATE TABLE valoraciones
(
    codigo                  INT          NOT NULL IDENTITY (1,1),
    codigo_usuario          INT          NOT NULL,
    codigo_docente_valorado INT          NOT NULL,
    codigo_curso            INT          NOT NULL,
    comentario              VARCHAR(200) NOT NULL,
    puntuacion              SMALLINT     NOT NULL,
    CONSTRAINT pk_valoraciones PRIMARY KEY (codigo),
    CONSTRAINT fk_valoraciones_usuarios FOREIGN KEY (codigo_usuario) REFERENCES usuarios(codigo),
    CONSTRAINT fk_valoraciones_docentes FOREIGN KEY (codigo_docente_valorado) REFERENCES docentes(codigo),
    CONSTRAINT fk_valoraciones_cursos FOREIGN KEY (codigo_curso) REFERENCES cursos(codigo),
)
GO

-- Insertar carreras
INSERT INTO carreras (nombre)
VALUES ('Ingeniería de Software'),
       ('Ciencias de la Computación'),
       ('Ingeniería de Sistemas'),
       ('Arquitectura'),
       ('Derecho')
GO

-- Insertar usuarios
CREATE PROCEDURE USPInsertsUser @nombre VARCHAR(100),
                                @apellido_paterno VARCHAR(100),
                                @apellido_materno VARCHAR(100),
                                @correo_electronico VARCHAR(100),
                                @contrasenia VARCHAR(100),
                                @codigo_carrera INT,
                                @fecha_de_nacimiento DATE
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        IF (SELECT COUNT(*) FROM usuarios WHERE correo_electronico = @correo_electronico) = 0
            BEGIN
                INSERT INTO usuarios (nombre, apellido_paterno, apellido_materno, correo_electronico, contrasenia,
                                      codigo_carrera, fecha_de_nacimiento)
                VALUES (@nombre, @apellido_paterno, @apellido_materno, @correo_electronico, @contrasenia,
                        @codigo_carrera, @fecha_de_nacimiento);
                COMMIT;
                PRINT 'Usuario insertado exitosamente.';
            END
        ELSE
            BEGIN
                ROLLBACK;
                PRINT 'Error: El correo electrónico ya está en uso.';
            END
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error: Ocurrió un problema al insertar el usuario.';
    END CATCH
END
GO

EXEC USPInsertsUser
     @nombre = 'Juan',
     @apellido_paterno = 'Falcon',
     @apellido_materno = 'Fidencio',
     @correo_electronico = 'u202213113@upc.edu.pe',
     @contrasenia = 'contrasenia123',
     @codigo_carrera = 1,
     @fecha_de_nacimiento = '2005-01-15';
GO

EXEC USPInsertsUser
     @nombre = 'María',
     @apellido_paterno = 'López',
     @apellido_materno = 'García',
     @correo_electronico = 'u202124121@upc.edu.pe',
     @contrasenia = 'maria123',
     @codigo_carrera = 2,
     @fecha_de_nacimiento = '2005-05-20';
GO

EXEC USPInsertsUser
     @nombre = 'Pedro',
     @apellido_paterno = 'Ramírez',
     @apellido_materno = 'Sánchez',
     @correo_electronico = 'u212123352@@upc.edu.pe',
     @contrasenia = 'pedro123',
     @codigo_carrera = 3,
     @fecha_de_nacimiento = '2004-12-10';
GO

EXEC USPInsertsUser
     @nombre = 'Ana',
     @apellido_paterno = 'Martínez',
     @apellido_materno = 'Rodríguez',
     @correo_electronico = 'u201914372@@upc.edu.pe',
     @contrasenia = 'ana123',
     @codigo_carrera = 1,
     @fecha_de_nacimiento = '2005-08-25';
GO

EXEC USPInsertsUser
     @nombre = 'Carlos',
     @apellido_paterno = 'Gómez',
     @apellido_materno = 'Pérez',
     @correo_electronico = 'u20201A376@@upc.edu.pe',
     @contrasenia = 'carlos123',
     @codigo_carrera = 2,
     @fecha_de_nacimiento = '2001-03-18';
GO

-- Insertar perfil de usuario
CREATE PROCEDURE USPInsertsUserProfile @codigo_usuario INT,
                                       @nombre_perfil VARCHAR(15),
                                       @descripcion VARCHAR(200),
                                       @url_foto_perfil VARCHAR(200)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        IF (SELECT COUNT(*) FROM perfiles_de_usuario WHERE codigo_usuario = @codigo_usuario) = 0
            BEGIN
                INSERT INTO perfiles_de_usuario (codigo_usuario, nombre_perfil, descripcion, url_foto_perfil)
                VALUES (@codigo_usuario, @nombre_perfil, @descripcion, @url_foto_perfil);
                COMMIT;
                PRINT 'Perfil de usuario insertado exitosamente.';
            END
        ELSE
            BEGIN
                ROLLBACK;
                PRINT 'Error: El código de usuario ya tiene un perfil asociado.';
            END
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error: Ocurrió un problema al insertar el perfil de usuario.';
    END CATCH
END;
GO

EXEC USPInsertsUserProfile
     @codigo_usuario = 1,
     @nombre_perfil = 'jfalcon',
     @descripcion = 'Estudiante entusiasta de Ingeniería :)',
     @url_foto_perfil = 'https://i.pinimg.com/736x/48/34/ff/4834ffabd058a0ddd91d59191eb23928.jpg';
GO

EXEC USPInsertsUserProfile
     @codigo_usuario = 2,
     @nombre_perfil = 'mlopez',
     @descripcion = 'Nací para programar',
     @url_foto_perfil = 'https://i.pinimg.com/1200x/48/d1/7b/48d17b3d074c9592dbab98f03cf811a2.jpg';
GO

EXEC USPInsertsUserProfile
     @codigo_usuario = 3,
     @nombre_perfil = 'pramirez',
     @descripcion = 'Viva la ciencia',
     @url_foto_perfil = 'https://i.pinimg.com/564x/0e/f3/16/0ef31685a1627a27095ea468a7c62613.jpg';
GO

EXEC USPInsertsUserProfile
     @codigo_usuario = 4,
     @nombre_perfil = 'amartinez',
     @descripcion = 'Nerd desde la cuna',
     @url_foto_perfil = 'https://s2.ppllstatics.com/diariosur/www/multimedia/202208/17/media/cortadas/selfies-kk3F-U1701001684303ktG-1248x770@Diario%20Sur.jpg';
GO

EXEC USPInsertsUserProfile
     @codigo_usuario = 5,
     @nombre_perfil = 'cgomez',
     @descripcion = 'Intentando codear mi vida',
     @url_foto_perfil = 'https://i.pinimg.com/originals/62/7c/af/627cafa588d4db732aad3af40de51955.jpg';
GO

-- Insertar intereses
INSERT INTO intereses (nombre)
VALUES ('Futbol'),
       ('Tecnología'),
       ('Música'),
       ('Cocina'),
       ('Moda')
GO

-- Insertar interes_usuario
INSERT INTO interes_usuario (codigo_usuario, codigo_interes)
VALUES (1, 1),
       (2, 1),
       (3, 2),
       (4, 3),
       (5, 4)
GO

-- Insertar amistad
CREATE PROCEDURE USPInsertsFriendship @usuario1 INT,
                                      @usuario2 INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        IF @usuario1 = @usuario2
            BEGIN
                ROLLBACK;
                PRINT 'Error: No puedes establecer una amistad consigo mismo.';
            END
        ELSE
            BEGIN
                INSERT INTO amistades (usuario1, usuario2)
                VALUES (@usuario1, @usuario2);
                COMMIT;
                PRINT 'Amistad insertada exitosamente.';
            END
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error: Ocurrió un problema al insertar la amistad.';
    END CATCH
END;
GO

EXEC USPInsertsFriendship
     @usuario1 = 1,
     @usuario2 = 2;

EXEC USPInsertsFriendship
     @usuario1 = 1,
     @usuario2 = 3;

EXEC USPInsertsFriendship
     @usuario1 = 2,
     @usuario2 = 3;

EXEC USPInsertsFriendship
     @usuario1 = 4,
     @usuario2 = 5;

EXEC USPInsertsFriendship
     @usuario1 = 3,
     @usuario2 = 5;

-- Insertar sedes
INSERT INTO sedes (nombre, direccion)
VALUES ('San Isidro', 'Av. Gral. Salaverry 2255, San Isidro'),
       ('San Miguel', 'Av. La Marina 2810, San Miguel'),
       ('Villa', 'Av. Alameda San Marcos 11, Chorrillos'),
       ('Monterrico', 'Prolongación Primavera 2390, Santiago de Surco')
GO

-- Insertar aulas
INSERT INTO aulas (piso, pabellon, codigo_sede)
VALUES (2, 'A', 1),
       (3, 'B', 1),
       (1, 'A', 2),
       (4, 'B', 3),
       (3, 'D', 4)
GO

-- Insertar cursos
INSERT INTO cursos (nombre)
VALUES ('Diseño de Base de Datos'),
       ('Matemática Discreta'),
       ('Comprensión y Producción de Lenguaje'),
       ('Fisica 2'),
       ('Programacion 1')
GO

-- Insertar chats
INSERT INTO chats DEFAULT VALUES;
INSERT INTO chats DEFAULT VALUES;
INSERT INTO chats DEFAULT VALUES;
INSERT INTO chats DEFAULT VALUES;
INSERT INTO chats DEFAULT VALUES;
GO

-- Insertar usuario_chat
INSERT INTO usuario_chat(codigo_usuario, codigo_chat)
VALUES (1, 1),
       (2, 1),
       (1, 2),
       (3, 2),
       (2, 3),
       (3, 3),
       (4, 4),
       (5, 4),
       (3, 5),
       (5, 5)
GO

-- Insertar mensajes
INSERT INTO mensajes (codigo_usuario_chat, contenido)
VALUES (1, 'Hola, ¿cómo estás?'),
       (2, 'Estoy genial?'),
       (3, '¿Me ayudas a hacer una tarea?'),
       (5, '¿Irás a Monterrico más tarde?'),
       (7, 'El profesor postergó la tarea :D')
GO

-- Insertar docentes
INSERT INTO docentes (nombre, apellido_paterno, apellido_materno)
VALUES ('Peter', 'Montalvo', 'Garcia'),
       ('Jorge', 'Mayta', 'Guillermo'),
       ('Jeffery', 'Sanchez', 'Burgos'),
       ('Pablo', 'Ore', 'Avila'),
       ('Jesus', 'Acosta', 'Neyra')
GO

-- Insertar tipos_notificacion
INSERT INTO tipos_notificacion (tipo)
VALUES ('Solicitud de amistad'),
       ('Nuevo mensaje'),
       ('Nueva publicación'),
       ('Evento')
GO

-- Insertar notificaciones
INSERT INTO notificaciones (codigo_receptor, codigo_tipo_notificacion, contenido)
VALUES (1, 1, 'amartinez desea ser tu amigo'),
       (2, 3, 'jfalcon ha publicado una nueva foto'),
       (3, 4, 'Nuevo evento en Campus San Isidro: Taller "Sentido de vida"'),
       (4, 4, 'Nuevo evento en Campus San Isidro: Charla "Podcast Lima Criminal"'),
       (5, 2, 'jfalcon te ha enviado un nuevo mensaje')
GO

-- Insertar secciones
INSERT INTO secciones (nombre, codigo_curso)
VALUES ('WX41', 1),
	   ('WX1E', 2),
	   ('WX43', 3),
	   ('SX42', 4),
	   ('SW31', 5)
GO

-- Insertar sesiones de clase
INSERT INTO sesiones_de_clase (hora_inicio, hora_fin, dia_semana, codigo_seccion, codigo_aula)
VALUES ('11:00', '13:00', 'Martes', 1, 1),
	   ('07:00', '09:00', 'Miercoles', 2, 2),
	   ('07:00', '09:00', 'Jueves', 3, 3),
	   ('11:00', '13:00', 'Martes', 4, 4),
	   ('13:00', '15:00', 'Lunes', 5, 5)
GO

-- Insertar cargos
INSERT INTO cargos (nombre, descripcion)
VALUES ('Profesor', 'Docente de la seccion'),
	   ('Asistente de aprendizaje a distancia', 'Apoyo del docente a cargo'),
	   ('Coordinador de curso', 'Encargado de la gestión del curso')
GO

-- Insertar seccion_docente
INSERT INTO seccion_docente (codigo_seccion, codigo_docente, codigo_cargo)
VALUES (1, 2, 3),
	   (2, 5, 3),
	   (3, 4, 1),
	   (4, 3, 2),
	   (5, 1, 1)
GO
	   
-- Insertar seccion_alumno
INSERT INTO seccion_alumno (codigo_alumno, codigo_seccion)
VALUES (1, 1),
	   (2, 1),
	   (3, 1),
	   (4, 2),
	   (5, 2),
	   (1, 3),
	   (3, 3),
	   (4, 3),
	   (5, 3),
	   (1, 4),
	   (2, 4),
	   (4, 4),
	   (5, 4),
	   (2, 5),
	   (4, 5)

-- Insertar valoraciones
INSERT INTO valoraciones (codigo_usuario, codigo_docente_valorado, codigo_curso, comentario, puntuacion)
VALUES (1, 2, 1, 'El mejor docente que he podido conocer', 5),
	   (1, 5, 2, 'Gran profesor', 4),
	   (2, 4, 3, 'Siempre llega tarde a clase', 1),
	   (3, 3, 4, 'Profesor neutral', 3),
	   (5, 1, 5, 'Profesor comprometido con la enseñanza', 5)


--Insertacion de datos
insert into cargos (nombre, descripcion)
	values ('Rector', 'El rector es el líder máximo de la universidad, supervisa todas las operaciones.'),
('Decano', 'Los decanos dirigen facultades o escuelas específicas y supervisan programas academicos.'),
('Director de Admisiones', 'Coordina el proceso de admisiones de nuevos estudiantes.'),
('Profesor', 'Imparte clases, realiza investigaciones academicas.'),
('Director de Investigación', 'Supervisa y coordina las actividades en la universidad.'),
('Director de Asuntos Estudiantiles', 'Se ocupa de la vida estudiantil,orientación, apoyo académico y bienestar estudiantil.'),
('Director de Finanzas', 'Gestiona la administración financiera de la universidad, incluyendo presupuestos y contabilidad'),
('Bibliotecario Universitario', 'Supervisa la biblioteca de la universidad y administra recursos bibliográficos.'),
('Director de Relaciones Públicas', 'Administra las comunicaciones y relaciones públicas de la universidad para mejorar su imagen.'),
('Jefe de Seguridad Universitaria', 'Garantiza la seguridad en el campus universitario.')
go		

/*Insertacion de datos
insert into cargos (nombre, apellido_paterno, apellido_materno)
	values('Merli','Quispe', 'Huaman'), ('Nadia', 'Duplan', 'Ronaldo'), ('Carlos', 'Gomez', 'Rodríguez'), ('Isabela', 'Fernandez', 'Vargas'), ('Diego', 'Silva', 'Molina'), ('Mariana', 'Lopez', 'Gutierrez'), ('Luis', 'Perez', 'Sánchez'), ('Ana', 'Martínez', 'Hernandez'), ('Andres', 'Diaz', 'Suarez'), ('Camila', 'Torres', 'Rojas')
go
*/
--Insertacion de datos
insert into cursos (nombre)
	values('Introducción a la Psicología'), 
('Microeconomía'),
('Literatura Mundial'),
('Química Orgánica'),
('Programación en C++'),
('Historia del Arte'),
('Derecho Constitucional'),
('Biología Celular y Molecular'),
('Sociología de la Desigualdad'),
('Ética Empresarial')
go

--Insertacion de datos
insert into sedes (nombre,direccion)
	values('UPC Villa', 'Avenida Alameda San Marcos cuadra 2, Chorrillos'),
	('UPC San Isidro', 'Cuadra 22 de la avenida Salaverry, San Isidro'),
	('UPC Monterrico', 'Cuadra 23 de la avenida Primavera, Surco'),
	('UPC San Miguel', 'De La Marina, 2810, San Miguel')
go

--Insertacion de datos

insert into intereses (nombre) 
values ('Carrera'), ('Horario'),('Hobbies'), ('Idiomas'), ('Proyectos'), ('Eventos'), ('Ubicacion'), ('Ciclo Academico'), ('Metas Academicas'), ('Viajes')
go

--Insertacion de datos

insert into tipos_notificacion (tipo)
	values ('SMS'), ('Correo'), ('Aplicacion UF')
go

--Insertacion de datos

insert into carreras (nombre)
	values ('Medicina'),
('Ingeniería Civil'),
('Psicología'),
('Administración de Empresas'),
('Ciencias de la Computación'),
('Enfermería'),
('Derecho'),
('Arquitectura'),
('Ciencias Políticas'),
('Ciencias Ambientales')
go

select * from intereses
go