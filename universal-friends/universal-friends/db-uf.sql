CREATE DATABASE universal_friends
GO

USE universal_friends
GO

CREATE TABLE carreras
(
    codigo INT          NOT NULL IDENTITY (1,1),
    nombre VARCHAR(100) NOT NULL
    CONSTRAINT pk_carreras PRIMARY KEY (codigo)
)
GO

CREATE TABLE usuarios
(
    codigo              INT          NOT NULL IDENTITY (1,1),
    nombre              VARCHAR(100) NOT NULL,
    apellido_paterno    VARCHAR(100) NOT NULL,
    apellido_materno    VARCHAR(100) NOT NULL,
    correo_electronico  VARCHAR(100) NOT NULL,
    contrasenia         VARCHAR(100) NOT NULL,
    fecha_de_registro   DATE DEFAULT CONVERT(DATE, GETDATE()),
    codigo_carrera      INT          NOT NULL,
    fecha_de_nacimiento DATE         NOT NULL
    CONSTRAINT pk_usuarios PRIMARY KEY (codigo),
    CONSTRAINT fk_usuarios_carreras FOREIGN KEY (codigo_carrera) REFERENCES carreras(codigo)
)
GO

CREATE TABLE perfiles_de_usuario
(
    codigo          INT          NOT NULL IDENTITY (1,1),
    codigo_usuario  INT          NOT NULL,
    nombre_perfil   VARCHAR(15)  NOT NULL,
    descripcion     VARCHAR(200) NOT NULL,
    url_foto_perfil VARCHAR(200) NOT NULL,
    CONSTRAINT pk_perfiles_de_usuario PRIMARY KEY (codigo),
    CONSTRAINT fk_perfiles_de_usuario_usuarios FOREIGN KEY (codigo_usuario) REFERENCES usuarios(codigo)
)
GO

CREATE TABLE intereses
(
    codigo INT          NOT NULL IDENTITY (1,1),
    nombre VARCHAR(100) NOT NULL,
    CONSTRAINT pk_intereses PRIMARY KEY (codigo)
)
GO

CREATE TABLE interes_usuario
(
    codigo         INT NOT NULL IDENTITY (1,1),
    codigo_usuario INT NOT NULL,
    codigo_interes INT NOT NULL,
    CONSTRAINT pk_interes_usuario PRIMARY KEY (codigo),
    CONSTRAINT fk_interes_usuario_usuarios FOREIGN KEY (codigo_usuario) REFERENCES usuarios(codigo),
    CONSTRAINT fk_interes_usuario_intereses FOREIGN KEY (codigo_interes) REFERENCES intereses(codigo)
)
GO

CREATE TABLE amistades
(
    usuario1     INT      NOT NULL,
    usuario2     INT      NOT NULL,
    fecha_inicio DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT pk_amistades PRIMARY KEY (usuario1, usuario2),
    CONSTRAINT fk_amistades_usuarios_1 FOREIGN KEY (usuario1) REFERENCES usuarios(codigo),
    CONSTRAINT fk_amistades_usuarios_2 FOREIGN KEY (usuario2) REFERENCES usuarios(codigo)
)
GO

CREATE TABLE sedes
(
    codigo    INT          NOT NULL IDENTITY (1,1),
    nombre    VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    CONSTRAINT pk_sedes PRIMARY KEY (codigo)
)
GO

CREATE TABLE aulas
(
    codigo      INT     NOT NULL  IDENTITY (1,1),
    piso        INT     NOT NULL,
    pabellon    CHAR(1) NOT NULL,
    codigo_sede INT     NOT NULL,
    CONSTRAINT pk_aulas PRIMARY KEY (codigo),
    CONSTRAINT fk_aulas_sedes FOREIGN KEY (codigo_sede) REFERENCES sedes(codigo)
)
GO

CREATE TABLE cursos
(
    codigo INT          NOT NULL IDENTITY (1,1),
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
    codigo         INT NOT NULL IDENTITY (1,1),
    codigo_usuario INT NOT NULL,
    codigo_chat    INT NOT NULL,
    CONSTRAINT pk_usuario_chat PRIMARY KEY (codigo),
    CONSTRAINT fk_usuario_chat_usuarios FOREIGN KEY (codigo_usuario) REFERENCES usuarios(codigo),
    CONSTRAINT fk_usuario_chat_chats FOREIGN KEY (codigo_chat) REFERENCES chats(codigo)
)
GO

CREATE TABLE mensajes
(
    codigo              INT      NOT NULL IDENTITY (1,1),
    fecha_hora          DATETIME NOT NULL DEFAULT GETDATE(),
    codigo_usuario_chat INT      NOT NULL,
    contenido           TEXT     NOT NULL,
    CONSTRAINT pk_mensajes PRIMARY KEY (codigo),
    CONSTRAINT fk_mensajes_usuario_chat FOREIGN KEY (codigo_usuario_chat) REFERENCES usuario_chat(codigo)
)
GO

