Use Northwind
go

---Inner join ISO-ANSI92
Select C.CustomerID, C.CompanyName, C.ContactName
, C.Country, O.OrderID, O.OrderDate
From Customers as C Inner join Orders as O
on C.CustomerID=O.CustomerID
go

--ISO-ANSI89
Select C.CustomerID, C.CompanyName, C.ContactName
, C.Country, O.OrderID, O.OrderDate
From Customers as C, Orders as O
Where C.CustomerID=O.CustomerID and C.Country='USA'
go
---Consulta de mas de dos tablas
Select C.CustomerID, C.CompanyName, C.ContactName
, C.Country, O.OrderID, O.OrderDate, P.ProductName, 
D.UnitPrice, D.Quantity
From Customers as C inner join Orders as O
on C.CustomerID=O.CustomerID
inner join [Order Details] as D
on O.OrderID=D.OrderID
inner join Products as P
on D.ProductID=P.ProductID
go
---Unir la tabla Suppliers con Products y luego con categorías

Select P.ProductName, S.CompanyName, C.CategoryName
from Products as P join Suppliers as S
on P.SupplierID=S.SupplierID
inner join Categories as C
on P.CategoryID=C.CategoryID
go

---Generar nuevas tablas a partir de los datos de Customers y orders
Select * 
into Clientes
from Customers
go
Select * 
into Ordenes
from Orders
go
Delete Clientes where CustomerID='ANTON'
go
---Uniendo a la tabla Clientes y Ordenes
Select C.CustomerID, C.CompanyName, C.ContactName
, C.Country, O.OrderID, O.OrderDate
From Clientes as C Full Outer join Ordenes as O
on C.CustomerID=O.CustomerID
go

---Join externos
---Left Outer join
Select C.CustomerID, C.CompanyName, C.ContactName
, C.Country, O.OrderID, O.OrderDate
From Clientes as C Left Outer join Ordenes as O
on C.CustomerID=O.CustomerID
where O.OrderID is null
go

---Right Outer join
Select C.CustomerID, C.CompanyName, C.ContactName
, C.Country, O.OrderID, O.OrderDate
From Clientes as C Right Outer join Ordenes as O
on C.CustomerID=O.CustomerID
Where C.CustomerID is null
go

---Full outer join
Select C.CustomerID, C.CompanyName, C.ContactName
, C.Country, O.OrderID, O.OrderDate
From Clientes as C Full Outer join Ordenes as O
on C.CustomerID=O.CustomerID
go

---Cross Outer join
---Consultando por separado ambas tablas
Select * from Clientes
Select * from Ordenes

---Forma uno de hacer un cross join
Select C.CustomerID, C.CompanyName, C.ContactName
, C.Country, O.OrderID, O.OrderDate
From Clientes as C Cross join Ordenes as O
go

---Forma dos de hacer un cross join
Select C.CustomerID, C.CompanyName, C.ContactName
, C.Country, O.OrderID, O.OrderDate
From Clientes as C, Ordenes as O
go

---Selft Join
Select *
from Employees
go

Select EmployeeID, FirstName, LastName, ReportsTo
from Employees
go

---Selft Join
Select * from Employees
go

Select EmployeeID, FirstName, LastName, ReportsTo
from Employees
go

Select J.FirstName +' ' + J.LastName as Jefe
, S.FirstName+ ' '+ S.LastName as Subalterno
From Employees as J inner join Employees as S
on J.EmployeeID=S.ReportsTo
go

Select distinct J.FirstName +' ' + J.LastName as Jefe
From Employees as J left outer join Employees as S
on J.EmployeeID=S.ReportsTo
Where S.FirstName is not null
go







