-------------------------------------------AGREGADO----------------------------------------
go
create procedure stb_insertOrden
@idEmpleado int,
@idPuntoVenta int
as
if exists(select* from dbo.Empleado E where E.ID = @idEmpleado)
begin
	if exists(select*
			from dbo.Punto_venta Pv
			where Pv.ID = @idPuntoVenta)
	begin 
		insert  dbo.Orden values (GETDATE(), @idEmpleado, @idPuntoVenta)
	end
end

-------------------------------------------------------------------------------------------

go 
create procedure stb_insertDetalle
@idOrden int, 
@idProducto int,
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
alter procedure stb_insertEmpleado
@RTN varchar(14),
@sueldo money,
@direccion varchar(max),
@fecha_inicio Date,
@telefono varchar(9),
@nombre varchar(50)

as
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
		insert dbo.Empleado values (@RTN, @sueldo, @direccion, @fecha_inicio, @telefono, @nombre)

-------------------------------------------------------------------------------------------------------------------------
alter trigger trg_InsertarProducto
on dbo.Producto
instead of insert 
as 
declare @idProducto int,
@nombreProducto varchar(50),
@precioVenta money,
@precioCompra money,
@unidades bigint,
@descripcion varchar(max),
@idProveedor int

select  @idProducto = i.ID, @nombreProducto = i.Nombre, @precioVenta = i.Precio_Venta, @precioCompra = i.Precio_Compra,
		@unidades = i.Unidades, @descripcion = i.Descripcion, @idProveedor = i.ID_Proveedor
from inserted i

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
			set identity_insert dbo.Producto on
				insert into dbo.Producto (ID,Nombre,Precio_Venta,Precio_Compra,Unidades,Descripcion,ID_Proveedor,Activo)
				values(@idProducto, @nombreProducto, @precioVenta, @precioCompra,@unidades, @descripcion, @idProveedor,1)	
			set identity_insert dbo.Producto off;
			insert into dbo.Proveedor_Producto values (@idProveedor,@idProducto)
		end 
		else
			print 'nada'

insert into dbo.Producto values('sd','asfasr',123,123,123,'gwedgvwresfgv','mario',1)

select* from dbo.Proveedor_Producto
select* from dbo.Proveedores
select* from dbo.Producto
---------------------




--------------------------------------------------------------------------------------------------------------------------------------

go
create procedure stb_insertPuntoVenta
@Direccion varchar(max),
@Ciudad varchar(50),
@Telefono char(9),
@Correo varchar(50)
as
insert  dbo.Punto_venta values (@Direccion, @Ciudad, @Telefono, @Correo,1)
----------------------------------------------------------------------------------------------------------------------------------------


go
create procedure stb_insertProveedores
@Nombre varchar(50),
@Telefono char(9),
@Correo varchar(50)
as
insert  dbo.Proveedores values (@Nombre, @Telefono, @Correo,1)

--------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------MODIFICADO----------------------------------------

GO
CREATE PROCEDURE stb_ActualizarOrden
@idOrden int,
@idEmpleado int,
@idPuntoVenta int,
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
			UPDATE Orden SET Fecha = @Fecha, ID_Empleado = @idEmpleado, ID_PuntoVenta = @idPuntoVenta
						 WHERE @idOrden = ID
		end
		else
			print 'ID de orden inexistente'
	end
end
---------------------------------------------------------------------------------------------------------------------------
go 
create procedure stb_ActualizarDetalleOrden
@idOrden int, 
@idProducto int,
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
alter procedure stb_ActualizarEmpleado
@idEmpleado int,
@RTN varchar(14),
@sueldo money,
@direccion varchar(max),
@fecha_inicio date,
@telefono varchar(9),
@nombre varchar(50)
as
if exists(select* from dbo.Empleado E where E.ID = @idEmpleado)
begin 
	if exists(select* from dbo.Empleado E where E.RTN = @RTN and @idEmpleado != ID)
	begin 
		if exists(select* from dbo.Empleado E where E.Telefono = @telefono and @idEmpleado != ID)
		begin
			UPDATE Empleado SET RTN = @RTN, Sueldo = @Sueldo, Direccion = @direccion, 
						        Fecha_inicio = @fecha_inicio, Telefono = @telefono, Nombre = @nombre
						    WHERE ID = @idEmpleado
		end
		else 
			print '1'
	end 
	else 
		print '2'
		
