--Usar la base de datos
Use Northwind
go
--Hacer una consulta mostrando todos las columnas y los datos de la tabla
Select * from customers

--Consultar las columnas de una tabla
Sp_help Customers

--Consultar solo ciertas columnas de la tabla Customers
Select CustomerID, CompanyName, ContactName, ContactTitle
, Address, Country from Customers
go

--Limitar los datos a mostrar con la clausula Where
Select CustomerID, CompanyName, ContactName, ContactTitle
, Address, Country from Customers
Where Country='USA'
go

--Usar Agrupamiento
Select Country, Count(*) as Contar
from Customers 
group by Country

--Filtrar los datos ya agrupados, mostrando los paises donde hay mas de 10 clientes
Select Country, Count(*) as Contar
from Customers 
group by Country
having count(*)>10

--Filtrar los datos ya agrupados, mostrando los paises donde hay mas de 10 clientes
--Y ordenando por pais
Select Country, Count(*) as Contar
from Customers 
group by Country
having count(*)>10
order by Country
go

--Uso del in, like y between 
Select CustomerID, CompanyName, ContactName, ContactTitle
, Address, Country
from Customers where Country in ('Mexico','Argentina','Brazil')


Select CustomerID, CompanyName, ContactName, ContactTitle
, Address, Country
from Customers
Where CompanyName like '%s'
order by Country

Select Productname, Unitprice from products
where Unitprice between 15 and 20
order by ProductName