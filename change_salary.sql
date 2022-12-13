create or replace 
procedure cambiar_salario(p_empid number, p_salary number)
is
  -- declarar variables
begin
  update employees set salary = p_salary
  where employee_id = p_empid;
  
  if sql%notfound then
     dbms_output.put_line('Empleado no encontrado');
  else
     commit;
  end if;
exception 
  when others then
    dbms_output.put_line('Error durante la actualizaion de salario : ' || sqlerrm);
end;
