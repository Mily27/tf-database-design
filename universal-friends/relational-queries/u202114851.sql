-- Encontrar a usuarios con un interes especifico
select u.nombre, i.nombre as Interes
from usuarios u
inner join interes_usuario iu on u.codigo = iu.codigo_usuario
inner join intereses i on iu.codigo_interes = i.codigo
where i.nombre = 'Futbol'
go

-- Funcion para obtener nombre completo de los usuarios
create function NombreCompleto(@codigo_usuario int) returns varchar(255)
as
begin
	declare @nombre_completo varchar(255)
	select @nombre_completo = nombre + ' ' + apellido_paterno + ' ' + apellido_materno
	from usuarios
	where codigo = @codigo_usuario
	return @nombre_completo
end
go

select codigo, dbo.NombreCompleto(codigo) as 'Nombre completo'
from usuarios

-- Funcion para hallar la cantidad de mensajes enviados por usuarios
create function MensajesTotales(@codigo_usuario int) returns int
as
begin
	declare @cantidad_mensajes int
	select @cantidad_mensajes = COUNT(*)
	from usuario_chat uc
	inner join mensajes m on uc.codigo = m.codigo_usuario_chat
	where uc.codigo_usuario = @codigo_usuario
	return @cantidad_mensajes
end


select codigo, dbo.MensajesTotales(codigo) as 'Mensajes Totales'
from usuarios