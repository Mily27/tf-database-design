create database universal_friends
go

use universal_friends
go

create table chats
(
chatID int primary key
);
go

create table cargos
(
cargoID int primary key,
nombre varchar(20) not null,
descripcion varchar(250) not null
);
go

create table docentes
(
docenteID int primary key,
nombre varchar(20) not null,
apellido_paterno varchar(20) not null,
apellido_materno varchar(20) not null
);
go

create table cursos
(
cursoID int primary key,
nombre varchar(20) not null
);
go

create table sedes
(
sedeID int primary key,
nombre varchar(20) not null,
direccion varchar(30) not null
);
go

create table intereses
(
interesID int primary key,
nombre varchar(20) not null
);
go

create table tipos_notificacion
(
tipnotID int primary key,
tipo varchar(20) not null
);
go

create table carreras
(
carreraID int primary key,
nombre varchar(20) not null
);
go

create table aulas
(
aulaID int primary key,
piso int not null,
pabellon char(1) not null,
sedeID int,
foreign key (sedeID) references sedes(sedeID)
);
go

create table secciones
(
seccionID int primary key,
nombre varchar(4) not null,
cursoID int,
foreign key (cursoID) references cursos(cursoID)
);
go

create table secciones_clases
(
secclaseID int primary key,
hora_inicio time not null,
hora_fin time not null,
dia_semana varchar(10) not null,
seccionID int not null,
aulaID int not null,
foreign key (seccionID) references secciones(seccionID),
foreign key (aulaID) references aulas(aulaID)
);
go

create table secciones_docente
(
secdocenteID int primary key,
seccionID int not null,
docenteID int not null,
cargoID int not null,
foreign key (seccionID) references secciones(seccionID),
foreign key (docenteID) references docentes(docenteID),
foreign key (cargoID) references cargos(cargoID)
);
go

create table usuarios
(
usuarioID int primary key,
nombre varchar(20) not null,
apellido_paterno varchar(20) not null,
apellido_materno varchar(20) not null,
correo_electronico varchar(20) not null,
contrasenia varchar(20) not null,
fecha_registro date not null,
fecha_nacimiento date not null,
carreraID int not null,
foreign key (carreraID) references carreras(carreraID),
);
go

create table amistades
(
usuario1 int not null,
usuario2 int not null,
fecha_inicio datetime not null,
primary key (usuario1, usuario2),
foreign key (usuario1) references usuarios(usuarioID),
foreign key (usuario2) references usuarios(usuarioID)
);
go

create table intereses_usuario
(
intusuarioID int primary key,
usuarioID int not null,
interesID int not null,
foreign key (usuarioID) references usuarios(usuarioID),
foreign key (interesID) references intereses(interesID)
);
go

create table secciones_alumno
(
secalumnoID int primary key,
seccionID int not null,
usuarioID int not null,
foreign key (seccionID) references secciones(seccionID),
foreign key (usuarioID) references usuarios(usuarioID)
);
go

create table usuarios_chat
(
usuchatID int primary key,
usuarioID int not null,
chatID int not null,
foreign key (usuarioID) references usuarios(usuarioID),
foreign key (chatID) references chats(chatID)
);
go

create table mensajes
(
mensajeID int primary key,
fecha_hora datetime not null,
contenido text not null,
usuarioID int not null,
foreign key (usuarioID) references usuarios(usuarioID)
);
go

create table perfiles_usaurio
(
perusuarioID int primary key,
usuarioID int not null,
nombre_perfil varchar(15) not null,
descripccion varchar(200) not null,
foto_perfil image not null,
foreign key (usuarioID) references usuarios(usuarioID)
);
go

create table valoraciones
(
valoracionID int primary key,
usuarioID int not null,
docenteID int not null,
cursoID int not null,
comentario varchar(200) not null,
puntuacion smallint not null,
foreign key (usuarioID) references usuarios(usuarioID),
foreign key (docenteID) references docentes(docenteID),
foreign key (cursoID) references cursos(cursoID)
);
go

create table notificaciones
(
notifiID int primary key,
usuarioID int not null,
tipnotID int not null,
contenido varchar(100) not null,
fecha_hora datetime not null,
foreign key (usuarioID) references usuarios(usuarioID),
foreign key (tipnotID) references tipos_notificacion(tipnotID),
);
go