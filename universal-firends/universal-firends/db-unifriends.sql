CREATE DATABASE universal_friends
GO

USE universal_friends
GO

CREATE TABLE carreras (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL
)
GO

CREATE TABLE usuarios (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    apellido_paterno VARCHAR(100) NOT NULL,
    apellido_materno VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    contrasenia VARCHAR(100) NOT NULL,
    fecha_de_registro DATE DEFAULT CONVERT(DATE, GETDATE()),
    codigo_carrera INT NOT NULL FOREIGN KEY REFERENCES carreras(codigo),
    fecha_de_nacimiento DATE NOT NULL
)
GO

CREATE TABLE perfiles_de_usuario (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    codigo_usuario INT FOREIGN KEY REFERENCES usuarios(codigo),
    nombre_perfil VARCHAR(15) NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    foto_perfil IMAGE NOT NULL
)
GO

CREATE TABLE intereses (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL
)
GO

CREATE TABLE interes_usuario (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    codigo_usuario INT FOREIGN KEY REFERENCES usuarios(codigo),
    codigo_interes INT FOREIGN KEY REFERENCES intereses(codigo)
)
GO

CREATE TABLE amistades (
    usuario1 INT NOT NULL,
    usuario2 INT NOT NULL,
    PRIMARY KEY (usuario1, usuario2),
    FOREIGN KEY (usuario1) REFERENCES usuarios(codigo),
    FOREIGN KEY (usuario2) REFERENCES usuarios(codigo),
    fecha_inicio DATETIME NOT NULL DEFAULT GETDATE()
)
GO

CREATE TABLE sedes (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
)
GO

CREATE TABLE aulas (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    piso INT NOT NULL,
    pabellon CHAR(1) NOT NULL,
    codigo_sede INT NOT NULL FOREIGN KEY REFERENCES sedes(codigo)
)
GO

CREATE TABLE cursos(
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
)
GO

CREATE TABLE chats (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1)
)
GO

CREATE TABLE usuario_chat (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    codigo_usuario INT NOT NULL FOREIGN KEY REFERENCES usuarios(codigo),
    codigo_chat INT NOT NULL FOREIGN KEY REFERENCES chats(codigo)
)
GO

CREATE TABLE mensajes (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    fecha_hora DATETIME NOT NULL DEFAULT GETDATE(),
    codigo_usuario_chat INT NOT NULL FOREIGN KEY REFERENCES usuario_chat(codigo),
    contenido TEXT NOT NULL
)
GO

CREATE TABLE docentes (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    apellido_paterno VARCHAR(100) NOT NULL,
    apellido_materno VARCHAR(100) NOT NULL
)
GO

CREATE TABLE tipos_notificacion (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    tipo VARCHAR(100) NOT NULL
)
GO

CREATE TABLE notificaciones (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    codigo_receptor INT NOT NULL FOREIGN KEY REFERENCES usuarios(codigo),
    codigo_tipo_notificacion INT NOT NULL FOREIGN KEY REFERENCES tipos_notificacion(codigo),
    contenido VARCHAR(100) NOT NULL,
    fecha_hora DATETIME NOT NULL DEFAULT GETDATE()
)
GO

CREATE TABLE secciones (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(4) NOT NULL,
    codigo_curso INT NOT NULL FOREIGN KEY REFERENCES cursos(codigo)
)
GO

CREATE TABLE sesiones_de_clase (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    dia_semana VARCHAR(10) NOT NULL,
    codigo_seccion INT NOT NULL FOREIGN KEY REFERENCES secciones(codigo),
    codigo_aula INT NOT NULL FOREIGN KEY REFERENCES aulas(codigo),
)
GO

CREATE TABLE cargos (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(100) NOT NULL
)
GO

CREATE TABLE seccion_docente (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    codigo_seccion INT NOT NULL FOREIGN KEY REFERENCES secciones(codigo),
    codigo_docente INT NOT NULL FOREIGN KEY REFERENCES docentes(codigo),
    codigo_cargo INT NOT NULL FOREIGN KEY REFERENCES cargos(codigo),
)
GO

CREATE TABLE seccion_alumno (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    codigo_seccion INT NOT NULL FOREIGN KEY REFERENCES secciones(codigo),
    codigo_alumno INT NOT NULL FOREIGN KEY REFERENCES usuarios(codigo)
)
GO

CREATE TABLE valoraciones (
    codigo INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    codigo_usuario INT NOT NULL FOREIGN KEY REFERENCES usuarios(codigo),
    codigo_docente_valorado INT NOT NULL FOREIGN KEY REFERENCES docentes(codigo),
    codigo_curso INT NOT NULL FOREIGN KEY REFERENCES cursos(codigo),
    comentario VARCHAR(200) NOT NULL,
    puntuacion SMALLINT NOT NULL
)
GO
