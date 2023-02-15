Use Northwind
go

 --------------------PIVOT
Create view ventascategoria
as
Select c.categoryname, DATEPART(yyyy,o.orderdate) as año
, d.unitprice * d.quantity as total from categories as c
inner join products as p on c.CategoryID=p.CategoryID
inner join [Order Details] as d on p.ProductID=d.ProductID
inner join orders as o on o.orderid=d.orderid
Go
----------Forma 1
Select categoryname, [1996], [1997],[1998] from
(select categoryname, año, total from ventascategoria) as p
pivot( sum(total) 
for año in ([1996], [1997],[1998])) as pvt
Go
----------Forma 2
select * from ventascategoria
pivot( sum(total) 
for año in ([1996], [1997],[1998])) as pvt
Go
----------Query Dinamico
declare @pais varchar(100)
declare @sentencia varchar(300)
set @pais='France'
set @sentencia= 'Select customerid, companyname, country 
from customers where country=''' + @pais+''''
execute (@sentencia)
Go
----------Aplicando Query Dinamico en una consulta con funcion Pivot
declare @columnas varchar(max)
set @columnas = ''
select @columnas = coalesce(@columnas + '[' + cast(anio as varchar(12)) + '],', '')
FROM (select distinct datepart(yyyy,orderdate) as anio from orders) as DTM
set @columnas = left(@columnas,LEN(@columnas)-1)
DECLARE @SQLString nvarchar(500);

set @SQLString = '
select * from ventascategoria pivot( sum(total) 
for año in (' + @columnas + ')) as pvt
'
EXECUTE sp_executesql @SQLString
Go

----------Ejemplo funcion Pivot usando tabla Orders
SELECT  * FROM orders
PIVOT
(
COUNT (Orderid)
FOR EmployeeID IN
( [1], [2], [3], [4], [5] )
) AS pvt

----------Creando una tabla a partir de los datos de la consulta con funcion Pivot
SELECT Customerid, [1] AS Emp1, [2] AS Emp2, [3] AS Emp3, [4] AS Emp4, [5] AS Emp5
into TablaPivot
FROM 
(SELECT OrderID, EmployeeID, Customerid
FROM orders)p
PIVOT
(
COUNT (Orderid)
FOR EmployeeID IN
( [1], [2], [3], [4], [5] )
) AS pvt
ORDER BY pvt.Customerid;

----------Usando la función Unpivot para hacer la operación inversa
SELECT CustomerID, Employee, Orders
FROM 
   (SELECT CustomerId, Emp1, Emp2, Emp3, Emp4, Emp5
   FROM TablaPivot) p
UNPIVOT
   (Orders FOR Employee IN 
      (Emp1, Emp2, Emp3, Emp4, Emp5)
)AS unpvt;
GO
----------Funcion combinando Query Dinamico y funcion Pivot
declare @columnas varchar(max)
set @columnas = ''
select @columnas = coalesce(@columnas + '[' + companyname + '],', '')
FROM (Select companyname from suppliers) as DTM
set @columnas = left(@columnas,LEN(@columnas)-1)

Execute('Select * from
(Select c.CategoryName, s.CompanyName, p.ProductName
from products as p inner join Suppliers as s on p.SupplierID=s.SupplierID 
inner join Categories as c on c.CategoryID=p.CategoryID) as P
Pivot
(Count(Productname) for Companyname in('+@columnas+')) as PVT')





