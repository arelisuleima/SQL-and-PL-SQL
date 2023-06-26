-- Calculo del salario de los empleados teniendo en cuenta la comisión y la bonificación.

set serveroutput on
declare 
  cursor empcur is 
    select first_name, salary, commission_pct
    from employees;
    
  v_salary employees.salary%type;   
begin 
   for emprec in empcur
   loop 
       -- Calcular salario + comision
       v_salary := emprec.salary +  emprec.salary * nvl(emprec.commission_pct,0);
       -- Arega bonus de  10% o 5% basandose en el valor de la commission_pct                  
       if emprec.commission_pct is not null then
           v_salary := v_salary  + emprec.salary * 0.10;
       else
           v_salary := v_salary  + emprec.salary * 0.05;
       end if;
       
       dbms_output.put_line( rpad(emprec.first_name,20) ||  to_char(v_salary,'99,999.00'));
   end loop;
end;
