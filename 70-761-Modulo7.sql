Use Northwind
go
-------------------------------Insert-----------------------------------
go

Insert into Customers (CustomerID ,CompanyName ,ContactName
,ContactTitle ,[Address] ,City ,Region ,PostalCode ,Country ,Phone, Fax)
values
('ABCD5','Compañia, S.A.','Juan Perez','Ing','7av 3-3 Zona 5'
,'Guatemala','Guatemala','01005', 'Guatemala','(502)-5435-5454'
,'(502)-5435-6676')
go

Insert into Customers 
values
('ABCD7','Visoal, S.A.','Juan Perez','Ing','7av 3-3 Zona 5'
,'Guatemala','Guatemala','01005', 'Guatemala','(502)-5435-5454'
,'(502)-5435-6676')
go

Select Count(*) from customers
go
---------------------Insertar datos a partir de un select---------------
Insert into customers
 Select Concat(substring(Replace(companyName,' ',''),1,4),'9') as codigo
 , CompanyName  ,ContactName ,ContactTitle ,[Address] ,City 
 ,Region ,PostalCode  ,Country ,Phone, Fax
from suppliers
go
---------------------Insertar datos a partir de un procedimiento
---------------------Creando el procedimiento
CREATE Procedure DatosProveedor
as
 Select Concat(substring(Replace(companyName,' ',''),1,4),'5') as codigo
 , CompanyName  ,ContactName ,ContactTitle ,[Address] ,City 
 ,Region ,PostalCode  ,Country ,Phone, Fax
from suppliers
go
---------------------Ejecutando la inserción de datos
Insert into Customers
Execute DatosProveedor
go
---------------------Crear a partir de los datos de un select otra tabla
select c.customerid, c.companyname, o.orderid, o.orderdate
INTO #ORDENESNUEVAS
from customers as c inner join orders as o 
on c.CustomerID=o.customerid
go

---------------------Consultando la tabla
Select * from #ORDENESNUEVAS
go
---------------------Borrar el objeto recien creado-----------------------------------
DROP TABLE #ORDENESNUEVAS
/*
---------------------Objetos Temporales
#TablaTemporal    --Tabla Temporal Local solo se ve en mi sesion
##TablaTemporal   --Tabla Temporal se ve en todas las sesiones

*/

---------------------------------Borrar datos--------------------
Use Northwind
go
---------------------Consultando la tabla Customers
Select * from Customers
go

---------------------Eliminando datos de la tabla customers
Delete from Customers
Where CustomerID like '%5'
go

---------------------Elimiando un cliente, pero devolvera error por tener ordenes asociadas
Delete from Customers
Where CustomerID ='ANTON'
go

---------------------Creando una transaccion
Begin transaction
	Delete from [Order Details]

Commit Transaction      --commit confirma la transacción
Rollback Transaction    --rollback no confirma la transacción, la eliminación no se realiza
go

---------------------Borra todos los datos de la tabla sin escribir en el log de transacciones
Truncate Table [order details]
go
--------------------ELIMINAR DATOS DE UNA TABLA CON RESPECTO A OTRA TABLA
--------------------Recomendación primero consultar los datos que se quieren eliminar
Select C.CustomerID, C.CompanyName, C.Country, O.OrderID, O.OrderDate
FROM CUSTOMERS AS C LEFT OUTER JOIN ORDERS AS O ON C.CustomerID=O.CustomerID
WHERE O.OrderID IS NULL
go
--------------------Eliminar los datos de una tabla con respecto a otra
Delete from C
FROM CUSTOMERS AS C LEFT OUTER JOIN ORDERS AS O ON C.CustomerID=O.CustomerID
WHERE O.OrderID IS NULL
go

--------------------UPDATE-----------------------------
Use Northwind
go

--------------------Actualizar el nombre de compañia de todos los clientes de estados unidos
Update Customers Set CompanyName= CompanyName +', USA'
Where Country='USA'
go
--------------------Consultar los datos modificados
Select * from Customers
Where Country='USA'
go
--------------------volver a modificar los datos
Update Customers Set CompanyName= Replace(CompanyName,', USA', '')
Where Country='USA'
go

