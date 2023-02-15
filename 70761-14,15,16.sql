---Ejectuar Procedimientos Almacenados------------------------
/* Se ejecutan con la instruccion EXECUTE o su abreviatura EXEC */
/* Los procedimientos del sistema se pueden llamar sin EXEC */
--informacion de la base de datos
sp_helpdb northwind
--informacion de una tabla
sp_help customers
--ver e script origen de una vista, procedimiento, una funcion
sp_helptext ventas
go
--------Crear un procedimiento
Create procedure Proc_NumOrdenesCliente
as
Select c.companyname, count(o.orderid) from customers as c
inner join orders as o on o.CustomerID=c.CustomerID
group by c.CompanyName
---Ejecutar el procedimiento
execute Proc_NumOrdenesCliente 
-------Modificar el procedimiento
ALTER procedure Proc_NumOrdenesCliente @parametro1 varchar(100)
as
Select c.companyname, count(o.orderid) from customers as c
inner join orders as o on o.CustomerID=c.CustomerID
where c.country=@parametro1
group by c.CompanyName
---Ejecutar el procedimiento
execute Proc_NumOrdenesCliente 'France'
go
----Ejercicio2
Create procedure insertar_cliente
@customerid varchar(5), @CompanyName varchar(100)
, @ContactName varchar(100), @Country varchar(100)
as
Insert into customers (customerid, CompanyName, ContactName, Country)
values (@customerid, @CompanyName, @ContactName, @Country)

---ejecutar procedimiento
execute insertar_cliente 'ZZZZZ','Zambia,S.A.','Luis Zevadua','Mexico'
go
---Ejercicio 3
Create procedure proc_modificarpais @PaisOriginal varchar(100)
, @PaisCambio varchar(100), @numerocambios int output
as
Update Customers set country=@PaisCambio where country=@PaisOriginal
Set @numerocambios=@@ROWCOUNT

----Ejecutar el procedimiento con un parametro de salida
Declare @filas_afectadas int
Exec proc_modificarpais 'Mexico', 'Mejico', @filas_afectadas output
Select @filas_afectadas

----SINONIMOS----------------16 Modulo
CREATE SYNONYM cambiopais FOR 	proc_modificarpais

----Ejecutar el procedimiento con un parametro de salida
Declare @filas_afectadas int
Exec cambiopais 'MeJico', 'Mexico', @filas_afectadas output
Select @filas_afectadas
---USO DEL WHILE----------CICLO--------------
Create procedure Proc_empleados
as
DECLARE @empid AS INT = 1, @lname AS NVARCHAR(20);
WHILE @empid <=5
   BEGIN
	SELECT @lname = lastname FROM Employees
		WHERE EmployeeID = @empid;
	PRINT @lname;
	SET @empid += 1;
	END;
	----+++++CURSOR---------MANUAL-------------------
	--Declarar el cursor
	Declare Cursor1 cursor Scroll
	for Select c.customerid, c.companyname, o.orderid from customers as c
	inner join orders as o on o.customerid=c.customerid 
--abrir cursor
Open Cursor1
--Navegar por el cursor, ir al primero
Fetch first from Cursor1
--Ir de dato en dato
Fetch next from Cursor1
---cerrar el cursor
close Cursor1
--liberar el cursor de memoria
deallocate Cursor1
----Ejemplo 2 Cursores
Declare @codigo varchar(5), @compania varchar(200),
@contacto varchar(150), @pais varchar(100)
Declare ccustomers cursor GLOBAL
     for Select customerid, companyname, contactname
     , country from customers
Open ccustomers
fetch ccustomers into @codigo, @compania, @contacto,@pais
while(@@fetch_status=0)
	begin
	print @codigo +' '+ @compania +' '+ @contacto +' '+@pais
	fetch ccustomers into @codigo, @compania, @contacto,
	@pais
end
close ccustomers
deallocate ccustomers
 
GO
------------------
Create table ahorro
(numerocuenta bigint not null primary key,
nombre varchar(100),
saldo money
)
go
Create table monetario
(cuentaahorro bigint not null primary key,
nombre varchar(100),
saldo money
)
go

insert into ahorro values (3132, 'Juan Dominguez',3000),
(3133, 'Ana Maria Perez',5670),(3134, 'Monica Valenzuela',34555)
go
insert into monetario values (1010, 'Jorge Arturo Briz',34555),
(2020, 'Ana Maria Perez',5670),(3030, 'Carlos Solorzano',4000)

------------------Try Catch
BEGIN TRY 
    SELECT 1/0;
END TRY
BEGIN CATCH
    SELECT
        ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO
