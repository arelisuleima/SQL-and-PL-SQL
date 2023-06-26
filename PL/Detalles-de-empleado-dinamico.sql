--Bloque que muestra los datos de un empleado como: 
--Nombre
--Años de experiencia
--Manager
--Numero de empleos anteriores
--Esta información es en base a un empleado ingresado por el usuario.

SET SERVEROUTPUT ON

DECLARE
  V_NAME EMPLOYEES.FIRST_NAME%TYPE;
  V_MANAGER EMPLOYEES.FIRST_NAME%TYPE;
  V_EXP NUMBER(2);
  V_COUNT NUMBER(2);
  V_EMPID NUMBER(5) := &employee_id; -- Ingresar el número de empleado deseado aquí
BEGIN
  SELECT FIRST_NAME,
         FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12),
         (SELECT FIRST_NAME
          FROM EMPLOYEES
          WHERE EMPLOYEE_ID = D.MANAGER_ID)
  INTO V_NAME, V_EXP, V_MANAGER
  FROM EMPLOYEES E JOIN DEPARTMENTS D USING (DEPARTMENT_ID)
  WHERE EMPLOYEE_ID = V_EMPID;

  SELECT COUNT(*)
  INTO V_COUNT
  FROM JOB_HISTORY
  WHERE EMPLOYEE_ID = V_EMPID;

  DBMS_OUTPUT.PUT_LINE('Nombre              :' || V_NAME);
  DBMS_OUTPUT.PUT_LINE('Años de experiencia :' || V_EXP);
  DBMS_OUTPUT.PUT_LINE('Manager             :' || V_MANAGER);
  DBMS_OUTPUT.PUT_LINE('Empleos anteriores  :' || V_COUNT);
END;
/


   
