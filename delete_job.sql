create or replace 
procedure borrar_empleo(empleo varchar2)
is 
cuenta_empleados number(10);
begin 
select count(*) into cuenta_empleados
from (select employee_id from employees where job_id = empleo);
      --union
      --select employee_id from job_history where job_id = empleo);
if cuenta_empleados = 0 then
 delete from jobs where job_id =empleo;
 if sql%notfound then
  dbms_output.put_line ('Trabajo invalido');
  end if;
  else
  dbms_output.put_line ('El empleo no puede ser borrado');
  end if;
end;
