--Usando la base de datos northwind
Use Northwind
go

--Usando una funcion de agregación
Select Country, Count(*) from customer
Group by Country
go
--Primero sustituyendo los valores nulos por otro valor
--Luego contando los valores de la columna
Select Count(CompanyName), Count(Isnull(Fax,'000')) from customers
go

--Obteniendo el total de todas las ventas realizadas
Select SUM(d.Quantity * d.UnitPrice) as Total
from orders as o inner join [Order Details] as d
on o.OrderID=d.OrderID

--Obteniendo el total por cada venta
Select o.OrderID
, SUM(d.Quantity * d.UnitPrice) as Total
from orders as o inner join [Order Details] as d
on o.OrderID=d.OrderID
Group by o.OrderID

----Uso de Group by
--Clientes ordenados por país
Select Country, Companyname from customers
order by Country

--Contar los clientes por país
Select Country, Count(Companyname) as Total from customers
Group by Country
order by Country

--Ordenar la consulta del mayor a menor número de clientes
Select Country, Count(Companyname) as Total from customers
Group by Country
order by Count(CompanyName) desc


---cada orden con su detalle
Select o.orderid, p.ProductName,
d.Quantity, d.UnitPrice,
d.Quantity * d.UnitPrice as Total
from orders as o inner join [Order Details] as d
on o.OrderID=d.OrderID
inner join products as p on p.ProductId=d.ProductId

--Obteniendo el total por cada venta
Select o.OrderID
, SUM(d.Quantity * d.UnitPrice) as Total
from orders as o inner join [Order Details] as d
on o.OrderID=d.OrderID
Group by o.OrderID

--Agrupados los datos vamos afiltrar los datos agrupados con having
Select Country, Count(Companyname) as Total from customers
Group by Country
having Count(Companyname)>10
order by Country

--Filtrando las ordenes mayores a 12000
Select o.OrderID
, SUM(d.Quantity * d.UnitPrice) as Total
from orders as o inner join [Order Details] as d
on o.OrderID=d.OrderID
Group by o.OrderID
having SUM(d.Quantity * d.UnitPrice)>12000

---Usando un where
Select o.OrderID
, SUM(d.Quantity * d.UnitPrice) as Total
from orders as o inner join [Order Details] as d
on o.OrderID=d.OrderID
Where o.orderdate between '01-01-1996' and '12-31-1996'
Group by o.OrderID
having SUM(d.Quantity * d.UnitPrice)>12000


