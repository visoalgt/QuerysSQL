--------------------Funciones de Ventana
Select o.orderid, o.orderdate, d.productid, 
sum(d.quantity) over (partition by o.orderid) as Total,
avg(d.quantity) over (partition by o.orderid) as Promedio,
count(d.quantity) over (partition by o.orderid) as conteofilas
from orders as o inner join [order details] as d
on o.orderid=d.orderid
Go
--------------------Pierdo el detalle
Select o.orderid, sum(d.quantity)
from orders as o inner join [order details] as d
on o.orderid=d.orderid
group by o.orderid
Go
--------------------numerar las filas
Select c.country, c.companyname, 
ROW_NUMBER() over (partition by c.country
 order by c.companyname)
from customers as c
Go

Select c.categoryname, p.productname, p.unitprice
, rank() over (partition by c.categoryname 
, dense_rank() over (partition by c.categoryname 
order by p.unitprice desc) as ranking2 
order by p.unitprice desc) as ranking 
from categories as c inner join products as p 
on c.CategoryID=p.CategoryID
Go
--------------------Obtener los valores de una fila posterior o una anterior
--------------------LAG y LEAD
--------------------Creando una tabla para el ejemplo
Create table preciosproducto
(nombreproducto varchar(100), fechaevaluacion date
, precio money
)
--------------------Agregando datos
Insert into preciosproducto values
('Pintura Spray Rojo','01-01-2016', 23.32),
('Pintura Spray Rojo','02-01-2016', 16.32),
('Pintura Spray Rojo','03-01-2016', 30.32),
('Pintura Spray Rojo','04-01-2016', 24.32),
('Pintura Spray Rojo','05-01-2016', 31.32),
('Pintura Spray Rojo','06-01-2016', 25.32),
('Pintura Spray Rojo','07-01-2016', 28.32),
('Pintura Spray Rojo','08-01-2016', 31.32)
Go
---------------------Consultando con inner join datos de una fila anterior
Select A.nombreproducto, A.fechaevaluacion, A.precio, P.precio AS precioanterior
 from preciosproducto as A inner join preciosproducto as p
 on A.fechaevaluacion=dateadd(mm,1,P.fechaevaluacion)
Go
----------------------Haciendo lo mismo con funciones de Ventana LAg y Lead
 Select nombreproducto, fechaevaluacion, precio,
 lag (precio) over (order by fechaevaluacion) as precioanterior,
 lead (precio) over (order by fechaevaluacion) as precioposterior
 from preciosproducto
 