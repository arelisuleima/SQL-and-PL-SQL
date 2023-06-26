-- Calculo de bonus basado en su historial de empleo(job_history) y comisión(commission_pct)
-- 40% si job_history es el empleo actual , 25 % si tiene comisión, en otro caso 35%

SET SERVEROUTPUT ON

DECLARE
  CURSOR EMPCUR IS
     SELECT EMPLOYEE_ID, SALARY, COMMISSION_PCT, COUNT(START_DATE) JOBCOUNT
     FROM EMPLOYEES LEFT OUTER JOIN JOB_HISTORY JH
     USING(EMPLOYEE_ID)
     GROUP BY EMPLOYEE_ID,SALARY,COMMISSION_PCT
     ORDER BY 1;
     
   V_BONUS NUMBER(5);
BEGIN
  FOR  EMPREC IN EMPCUR
  LOOP
     IF EMPREC.JOBCOUNT > 0 THEN
        V_BONUS := EMPREC.SALARY * 0.40;
     ELSIF EMPREC.COMMISSION_PCT IS NOT NULL THEN
        V_BONUS := EMPREC.SALARY * 0.25;
     ELSE
        V_BONUS := EMPREC.SALARY * 0.35;
     END IF;
     
     DBMS_OUTPUT.PUT_LINE(EMPREC.EMPLOYEE_ID || ' - ' || V_BONUS);
  END LOOP;     
END;