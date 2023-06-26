--Mostrar la cantidad de empleados por departamento.

set SERVEROUTPUT on
declare 
cursor DEPTCUR is --Cursor de departamento que almacena el id y nombre 
select DEPARTMENT_ID, DEPARTMENT_NAME
from DEPARTMENTS
where DEPARTMENT_ID in (select DEPARTMENT_ID from EMPLOYEES)
order by 2;

cursor EMPCUR (P_DEPTID number)
is 
select FIRST_NAME 
from EMPLOYEES
where DEPARTMENT_ID = P_DEPTID
order by 1;

V_COUNT number(3);
begin 
for DEPTREC in DEPTCUR
LOOP 
DBMS_OUTPUT.PUT_LINE(DEPTREC.DEPARTMENT_name);
V_COUNT := 0;
for EMPREC in EMPCUR(DEPTREC.DEPARTMENT_ID)
LOOP
DBMS_OUTPUT.PUT_LINE('    '||EMPREC.FIRST_NAME);
V_COUNT := V_COUNT +1; -- Conteo de empleados 
end LOOP;
DBMS_OUTPUT.PUT_LINE('    '|| 'No. de empleados: ' || V_COUNT);
end LOOP;
end; 
/
