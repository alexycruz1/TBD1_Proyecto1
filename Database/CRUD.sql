-------------------------------------------AGREGADO----------------------------------------
go
create procedure stb_insertOrden
@idOrden varchar(10),
@idEmpleado varchar(10),
@idPuntoVenta varchar(10)
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
			print 'Id de orden existente'
		end
		else
			insert  dbo.Orden values (@idOrden,GETDATE(), @idEmpleado, @idPuntoVenta)
	end
end

exec stb_insertOrden 1,'IRT90', 'AR0'
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
				where P.ID = @idProducto
	)
	begin
		insert dbo.Detalle_Orden values(@idOrden, @idProducto, @subtotal, @total, @descuento)
	end
	else
		print 'No existe el producto'
end
else
	print 'No existe la orden'

exec stb_insertDetalle 1,2,3,4,5
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

go
create procedure stb_insertProducto
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
print 'producto existente'
end
else
	if exists(select* 
	from dbo.Proveedor_Producto PP 
	where PP.ID_Producto = @idProducto and PP.ID_Proveedor = @idProveedor)
	begin 
		insert dbo.Producto values(@idProducto, @nombreProducto, @precioVenta, @precioCompra,@unidades, @descripcion, @idProveedor)	
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
	insert  dbo.Punto_venta values (@idProveedores, @Nombre, @Telefono, @Correo)
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
			print 'Id de orden existente'
		end
		else
			UPDATE Orden SET ID = @idOrden, Fecha = @Fecha, ID_Empleado = @idEmpleado, ID_PuntoVenta = @idPuntoVenta
						 WHERE @idOrden = ID
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
	if exists (select*
				from dbo.Producto P
				where P.ID = @idProducto
	)
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
			UPDATE Empleado SET ID = @idEmpleado, RTN = @RTN, Sueldo = @Sueldo, Direccion = @direccion, 
						        Fecha_inicio = @fecha_inicio, Telefono = @telefono, Nombre = @nombre
						    WHERE ID = @idEmpleado
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
print 'producto existente'
end
else
	if exists(select* 
	from dbo.Proveedor_Producto PP 
	where PP.ID_Producto = @idProducto and PP.ID_Proveedor = @idProveedor)
	begin 
		UPDATE Producto SET ID = @idProducto, Nombre = @nombreProducto, Precio_Venta = @precioVenta, Precio_Compra = @precioCompra, 
						    Unidades = @unidades, Descripcion = @descripcion, ID_Proveedor = @idProveedor
						WHERE ID = @idProducto
	end
---falta punto de venta y proveedores (actualizar) ademas de procesos de listado y eliminado