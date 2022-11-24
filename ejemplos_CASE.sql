--
-- Ejemplo de CASE Simple
--
DECLARE
  c_grade CHAR( 1 );
  c_rank  VARCHAR2( 20 );
BEGIN
  c_grade := 'B';
  CASE c_grade
  WHEN 'A' THEN
    c_rank := 'Excellent' ;
  WHEN 'B' THEN
    c_rank := 'Very Good' ;
  WHEN 'C' THEN
    c_rank := 'Good' ;
  WHEN 'D' THEN
    c_rank := 'Fair' ;
  WHEN 'F' THEN
    c_rank := 'Poor' ;
  ELSE
    c_rank := 'No such grade' ;
  END CASE;
  DBMS_OUTPUT.PUT_LINE( c_rank );
END;
/
---
--Ejemplo CASE Search
--
DECLARE
  n_VENTAS   NUMBER;
  n_comision NUMBER;
BEGIN
  n_ventas := 150000;
  CASE
  WHEN n_ventas  > 200000 THEN
    n_comision  := 0.2;
  WHEN n_ventas >= 100000 AND n_ventas < 200000 THEN
    n_comision  := 0.15;
  WHEN n_ventas >= 50000 AND n_ventas < 100000 THEN
    n_comision  := 0.1;
  WHEN n_ventas  > 30000 THEN
    n_comision  := 0.05;
  ELSE
    n_comision := 0;
  END CASE;
  DBMS_OUTPUT.PUT_LINE( 'Commission is ' || n_comision * 100 || '%');
END;
/
