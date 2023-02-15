----USO DE INTERSECT, EXCEPT Y APLY
use Northwind

----interseccion de las dos tablas por el codigo

Select customerid from customers --codigos de clientes
intersect
select customerid from orders    --codigos de clientes que ordenaron

----donde no se intersetan las dos tablas por el codigo, no han ordenado

Select customerid from customers --codigos de clientes
except
select customerid from orders    --codigos de clientes que ordenaron

----Operador Union  
----Juntando los datos de dos tablas
Select companyname, fax,contactname, country, 'Cliente' as estado
from customers
union all
Select companyname,'' ,contactname, country, 'Proveedor' as estado
from suppliers

----USO DE INTERSECT, EXCEPT Y APLY
use Northwind

---interseccion de las dos tablas por el codigo

Select customerid from customers --codigos de clientes
intersect
select customerid from orders    --codigos de clientes que ordenaron

---donde no se intersetan las dos tablas por el codigo, no han ordenado

Select customerid from customers --codigos de clientes
except
select customerid from orders    --codigos de clientes que ordenaron

---Operador Union  ---Juntando los datos de dos tablas
Select companyname, fax,contactname, country, 'Cliente' as estado
from customers
union all
Select companyname,'' ,contactname, country, 'Proveedor' as estado
from suppliers
Go

----colocar dentro de una funcion un CTE
----Devuelve el empleado y sus subalternos
Create function fn_jerarquia (@empid as int)
Returns Table
as Return(With Empleados_arbol (employeeid, name, reportsto, lvl)
as
(Select employeeid, firstname+' ' + lastname as name, reportsto
, 0 as lvl
from Employees where EmployeeID=@empid
union all
Select e.employeeid, e.firstname+' ' + e.lastname as name
, e.reportsto, es.lvl+1 as lvl from employees as e inner join 
Empleados_arbol as es on e.ReportsTo=es.employeeid
)
Select * from Empleados_arbol)
Go
---Evaluando la Funcion Creada
Select * from fn_jerarquia(5)

---Crear una tabla de departamentos para los empleados
Create table Departments
( depid int not null primary key
,deptname varchar(25) not null
, deptmanagerid int null
)

INSERT INTO Departments VALUES(1, 'HR',           2);
INSERT INTO Departments VALUES(2, 'Marketing',    7);
INSERT INTO Departments VALUES(3, 'Finance',      8);
INSERT INTO Departments VALUES(4, 'R&D',          9);
INSERT INTO Departments VALUES(5, 'Training',     4);
INSERT INTO Departments VALUES(6, 'Gardening', NULL);
--------CROSS APPLY
Select d.depid , d.deptname, f.employeeid, f.name 
from Departments as d cross apply
 fn_jerarquia(d.deptmanagerid) as f

--------CROSS OUTER
Select d.depid , d.deptname, f.employeeid, f.name 
from Departments as d outer apply fn_jerarquia(d.deptmanagerid) as f
