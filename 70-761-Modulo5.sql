use northwind
go
---Ordenar datos
Select customerid, companyname, contactname, country
from customers
order by country asc
go

Select customerid, companyname, contactname, country
from customers
order by 4 asc
go

Select customerid as codigo, companyname as nombre
, contactname as contacto, country as pais
from customers
order by pais desc
go


Select CompanyName as Compañia, ContactName as contacto, ContactTitle as Titulo
, Country as Pais
from Suppliers
Order by Pais DESC
go

Select C.CustomerID, C.CompanyName, C.ContactName
, C.Country, O.OrderID, O.OrderDate
From Customers as C Inner join Orders as O
on C.CustomerID=O.CustomerID
Order by C.Country DESC, C.CompanyName ASC
go

---Instrucción WHERE
---Like
Select CompanyName, ContactName, ContactTitle, Country
from Suppliers
Where CompanyName not like '[A-C]%'
go

---In
Select S.CompanyName, C.CategoryName, P.ProductName, P.UnitPrice
from Products as P inner join Suppliers as S
on P.SupplierID=S.SupplierID
inner join Categories as C
on P.CategoryID=C.CategoryID
WHERE C.CategoryName in ('Condiments', 'Dairy Products', 'Grains/Cereals')

---Between
Select S.CompanyName, C.CategoryName, P.ProductName, P.UnitPrice
from Products as P inner join Suppliers as S
on P.SupplierID=S.SupplierID
inner join Categories as C
on P.CategoryID=C.CategoryID
WHERE P.Unitprice between 20 and 25


go
---Top,  With ties, Fetch
---Instruccion top

Select Top 10 productname, unitprice
from products
order by unitprice desc
go

---Instruccion top con percen

Select Top 10 percent productname, unitprice
from products
order by unitprice desc
go


---Top con with ties
Select Top 11 with ties productname, unitprice
from products
order by unitprice desc
go

--Conteo de todos los datos de la tabla products para conocer el 100% de los registros
Select count(*) from products

--Offset-Fetch
Select productname, unitprice
from products
order by unitprice desc offset 20 rows
fetch first 10 rows only
go

---Offset-Fetch con un ciclo
Declare @i int =0
While @i < 10
begin
	Select lastname +', '+ firstname from Employees
	order by LastName asc offset @i rows
	fetch next 2 rows only
	set @i =@i + 2
end

---Manejo de valores nulos
Select Customerid, CompanyName, ContactName, Phone, Fax
from Customers
go

select companyname, phone, 
  case 
	when fax is null then 'No tiene'
	else fax
	end as Fax
from customers
go

Select companyname, isnull(fax,0) from customers
go

Select CompanyName, Phone, Fax, Coalesce(Fax, Phone, 'No tiene') as mediocomunicacion
from Customers
Where fax is null