---Conectarse a la base de datos
Use northwind
go
---Tipos de dato en el SQL Server
---Declarando una variable
Declare @variable as decimal(7,2)
Set @variable=7.89 * 25
Select @variable
go

---Creando una tabla
Create table Empleados
(Codigo int,
nombre varchar(150),
apellidos varchar(150),
dirección varchar(300),
fechaingreso date
)
go
---Declarando una variable tipo tabla
Declare @empleados as table
( codigo bigint,
nombre varchar(100),
apellido varchar(150)
)
Insert into @empleados (codigo, nombre, apellido)
values (2, 'Victor','Cardenas'), (3, 'Claudia','Hernandez')
Select * from @empleados
go

---Collation
CREATE TABLE Localizaciones
(Lugar varchar(15) NOT NULL);
GO
INSERT Localizaciones (Lugar) VALUES ('Chiapas'),('Colima')
                             , ('Cinco Rios'), ('California');
GO
--Apply an typical collation
SELECT Lugar FROM Localizaciones
ORDER BY Lugar
COLLATE Latin1_General_CS_AS_KS_WS ASC;
GO
-- Apply a Spanish collation
SELECT Lugar FROM Localizaciones
ORDER BY Lugar
COLLATE Traditional_Spanish_ci_ai ASC;
GO

---Concatenación
Select firstname +' '+ lastname as nombre from Employees
go

Select Concat(firstname ,' ', lastname) as nombre from Employees
go

--Funciones de texto
Select CompanyName, UPPER(companyname) as mayusculas
, LOWER(companyname) as minusculas, substring(companyname,5,5) as porciontexto
, len(companyname) numeroletras from Suppliers
go

Select CHARINDEX('xxx', 'Que todos se levanten que nadie se quede atras')







---Uso de like
/* Caracteres comodin
_ sustituye una letra
% sustituye muchas letras
[A-B] Rango
[^A-B] Rango negado
Escape
*/

Select companyname, contactname 
from suppliers
Where companyname like '_a%'
go

Select companyname, contactname 
from suppliers
Where companyname like '[^A-F]%'
go

Update Suppliers set companyname='%Aux joyeux ecclésiastiques'
Where SupplierID=1
go

Select companyname, contactname 
from suppliers
Where companyname like '!%%' Escape '!'
go

---Fechas

Select orderid, orderdate
from orders
where OrderDate between '01-01-1996' and '12-31-1996'

--Analice como cambia la presentacioón de la fecha
Select getdate() as FechaDeHoy, cast(getdate() as datetime) as [DateTime],
cast(getdate() as smalldatetime) as [SmallDateTime],
cast(getdate() as date) as [Date],
cast(getdate() as time) as [Time],
cast(getdate() as datetime2) as [DateTime2], cast(getdate() as datetimeoffset) as [DateTimeOffset]


Select companyname, contactname 
from suppliers
Where companyname like '%'
go

--Conversion

---Uso de la funcion CAST
Select 'El producto:'+ productname + 
', tiene el precio de: '+ cast(unitprice as varchar(10)) as precio
from products
--
Select CAST(sysdatetime() as date);
---------CONVERT
Select 'El producto:'+ productname + 
', tiene el precio de: '+ 
convert(varchar(10),unitprice) as precio
from products
go
Select  Try_convert(int,productname) as precio
from products
