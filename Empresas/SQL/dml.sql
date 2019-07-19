--EJERCICIO a)
select nombre,ciudad
from
empresa.empleado
natural join
(Select curp from
empresa.trabajar
natural join
empresa.empresa
WHERE
razon_social LIKE 'PEMEX%') as dfr;

--EJERCICIO b)
select nombre,materno,paterno,curp
from
empresa.empleado
natural join
(Select ciudad from
empresa.trabajar
natural join
empresa.empresa)as dfr;


--Ejercicio c)
select curp,salario
FROM
(select CURP
from
empresa.dirigir 
natural join
empresa.empleado) as dt
natural join
empresa.trabajar;

--Ejercicio d)
select curp,rfc
from
(select curp,rfc,(extract('month' from fecha_inicio::DATE- 9)::int- 1)/ 3 + 1 as d
from
empresa.dirigir
Where
date_part('year', fecha_inicio) = 2014) as drf
Where
d= 1 or d = 3;

--Ejercicio e)
select dr.curp,dr.ciudad,dr.nombre
from
(Select curp,ciudad,nombre
from
empresa.supervisar s
join
empresa.empleado e
on 
s.curp_supervisado = e.curp) as dr
join
(Select curp,ciudad,nombre
from
empresa.supervisar s
join
empresa.empleado e
on 
s.curp_supervisor = e.curp) as df
on
df.ciudad = dr.ciudad;

--Ejercicio f)

select razon_social,AVG(salario)
from
empresa.empresa
natural join
(Select rfc,salario from
empresa.trabajar
natural join
empresa.empleado) as dfr
group by razon_social;

--Ejercicio g)
--No se resolvio

--Ejercicio h)
select razon_social,COUNT(salario)
from
empresa.empresa
natural join
(Select rfc,salario from
empresa.trabajar
natural join
empresa.empleado) as dfr
group by razon_social;


--Ejercicio i)
select nombre,df.curp,numHoras
from
empresa.proyecto r
join
(select e.curp,count(e.curp)
from
empresa.empleado e
join
empresa.proyecto p
on
e.curp = p.curp
group by e.curp
having count(e.curp) > 1) as df
on
df.curp = r.curp
where 
numHoras > 20;

--Ejercicio j)
select razon_social,COUNT(curp)
from
empresa.empresa
natural join
(Select rfc,curp from
empresa.trabajar
natural join
empresa.empleado) as dfr
group by razon_social;

--Ejercicio k)
--No se resolvio


--Ejercicio l)
--No se resolvio


--Ejercicio m)
Select *
from
empresa.empleado
natural join
(Select curp,rfc
from
empresa.trabajar
natural join
(
select rfc
from
empresa.empresa
natural join
(select rfc,COUNT(curp) cant
from
empresa.empresa
natural join
(Select rfc,curp from
empresa.trabajar
natural join
empresa.empleado) as dfr
group by rfc) as drcg
Where cant = 
(
Select
Min(cant)
from (select rfc,COUNT(curp) cant
from
empresa.empresa
natural join
(Select rfc,curp from
empresa.trabajar
natural join
empresa.empleado) as dfr
group by rfc) as rtv)) as dr) as df;

--Ejercicio n)
Select *
from
empresa.proyecto
natural join
(
Select curp
from
empresa.empleado
natural join
(Select curp
from 
empresa.dirigir) as df) as dr;


--Ejercicio o)
--No se resolvio

--Ejercicio p)
--No se resolvio

--Ejercicio q)
select curp,nombre,materno,paterno
from
empresa.empleado
where
curp NOT IN (
Select p.CURP
from
empresa.empleado e 
join
empresa.proyecto p
on
e.curp = p.curp);

--Ejercicio r)
select rfc,ciudad,razon_social,count(curp) numeroEmpleados
from
empresa.empresa e
natural join
(select ciudad,curp
from
empresa.empleado
natural join
empresa.trabajar) as dr
group by
rfc;

--Ejercicio s)
Select numProy,numHoras,cnt
from
empresa.Proyecto
natural join
(select numProy,count(curp) cnt
from 
empresa.proyecto
group by
numProy) as df
Where
cnt = (Select
Max(cnt)
from (select numProy,count(curp) cnt
from 
empresa.proyecto
group by
numProy)as dr);

--Ejercicio t)
select e.nombre,e.materno,e.paterno,e.curp
from
empresa.proyecto p
join
empresa.empleado e
on
e.curp = p.curp
where
Extract('day' from fecha_inicio )   = extract('day' from f_nac)
and
Extract('month' from fecha_inicio )   = extract('month' from f_nac);

--Ejercicio u)
Select curp,nombre,numeroEmpleados
from
empresa.empleado
join
(Select curp_supervisor,count(curp_supervisado) numeroEmpleados
from
empresa.supervisar
group by
curp_supervisor) as df
on
curp = curp_supervisor;

--Ejercicio v)
select curp,nombre
from
empresa.dirigir
natural join
empresa.empleado
where age(f_nac,now()) < age('1968-01-01',now());

--Ejercicio w)
Select *
from
empresa.empleado
where
paterno LIKE 'A%'
OR
paterno LIKE 'D%'
OR
paterno LIKE 'G%'
OR
paterno LIKE 'J%'
OR
paterno LIKE 'L%'
OR
paterno LIKE 'P%'
OR
paterno LIKE 'R%';

--Ejercicio x)
select numProy,nombre,count(curp)
from
empresa.proyecto
group by
numProy
having
Extract(month from fecha_inicio) = 12; 

--Ejercicio y)
--No se resolvio