end 
else
	print '3'	

select*
from dbo.Empleado

update Empleado set RTN = 35
where ID = 1

exec stb_ActualizarEmpleado 1,1,3,'1324','2017-3-12',13435,'asfas'

		
-----------------------------------------------------------------------------------------------------------------
go
create procedure stb_ActualizarProducto
@idProducto int,
@nombreProducto varchar(50),
@precioVenta money,
@precioCompra money,
@unidades bigint,
@descripcion varchar(max),
@idProveedor int
as
if exists(select* from dbo.Producto P where P.ID = @idProducto)
begin 
	UPDATE Producto SET Nombre = @nombreProducto, Precio_Venta = @precioVenta, Precio_Compra = @precioCompra, 
	Unidades = @unidades, Descripcion = @descripcion, ID_Proveedor = @idProveedor
	WHERE ID = @idProducto
end
----------------------------------------------------------------------------------------------------------
go
alter procedure stb_ActualizarPuntoVenta
@idPuntoVenta int,
@Direccion varchar(max),
@Ciudad varchar(50),
@Telefono char(9),
@Correo varchar(50)
as
if exists(select*
	  from dbo.Punto_venta PV
	  where PV.ID = @idPuntoVenta)
	  begin
		UPDATE Punto_venta SET Direccion = @Direccion, Ciudad = @Ciudad, Telefono = @Telefono, Correo = @Correo
		where @idPuntoVenta = ID

	  end
else	
	print 'Id de punto de venta inexistente'
-------------------------------------------------------------------------------------------------------------------
go
alter procedure stb_ActualizarProveedores
@idProveedores int,
@Nombre varchar(50),
@Telefono char(9),
@Correo varchar(50)
as
if exists(select*
	  from dbo.Proveedores P
	  where P.ID = @idProveedores)
	  begin
		UPDATE Proveedores SET Nombre = @Nombre, Telefono = @Telefono, Correo = @Correo
		WHERE ID = @idProveedores
	  end
else	
	print 'Id de proveedor inexistente'
---------------------------------------------ELIMINADO------------------------------------------------------------
--Eliminado por ID PRODUCTO
create procedure stb_deletebyID
@idProducto int
as
if exists(select* from dbo.Producto P where P.ID = @idProducto)
begin 
	update dbo.Producto set Activo = 0
	where ID = @idProducto
end

create procedure stb_deleteOrdenbyID
@idOrden int
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

alter procedure stb_deleteEmpleadobyID
@ID int
as
if exists (select* from dbo.Empleado E where E.ID = @ID)
begin 
	update dbo.Empleado set Activo = 0
	where @ID = ID
end

create procedure stb_deleteProveedorbyID
@idProveedor int
as
if exists(select* from dbo.Proveedores P where P.ID = @idProveedor)
begin
	update dbo.Proveedores set Activo = 0
	where @idProveedor = ID
end

create procedure stb_deletePuntoVentabyID
@idPuntoVenta int
as 
if exists(select* from dbo.Punto_venta PV where PV.ID = @idPuntoVenta)
begin
	update dbo.Punto_venta set Activo = 0
	where @idPuntoVenta = ID
end

------------------LISTAR
--PRODUCTOS POR NOMBRE
create procedure stb_listarProductoMarca
@nombre varchar(50)
as
select* from dbo.Producto P where P.Nombre like '%'+@nombre+'%' and P.Activo = 1

create procedure stb_listarProductos
as 
select* from dbo.Producto P where P.Activo = 1

--Listar Orden
create procedure stb_listarOrden
@idOrden int
as
if exists(select* from dbo.Orden O where O.ID = @idOrden )
begin
	select*
	from dbo.Orden O inner join dbo.Detalle_Orden Od on O.ID = Od.ID_Orden 
end

create procedure stb_listarOrdenes
as
select* from dbo.Orden

---Listar Empleados
alter procedure stb_listartodosEmpleados

as
select* from dbo.Empleado E where E.Activo = 1

exec stb_listartodosEmpleados 

create procedure stb_listarEmpleado
@idEmpleado int
as
if exists(select* from dbo.Empleado E where E.ID = @idEmpleado)
begin
	print ''
end

create procedure stb_ListarProveedores
as
select* from dbo.Proveedores P where P.Activo = 1

create procedure stb_ListarPuntosVenta
as
select* from dbo.Punto_venta PV where PV.Activo = 1