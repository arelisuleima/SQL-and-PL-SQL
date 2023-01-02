create or replace procedure ver_empleados (emp out sys_refcursor)
as 
begin
open emp for 
select last_name, first_name, department_name
from employees
join departments using (department_id)
order by last_name;
end ver_empleados;
/
declare 
emp sys_refcursor;
nombre varchar2(50);
apellido varchar2(50);
departamento varchar2(50);
begin 
ver_empleados(emp);
loop
fetch emp into apellido, nombre, departamento;
exit when emp%notfound;
dbms_output.put_line (nombre || ' ' || apellido ||' '||departamento);
end loop;
close emp;
end;
--
