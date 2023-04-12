**SQL practical exam**

*Taking into account the HR scheme, solve the following questions.*

1. Create a query that returns all those records where the last_name field begins with the letter k:
 ```sql
   SELECT LAST_NAME FROM EMPLOYEES WHERE LAST_NAME LIKE 'K%';
   ```
2. You need to find the number of days each employee worked during the first month of its incorporation.

    Write an SQL query to find this information for all employees
```sql
SELECT last_name,
  	TRUNC(sysdate) - TRUNC(HIRE_DATE) AS "Dias trabajados"
FROM EMPLOYEES;
```
3. Print hire dates for all employees in the following formats:
- (i) 13 of February 1998 
- (ii) February 13, 1998.
```sql
SELECT LAST_NAME,
 	 HIRE_DATE,
  	TO_CHAR (HIRE_DATE, 'DD "of" FMMONTH"," YYYY') AS "Format1",
  	TO_CHAR (HIRE_DATE, 'FMMONTH, DD "," YYYY')     AS "Format2"
FROM EMPLOYEES;
```
4. Find the minimum, maximum, and average salary for all departments except DEPARTMENT_ID 80.
Print DEPARTMENT_ID, minimum, maximum, and average salary. Sort the results in descending order
median salary first, then maximum salary, then minimum salary. Use column aliases to rename
column names in the output for better visualization.
```sql
SELECT DEPARTMENT_ID,
  MIN(SALARY)          AS "MIN Salary",
  MAX(SALARY)          AS "MAX Salary",
  ROUND(AVG(SALARY),2) AS "AVG Salary"
FROM EMPLOYEES
WHERE DEPARTMENT_ID NOT IN 80
GROUP BY DEPARTMENT_ID;
```
5. Find the number of employees in each salary group. The salary groups are considered as follows.
Group 1: 0k to <5K, 5k to <10k, 10k to <15k, and so on.
```sql
SELECT
  CASE
    WHEN SALARY >= 0
    AND SALARY   < 5000
    THEN '0k to 5k'
    WHEN SALARY >= 5000
    AND SALARY   < 10000
    THEN ' 5k to 10k'
    WHEN SALARY >= 10000
    AND SALARY   < 15000
    THEN ' 10k to 15k'
    ELSE 'No group'
  END      AS grupo_salarial,
  COUNT(*) AS NUM_EMPLOYEES
FROM empLOYEES
GROUP BY
  CASE
    WHEN SALARY >= 0
    AND SALARY   < 5000
    THEN ' 0k to 5k'
    WHEN SALARY >= 5000
    AND SALARY   < 10000
    THEN '5k to 10k'
    WHEN SALARY >= 10000
    AND SALARY   < 15000
    THEN ' 10k to 15k'
    ELSE 'No group'
  END;
```
6. Find the number of employees who were hired in each year in each type of job. Print year, job ID, and total number of employees hired.
```sql
SELECT extract(YEAR FROM hire_date) AS YEAR,
  job_id,
  COUNT(employee_id) AS TOTAL_HIRED
FROM EMPLOYEES
GROUP BY extract(YEAR FROM HIRE_DATE),
  JOB_ID
ORDER BY JOB_ID;
```
7.Create a query that for each employee, enter the last name, salary, and title.
```sql
SELECT E.LAST_NAME,
  E.SALARY,
  J.JOB_TITLE      
FROM EMPLOYEES E
JOIN JOBS J
ON E.JOB_ID = J.JOB_ID;
```
8. Create a query that for each department, enter the name of the department and the name of the country in which it is located
```sql
SELECT D.DEPARTMENT_NAME,
  C.COUNTRY_NAME         AS COUNTRY
FROM DEPARTMENTS D
JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
JOIN COUNTRIES C
ON L.COUNTRY_ID = C.COUNTRY_ID;
```
9. Find the total number of departments located in the country
```sql
SELECT C.COUNTRY_NAME AS COUNTRY,
  COUNT(*)            AS TOTAL_DEPTOS
FROM DEPARTMENTS D
JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
JOIN COUNTRIES C
ON L.COUNTRY_ID = C.COUNTRY_ID
GROUP BY C.COUNTRY_NAME
ORDER BY COUNTRY;
```
10.For each employee, find the number of employee job changes.
```sql
SELECT E.EMPLOYEE_ID,
  E.FIRST_NAME ,
  COUNT(*) AS CHANGES
FROM EMPLOYEES E
RIGHT OUTER JOIN job_history j
ON j.employee_id = e.employee_id
GROUP BY E.FIRST_NAME,
  E.EMPLOYEE_ID
ORDER BY CHANGES DESC,
  E.FIRST_NAME;
  ```
  11. For each employee, find the total number of employees who were hired before him/her and those who were hired after him/her. Enter the employee's last name, the total number of employees hired before him, and the total number of employees hired after him.
