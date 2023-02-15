--Usar la base de datos Northwind
Use Northwind
Go

--Hacer una consulta de todos los datos y todas las columnas de la tabla suppliers
Select * from suppliers
Go

--Limitar las columnas a mostrar
Select S.[Companyname] as Compañia, S.[ContactName] as Contacto , S.ContactTitle as Titulo
, S.[Address] as Direccion, S.Phone as Telefono, S.Country as Pais
from Suppliers as S
Order by Compañia 
Go

--Valores Unicos
Select Customerid, CompanyName, Country From Customers
Order by Country
go

Select Country From Customers
Order by Country
go

Select Distinct Country from Customers
Order by Country
go


--Realizar calculos, consultando la tabla productos
Select ProductName, UnitPrice, Unitprice * .12 as ImpuestoIVA
from products
Go

Select CustomerId, OrderId, OrderDate, Year(OrderDate) as Anio
, Month(OrderDate) as Mes  from orders
go

Select OrderID, ProductID, Unitprice, Quantity, Discount  
, (UnitPrice*Quantity)-(UnitPrice*Quantity*Discount) as Parcial
from [Order Details]

go

--Uso de la instruccion Case
Select ProductName, CategoryId from Products
go
--Usando Case
SELECT   ProductName,  
      CASE CategoryId  
         WHEN 1 THEN 'Bebidas'
         WHEN 2 THEN 'Lacteos'  
         WHEN 3 THEN 'Condimentos'  
         WHEN 4 THEN 'Otros'  
         ELSE 'No en venta'  
      END  as 
FROM Products
ORDER BY ProductName
GO  