CREATE TABLE docentes
(
    codigo           INT          NOT NULL IDENTITY (1,1),
    nombre           VARCHAR(100) NOT NULL,
    apellido_paterno VARCHAR(100) NOT NULL,
    apellido_materno VARCHAR(100) NOT NULL
    CONSTRAINT pk_docentes PRIMARY KEY (codigo)
)
GO

CREATE TABLE tipos_notificacion
(
    codigo INT          NOT NULL IDENTITY (1,1),
    tipo   VARCHAR(100) NOT NULL,
    CONSTRAINT pk_tipos_notificacion PRIMARY KEY (codigo)
)
GO

CREATE TABLE notificaciones
(
    codigo                   INT          NOT NULL IDENTITY (1,1),
    codigo_receptor          INT          NOT NULL,
    codigo_tipo_notificacion INT          NOT NULL,
    contenido                VARCHAR(100) NOT NULL,
    fecha_hora               DATETIME     NOT NULL DEFAULT GETDATE(),
    CONSTRAINT pk_notificaciones PRIMARY KEY (codigo),
    CONSTRAINT fk_notificaciones_usuarios FOREIGN KEY (codigo_receptor) REFERENCES usuarios(codigo),
    CONSTRAINT fk_notificaciones_tipos_notificacion FOREIGN KEY (codigo_tipo_notificacion) REFERENCES tipos_notificacion(codigo)
)
GO

CREATE TABLE secciones
(
    codigo       INT        NOT NULL IDENTITY (1,1),
    nombre       VARCHAR(4) NOT NULL,
    codigo_curso INT        NOT NULL,
    CONSTRAINT pk_secciones PRIMARY KEY (codigo),
    CONSTRAINT fk_secciones_cursos FOREIGN KEY (codigo_curso) REFERENCES cursos(codigo)
)
GO

CREATE TABLE sesiones_de_clase
(
    codigo         INT         NOT NULL IDENTITY (1,1),
    hora_inicio    TIME        NOT NULL,
    hora_fin       TIME        NOT NULL,
    dia_semana     VARCHAR(10) NOT NULL,
    codigo_seccion INT         NOT NULL,
    codigo_aula    INT         NOT NULL,
    CONSTRAINT pk_sesiones_de_clase PRIMARY KEY (codigo),
    CONSTRAINT fk_sesiones_de_clase_secciones FOREIGN KEY (codigo_seccion) REFERENCES secciones(codigo),
    CONSTRAINT fk_sesiones_de_clase_aula FOREIGN KEY (codigo_aula) REFERENCES aulas(codigo)
)
GO

CREATE TABLE cargos
(
    codigo      INT          NOT NULL IDENTITY (1,1),
    nombre      VARCHAR(100) NOT NULL,
    descripcion VARCHAR(100) NOT NULL
    CONSTRAINT pk_cargos PRIMARY KEY (codigo)
)
GO

CREATE TABLE seccion_docente
(
    codigo         INT NOT NULL IDENTITY (1,1),
    codigo_seccion INT NOT NULL,
    codigo_docente INT NOT NULL,
    codigo_cargo   INT NOT NULL,
    CONSTRAINT pk_seccion_docente PRIMARY KEY (codigo),
    CONSTRAINT fk_seccion_docente_secciones FOREIGN KEY (codigo_seccion) REFERENCES secciones(codigo),
    CONSTRAINT fk_seccion_docente_docentes FOREIGN KEY (codigo_docente) REFERENCES docentes(codigo),
    CONSTRAINT fk_seccion_docente_cargos FOREIGN KEY (codigo_cargo) REFERENCES cargos(codigo),
)
GO

CREATE TABLE seccion_alumno
(
    codigo         INT NOT NULL IDENTITY (1,1),
    codigo_seccion INT NOT NULL,
    codigo_alumno  INT NOT NULL,
    CONSTRAINT pk_seccion_alumno PRIMARY KEY (codigo),
    CONSTRAINT fk_seccion_alumno_secciones FOREIGN KEY (codigo_seccion) REFERENCES secciones(codigo),
    CONSTRAINT fk_seccion_alumno_usuarios FOREIGN KEY (codigo_alumno) REFERENCES usuarios(codigo)
)
GO

CREATE TABLE valoraciones
(
    codigo                  INT          NOT NULL IDENTITY (1,1),
    codigo_usuario          INT          NOT NULL,
    codigo_docente_valorado INT          NOT NULL,
    codigo_curso            INT          NOT NULL,
    comentario              VARCHAR(200) NOT NULL,
    puntuacion              SMALLINT     NOT NULL,
    CONSTRAINT pk_valoraciones PRIMARY KEY (codigo),
    CONSTRAINT fk_valoraciones_usuarios FOREIGN KEY (codigo_usuario) REFERENCES usuarios(codigo),
    CONSTRAINT fk_valoraciones_docentes FOREIGN KEY (codigo_docente_valorado) REFERENCES docentes(codigo),
    CONSTRAINT fk_valoraciones_cursos FOREIGN KEY (codigo_curso) REFERENCES cursos(codigo),
)
GO