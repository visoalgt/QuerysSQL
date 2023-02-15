Use Northwind;
Go
-----Funciones Escalares
-----Extraer el año y el mes de una fecha


-----Dias trasncurridos desde la fecha de pedido hasta hoy
Select orderid, orderdate
, datediff(dd,[orderdate],getdate()) as DiasTranscurridos
from orders
Go
-----Edad
declare @fechanacimiento date= '01-25-76'
Select datediff(yy,@fechanacimiento,getdate()) as Edad
Go
-----Usando funcion escalar substring 
-----calculo fila por fila
Select companyname, substring(companyname,1,3) as PrimerasTresLetras
from customers
Go

-----Funciones de Agregado---------------
-----Conteo de todos los clientes
Select count(*) from customers
Go
-----Conteo de los clientes por pais
Select country, count(*) from customers
group by country
Go
-----Conteo de los productos por categoría
Select C.CategoryName, p.ProductName
from Products as p inner join Categories as c
on p.CategoryID=c.CategoryID

-----Categoria y numero de productos por categoria--Pierdo el detalle
Select C.CategoryName, Count(p.ProductName)
from Products as p inner join Categories as c
on p.CategoryID=c.CategoryID
Group by C.CategoryName

--------------------Funciones de Ventana--------------------------------------------------
Select C.CategoryName, p.ProductName,
count(p.ProductName) over (partition by C.CategoryName) as Numero
from Products as p inner join Categories as c
on p.CategoryID=c.CategoryID



----numerar las filas
Select c.country, c.companyname, 
ROW_NUMBER() over (partition by c.country
 order by c.companyname)
from customers as c
-----Conversion implicita

DECLARE @string varchar(10);
SET @string = 1;
SELECT @string + ' es un texto'

DECLARE @notastring int;
SET @notastring = '1';
SELECT @notastring + '1'

-----Uso de la funcion CAST
Select 'El producto:'+ productname + 
', tiene el precio de: '+ cast(unitprice as varchar(10)) as
precio
from products
Go

-----Otro Ejemplo de Cast
Select CAST(sysdatetime() as date);
Go
-----CONVERT
Select 'El producto:'+ productname + ', tiene el precio de: '+ 
convert(varchar(10),unitprice) as precio
from products
Go
Select  Try_convert(int,productname) as precio
from products
Go
-----Otro Ejemplo de Convert
Select CURRENT_TIMESTAMP
Select convert(char(8), CURRENT_TIMESTAMP, 101) 
as ISO_USA;
Select convert(char(8), CURRENT_TIMESTAMP, 102) as 
ISO_ANSI;
Select convert(char(8), CURRENT_TIMESTAMP, 103) as 
ISO_UK_FR;
Select convert(char(8), CURRENT_TIMESTAMP, 104) as 
ISO_GER;
Go

-----PARSE a partir de SQL 2012
SELECT PARSE('Monday, 13 december 2010' 
AS DATETIME2 USING 'EN-us')  AS FECHA
Go

 SELECT TRY_PARSE('Monday, 13 december 2010' 
 AS DATETIME2 USING 'EN-us')  AS FECHA
Go

-----CHOOSE---------
 select productname, unitprice, 
 choose(categoryid,
'Beverages' ,'Condiments','Confections'
,'Dairy Products'
,'Grains/Cereals','Meat/Poultry','Produce'
,'Seafood') as category
 from products
Go

-----ISNULL
 SELECT COMPANYNAME, FAX FROM CUSTOMERS
 Go
 SELECT COMPANYNAME, isnull(FAX,'0000-0000') 
 FROM CUSTOMERS
 Go
 SELECT COMPANYNAME, coalesce(FAX, PHONE,'0000-0000') 
 FROM CUSTOMERS
 Go

 select productname, unitprice, 
 iif( Discontinued=0 , 'EnExistencia','Descontinuado') 
 as Discontinued 
 from products

-----Fucnion Count
 Select count(*) from orders  --el numero de filas
 Go
 select count(customerid) from orders  ---el numero de filas
 Go
 select count(distinct customerid) from orders --el numero de clientes
 Go
 --no repetidos que ordenaron
 select distinct count_big(customerid) from orders
 Go
 select count(coalesce(fax,'00-00')) from customers
 Go

 Select coalesce(fax,'00-00') from customer
 Go

 Select isnull(fax,'00-00') from customers
 Go
Select distinct country from customers
Go
