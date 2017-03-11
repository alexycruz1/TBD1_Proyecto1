-------------------------------------------AGREGADO----------------------------------------
go
alter procedure stb_insertOrden
@idOrden varchar(10),
@idEmpleado varchar(10),
@idPuntoVenta varchar(10)
as
if exists(select* from dbo.Empleado E where E.ID = @idEmpleado)
begin
	if exists(select*
			from dbo.Punto_venta Pv
			where Pv.ID = @idPuntoVenta)
	begin 
		if exists(select* from dbo.Orden O where O.ID = @idOrden)
		begin 
			print 'Id de orden existente'
		end
		else
			insert  dbo.Orden values (@idOrden,GETDATE(), @idEmpleado, @idPuntoVenta)
	end
end

-------------------------------------------------------------------------------------------

go 
create procedure stb_insertDetalle
@idOrden varchar(10), 
@idProducto varchar(10),
@subtotal money, 
@total money,
@descuento money
as
if exists (select* 
			from dbo.Orden O 
			where O.ID = @idOrden)
begin
	if exists (select*
				from dbo.Producto P
				where P.ID = @idProducto)
	begin
		insert dbo.Detalle_Orden values(@idOrden, @idProducto, @subtotal, @total, @descuento)
	end
	else
		print 'No existe el producto'
end
else
	print 'No existe la orden'

------------------------------------------------------------------------------------------------------
go
create procedure stb_insertEmpleado
@idEmpleado varchar(10),
@RTN char(14),
@sueldo money,
@direccion varchar(max),
@fecha_inicio date,
@telefono char(9),
@nombre varchar(50)

as
if exists(select* from dbo.Empleado E where E.ID = @idEmpleado)
begin 
	print 'Id repetido'
end 
else
	if exists(select* from dbo.Empleado E where E.RTN = @RTN)
	begin 
		print 'RTN no puede ser el mismo para dos empleados'
	end 
	else
		if exists(select* from dbo.Empleado E where E.Telefono = @telefono)
		begin 
			print 'El teléfono no debería ser el mismo'
		end
		else
			insert dbo.Empleado values (@idEmpleado, @RTN, @sueldo, @direccion, @fecha_inicio, @telefono, @nombre)

-------------------------------------------------------------------------------------------------------------------------

use MovilDB
go
alter procedure stb_insertProducto
@idProducto varchar(10),
@nombreProducto varchar(50),
@precioVenta money,
@precioCompra money,
@unidades bigint,
@descripcion varchar(max),
@idProveedor varchar(10)
as
if exists(select* from dbo.Producto P where P.ID = @idProducto)
	begin 
		if exists(select* from dbo.Proveedor_Producto PP 
				  where PP.ID_Producto = @idProducto and PP.ID_Proveedor = @idProveedor)
		begin
			print 'producto ya existente'
		end 
		else
			insert dbo.Proveedor_Producto values (@idProveedor,@idProducto)
	end
else
	if exists(select* from dbo.Proveedores PP 
	where  PP.ID = @idProveedor)
		begin 
		insert dbo.Producto values(@idProducto, @nombreProducto, @precioVenta, @precioCompra,@unidades, @descripcion, @idProveedor)	
		insert dbo.Proveedor_Producto values (@idProveedor,@idProducto)
		end 

--------------------------------------------------------------------------------------------------------------------------------------

go
create procedure stb_insertPuntoVenta
@idPuntoVenta varchar(10),
@Direccion varchar(max),
@Ciudad varchar(50),
@Telefono char(9),
@Correo varchar(50)
as
if exists(select*
	  from dbo.Punto_venta PV
	  where PV.ID = @idPuntoVenta)
	  begin
		print 'Id de punto de venta existente'
	  end
else	
	insert  dbo.Punto_venta values (@idPuntoVenta, @Direccion, @Ciudad, @Telefono, @Correo)
----------------------------------------------------------------------------------------------------------------------------------------


go
create procedure stb_insertProveedores
@idProveedores varchar(10),
@Nombre varchar(50),
@Telefono char(9),
@Correo varchar(50)
as
if exists(select*
	  from dbo.Proveedores P
	  where P.ID = @idProveedores)
	  begin
		print 'Id de proveedor existente'
	  end
else	
	insert  dbo.Proveedores values (@idProveedores, @Nombre, @Telefono, @Correo)

--------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------MODIFICADO----------------------------------------

GO
CREATE PROCEDURE stb_ActualizarOrden
@idOrden varchar(10),
@idEmpleado varchar(10),
@idPuntoVenta varchar(10),
@Fecha Date
as
if exists(select* 
		from dbo.Empleado E
		where E.ID = @idEmpleado)
begin
	if exists(select*
			from dbo.Punto_venta Pv
			where Pv.ID = @idPuntoVenta
	)
	begin
		if exists(select* from dbo.Orden O where O.ID = @idOrden)
		begin 
			UPDATE Orden SET ID = @idOrden, Fecha = @Fecha, ID_Empleado = @idEmpleado, ID_PuntoVenta = @idPuntoVenta
						 WHERE @idOrden = ID
		end
		else
			print 'ID de orden inexistente'
	end
end
---------------------------------------------------------------------------------------------------------------------------
go 
create procedure stb_ActualizarDetalleOrden
@idOrden varchar(10), 
@idProducto varchar(10),
@subtotal money, 
@total money,
@descuento money
as
if exists (select* 
			from dbo.Orden O 
			where O.ID = @idOrden)
begin
	if exists (select* from dbo.Producto P
				where P.ID = @idProducto)
	begin
		UPDATE Detalle_Orden SET ID_Orden = @idOrden, ID_Producto = @idProducto, Subtotal = @subtotal, Total = @total, Descuento = @descuento
							 WHERE @idOrden = ID_Orden
	end
	else
		print 'No existe el producto'