--------------------Actualizar los precios de los productos que provengan de estados unidos
Select * from products
select * from Suppliers
--------------------Primero unir las tablas y visualizar los datos que se van a modificar
Select p.ProductName, s.Country, p.UnitPrice
From Products as p inner join Suppliers as s
on p.SupplierID=s.SupplierID
where s.Country='USA'
go
--------------------Actualizar los precios-----------------------------
Update p set p.UnitPrice = p.UnitPrice * 1.10
From Products as p inner join Suppliers as s
on p.SupplierID=s.SupplierID
where s.Country='USA'
go

--------------------Instruccion Merge----------------------------------
--------------------Creando tablas a comparar
--------------------Tabla A
Select CustomerID, CompanyName, ContactName, ContactTitle 
into ClientesA
from customers Where country in ('Mexico','Argentina', 'Venezuela')
go  
--------------------Tabla B
Select CustomerID, CompanyName, ContactName, ContactTitle 
into ClientesB
from customers Where country in ('Mexico','Argentina', 'Venezuela')
go
Select * from ClientesA
--------------------Eliminar y Actualizar datos de cliente A para provocar diferencias con restecto a clientes B
Delete from ClientesA where customerid like '[A-C]%'
go
Update ClientesA Set CompanyName='***No definido***', ContactName='***No tiene***' 
where customerid like '[G-H]%'
go
Delete from ClientesB where CustomerID = 'TORTU'
go
--------------------Consultar las tablas ahora modificadas
Select * from ClientesA
Select * from clientesB
--------------------Merge--------------------
Merge into dbo.ClientesA as A using dbo.ClientesB as B
on A.customerid=B.customerid
when matched then
	Update set A.companyname=B.Companyname, A.Contactname =B.ContactName
when not matched then
	insert (Customerid, companyname, ContactName, contactTitle)
	values
	(B.Customerid, B.companyname, B.contactName, B.contactTitle)
when not matched by source then
	delete;
go
--------------------Consultar las tablas ahora modificadas
Select * from ClientesA
Select * from clientesB
go
--------------------Identity y Sequence--------------------
--------------------Creando una tabla con la función identity para generar un numero único e irrepetible
Create table Test1
(codigo int identity(5,5) primary key,
 nombre varchar(100)
)
go
Insert into Test1 (nombre) values ('Jose Miguel'), ('Monica Susett')
go

Select * from Test1

--------------------Se trata de una función del sistema que devuelve el último valor de identidad insertado.
Select @@identity
go


--------------------ultimo valor generado por el identity de la tabla
Select IDENT_CURRENT('Suppliers')
go
--------------------IDENTITY_INSERT
SET IDENTITY_INSERT Test1 ON
SET IDENTITY_INSERT Test1 OFF
go
Insert into Test1 (codigo, nombre) values (3, 'Maria Concepcion'), (4, 'Victor Hugo')
go

--------------------USO DE LA INSTRUCCION DBCC CHECKIDENT

--------------------A. Restablecer el valor de identidad actual si es necesario
--------------------En este ejemplo se restablece el valor de identidad actual, si es necesario, de la tabla Test1.

DBCC CHECKIDENT (Test1)
GO

--------------------B. Informar del valor de identidad actual
--------------------En este ejemplo se informa del valor de identidad actual de la tabla test1, y no se corrige el valor de identidad, si fuera incorrecto.

DBCC CHECKIDENT (test1, NORESEED)
GO

--------------------C. Establecer el valor de identidad actual en 30
--------------------En este ejemplo se establece el valor de identidad actual de la tabla jobs en 30.

DBCC CHECKIDENT (Suppliers, RESEED, 30)
GO

--------------------Sequence
Create sequence numerador
as int
start with 5
increment by 5
Minvalue 5
Maxvalue 100
No Cycle

Select next value for numerador
go
--------------------Creando una tabla para hacer un ejemplo de inserción de correlativo con sequence
Create table test2
(codigo int,
 nombre varchar(100)
)

--------------------Insertar datos usando el sequence
Insert into test2 (codigo,nombre)
values
(next value for numerador, 'Hugo'),
(next value for numerador, 'Paco'),
(next value for numerador, 'Luis')

Select * from test3

Create table Test3
(codigo int primary key default(next value for numerador),
nombre varchar(100)
)
go

Insert into test3 (nombre) values ('Monica')
