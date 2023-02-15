---Sub-Consultas
use northwind;
Go
---Subquery devuelto como un escalar calculando 
---fila por fila

Select productname, unitprice, 
(Select avg(unitprice) from products) as Promedio, 
(Select avg(unitprice) from products)-unitprice 
as varianza
from products
Go
--------------------Subquery como tabla---------------
Select T.orderid, 
Sum(T.unitprice*T.quantity) as Total from
#Ventas
as T
group by T.orderid
Go
----Creacion de una vista
Create view ventas
as
Select c.companyname, o.orderid, o.orderdate,
p.productname, d.unitprice, d.quantity from customers as c
inner join orders as o on c.customerid=o.customerid
inner join [Order Details] as d on d.OrderID=o.orderid
inner join products as p on p.ProductID=d.ProductID
Go
----borrar la vista
drop view ventas
Go
----Crear una tabla temporal
Select c.companyname, o.orderid, o.orderdate,
p.productname, d.unitprice, d.quantity 
into #Ventas
from customers as c
inner join orders as o on c.customerid=o.customerid
inner join [Order Details] as d on d.OrderID=o.orderid
inner join products as p on p.ProductID=d.ProductID
Go
----Usando la tabla temporal
Select T.orderid, Sum(T.unitprice*T.quantity) as Total from
#Ventas
as T
group by T.orderid
Go
----borrar la tabla ventas
drop table #Ventas
Go
Select T.orderid, Sum(T.unitprice*T.quantity) as Total from
(
Select c.companyname, o.orderid, o.orderdate,
p.productname, d.unitprice, d.quantity from customers as c
inner join orders as o on c.customerid=o.customerid
inner join [Order Details] as d on d.OrderID=o.orderid
inner join products as p on p.ProductID=d.ProductID
)
as T
group by T.orderid
Go
----Sub-consultas correlacionadas
---------------Si existe el query de adentro hace el query de fuera
Select c.companyname, c.country, c.contactname 
from customers as c where exists
(Select o.customerid from orders as o where year(o.orderdate)=2016)
Go
----correlacionandolo --informacion de los clientes que si han ordenado
Select c.companyname, c.country, c.contactname 
from customers as c where exists
(Select o.customerid from orders as 
o where c.CustomerID=o.CustomerID)
Go
---subquery con resultado de multiples valores

Select c.companyname, c.country, c.contactname 
from customers as c where c.customerid in
(Select customerid from orders )
Go

Select c.companyname, c.country, c.contactname 
from customers as c where exists
(Select o.customerid from orders as o
where c.customerid=o.customerid)
Go
----devuelvame todas las ordenes donde se pidieron mas de
----20 unidades del producto 23

Select o.orderid, o.orderdate from orders as o
where 20<
(
Select d. quantity from [Order Details] as d
where o.orderid=d.orderid and d.productid=23
)
Go
