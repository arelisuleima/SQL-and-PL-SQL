--Bloque que aumenta el salario de los empleados 
declare
  v_deptid  employees.department_id%type;
  v_salary  employees.salary%type;
begin
  select department_id, salary into v_deptid, v_salary
  from employees
  where employee_id = 130;
  
  case 
   when v_deptid < 50 then
        v_salary := v_salary * 1.2;
   when v_deptid < 100 then
        v_salary := v_salary * 1.3;        
   else
        v_salary := v_salary * 1.25;        
  end case;
  DBMS_OUTPUT.PUT_LINE('Salario aumentado: ' || v_salary);
  update employees set salary = v_salary
  where employee_id = 130;
end;
/