end
else
	print 'No existe la orden'
----------------------------------------------------------------------------------------------------------------------------------------------------
go
create procedure stb_ActualizarEmpleado
@idEmpleado varchar(10),
@RTN char(14),
@sueldo money,
@direccion varchar(max),
@fecha_inicio date,
@telefono char(9),
@nombre varchar(50)

as
if exists(select* from dbo.Empleado E where E.ID = @idEmpleado)
begin 
	if exists(select* from dbo.Empleado E where E.RTN = @RTN)
	begin 
		if exists(select* from dbo.Empleado E where E.Telefono = @telefono)
		begin 
			UPDATE Empleado SET ID = @idEmpleado, RTN = @RTN, Sueldo = @Sueldo, Direccion = @direccion, 
						        Fecha_inicio = @fecha_inicio, Telefono = @telefono, Nombre = @nombre
						    WHERE ID = @idEmpleado
		end
	end 
end 
		

		
-----------------------------------------------------------------------------------------------------------------
go
create procedure stb_ActualizarProducto
@idProducto varchar(10),
@nombreProducto varchar(50),
@precioVenta money,
@precioCompra money,
@unidades bigint,
@descripcion varchar(max),
@idProveedor varchar(10)
as
if exists(select* from dbo.Producto P where P.ID = @idProducto)
begin 
	UPDATE Producto SET ID = @idProducto, Nombre = @nombreProducto, Precio_Venta = @precioVenta, Precio_Compra = @precioCompra, 
	Unidades = @unidades, Descripcion = @descripcion, ID_Proveedor = @idProveedor
	WHERE ID = @idProducto
end
----------------------------------------------------------------------------------------------------------
go
create procedure stb_ActualizarPuntoVenta
@idPuntoVenta varchar(10),
@Direccion varchar(max),
@Ciudad varchar(50),
@Telefono char(9),
@Correo varchar(50)
as
if exists(select*
	  from dbo.Punto_venta PV
	  where PV.ID = @idPuntoVenta)
	  begin
		UPDATE Punto_venta SET ID = @idPuntoVenta, Direccion = @Direccion, Ciudad = @Ciudad, Telefono = @Telefono,
							   Correo = @Correo
	  end
else	
	print 'Id de punto de venta inexistente'
-------------------------------------------------------------------------------------------------------------------
go
create procedure stb_ActualizarProveedores
@idProveedores varchar(10),
@Nombre varchar(50),
@Telefono char(9),
@Correo varchar(50)
as
if exists(select*
	  from dbo.Proveedores P
	  where P.ID = @idProveedores)
	  begin
		UPDATE Proveedores SET ID = @idProveedores, Nombre = @Nombre, Telefono = @Telefono, Correo = @Correo
	  end
else	
	print 'Id de proveedor inexistente'
---------------------------------------------ELIMINADO------------------------------------------------------------
---procesos de listado y eliminado faltan

SELECT* FROM dbo.Orden
SELECT* FROM dbo.Detalle_Orden
SELECT* FROM dbo.Empleado
SELECT* FROM dbo.Producto
SELECT* FROM dbo.Proveedores
SELECT* FROM dbo.Punto_venta
SELECT* FROM dbo.Proveedor_Producto

--Eliminado por ID PRODUCTO

alter procedure stb_deletebyID
@idProducto varchar(10)
as
if exists(select* from dbo.Producto P where P.ID = @idProducto)
	begin 
		if exists(select* from dbo.Proveedor_Producto PP where PP.ID_Producto = @idProducto)
		begin 
			delete dbo.Proveedor_Producto
			select* from dbo.Proveedor_Producto PP where PP.ID_Producto = @idProducto
		end
		else
			delete dbo.Producto
			where ID = @idProducto
	end

create procedure stb_deleteOrdenbyID
@idOrden varchar(10)
as
if exists(select* from dbo.Orden O where O.ID = @idOrden)
begin 
	if exists(select* from dbo.Detalle_Orden do where do.ID_Orden = @idOrden)
	begin
		delete from dbo.Detalle_Orden
		where ID_Orden = @idOrden
	end
	DELETE FROM DBO.Orden 
	where ID = @idOrden
end

DELETE FROM dbo.Orden
DELETE FROM dbo.Detalle_Orden

DELETE FROM dbo.Empleado
DELETE FROM dbo.Proveedores
DELETE FROM dbo.Punto_venta


EXEC stb_insertEmpleado 'IRT90', '12345678910111', 3000, 'por ahi', '2012-07-20', '98811354', 'Juan'
exec stb_insertOrden 1,'euceda', 'pepsi'
exec stb_insertDetalle 1,2,3,4,5
exec dbo.stb_insertProducto 'mango','MANGO', 10,5,12,'ASFGJHAGSJ', 'mario'
EXEC stb_insertProducto '1234bcd', 'zapatos caros', 2400, 3600, 50, 'de buena calidad', 'marios'
exec stb_deleteOrdenbyID 1


use MovilDB
select* from dbo.Producto 
select* from dbo.Punto_venta
select* from dbo.Proveedor_Producto
select* from dbo.Proveedores
select* from dbo.Orden
select* from dbo.Empleado
select* from dbo.Detalle_Orden

insert into dbo.Empleado values('euceda','asfdasf',123,'asfg',GETDATE(),'12343','maria')
insert into dbo.Proveedores values ('pedro', 'jota', 9485,'sag')
insert into dbo.Punto_venta values ('pepsi', 'askjghkj','tegucigalpa', 825483,'asfnbv')
insert into dbo.Detalle_Orden values(1,'pera',400,200,200)