```sql
SELECT E.LAST_NAME,
  (SELECT COUNT(*) FROM EMPLOYEES WHERE HIRE_DATE < E.HIRE_DATE
  ) AS HIRED_BEFORE,
  (SELECT COUNT(*) FROM EMPLOYEES WHERE hire_date > E.hire_date
  ) AS HIRED_AFTER
FROM EMPLOYEES E;
```
12.Find the last names of all the employees who work in the SALES department.
```sql
SELECT E.LAST_NAME  AS APELLIDO,
  D.DEPARTMENT_NAME AS DEPARTAMENTO
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID      = D.DEPARTMENT_ID
WHERE D.DEPARTMENT_NAME = 'Sales';
```
13.Find the last names and salaries of those employees whose salary is within ±5k of the average salary of the SALES department.
```sql
SELECT E.LAST_NAME,
  E.SALARY
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID      = D.DEPARTMENT_ID
WHERE D.DEPARTMENT_NAME = 'Sales'
AND e.SALARY BETWEEN
  (SELECT AVG(SALARY) - 5000 FROM EMPLOYEES WHERE DEPARTMENT_ID = 80
  )
AND (SELECT AVG(SALARY) + 5000 FROM EMPLOYEES WHERE DEPARTMENT_ID = 80)
ORDER BY salary;
```
14.Update the COMMISSION_PCT column to N times for each employee, where N is the number of employees that he as manager reports to. When N = 0, keep the old value of the COMMISSION_PCT column.
```sql
UPDATE employees e
SET commission_pct =
  CASE
    WHEN E.MANAGER_ID                                                        IS NOT NULL
    AND (SELECT COUNT(*) FROM employees a WHERE a.manager_id = e.employee_id) > 0
    THEN
      (SELECT (COUNT(*))*0.1 FROM employees a WHERE a.manager_id = e.employee_id
      )
    ELSE E.COMMISSION_PCT
  END;
```
15.Create a query to display the name and hire date of any employee hired after employee "Alexander Khoo".
```sql
SELECT first_name
  ||' '
  || last_name AS NOMBRE,
  hire_date    AS CONTRATACION
FROM EMPLOYEES
WHERE HIRE_DATE >
  (SELECT hire_date
  FROM employees
  WHERE first_name = 'Alexander'
  AND last_name    = 'Khoo'
  )
ORDER BY HIRE_DATE;
```
16.Create a view called EMPLOYSA based on name, salary and department numbers from the EMPLOYEES table with a salary greater than 5 thousand, the header for the employee's name must be EMPLOYEE, at the end verify that the view is indeed retrieving the requested information.
```sql
CREATE OR REPLACE VIEW EMPLOYSA
AS
  (SELECT FIRST_NAME
    ||' '
    || LAST_NAME AS EMPLEADO,
    SALARY,
    DEPARTMENT_ID
  FROM EMPLOYEES
  WHERE SALARY <5000
  );
  SELECT FIRST_NAME
    ||' '
    || LAST_NAME AS EMPLEADO,
    SALARY,
    DEPARTMENT_ID
  FROM EMPLOYEES
  WHERE SALARY >5000;
```
17.Create a sequence called EMPLOY_SEQ, the generation of sequential numbers must start at 500 with an increment of 20 to a maximum value of 10000, this sequence must have the restart property when it reaches its maximum value.
```sql
CREATE SEQUENCE employ_seq START WITH 500 INCREMENT BY 20 MAXVALUE 10000 cycle;
  DROP sequence EMPLOY_SEQ;
```
18.With the previously created EMPLOY_SEQ sequence, perform an insert for the employees table, show the inserted record with the beginning of the sequence.
```sql
INSERT
  INTO EMPLOYEES
    (
      EMPLOYEE_ID,
      FIRST_NAME,
      LAST_NAME,
      EMAIL,
      PHONE_NUMBER,
      HIRE_DATE,
      JOB_ID,
      SALARY,
      COMMISSION_PCT,
      MANAGER_ID,
      DEPARTMENT_ID
    )
    VALUES
    (
      employ_seq.NEXTVAL,
      'Justin',
      'Brown',
      'JBROWN',
      '5554031465',
      SYSDATE,
      'IT_PROG',
      23000,
      NULL,
      103,60
    );
```







 
