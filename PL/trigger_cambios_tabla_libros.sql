-- TRigger que inserta, actualiza y borra datos de la tabla LIBROS 
-- Los cambios efectuados los almacena en la tabla CONTROL 
-- Cada vez que se consulta la tabla CONTROL se muestra el usuario, acción, fecha y hora de ejecución.

drop table libros;
drop table control;

-- Creación tabla libros
create table libros(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
 );
 -- Creación tabla Control
 create table control(
  usuario varchar2(30),
  fecha date,
  operacion varchar2(20)
 );
 -- Insertar valores a la tabla libros 
 insert into libros values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros values(103,'El aleph','Borges','Emece',28);
 insert into libros values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into libros values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);
 --alter session para cambiar el formato ene l que se muestra la hora y fecha
 alter session set nls_date_format = 'DD/MM/YYYY HH24:MI';
 --Crear el trigger
 create or replace trigger t_cambios_libros
 before insert or update or delete 
 on libros 
 for each row
 begin 
 if inserting then 
 insert into control values (user, sysdate, 'Insertado');
 end if;
 if updating then 
 insert into control values (user, sysdate, 'Actualizado');
 end if;
 if deleting then 
 insert into control values (user, sysdate, 'Borrado');
 end if;
 end tr_cambios_libros;
 /
 --Ingresamos registros en la tabla LIBROS.
 insert into libros values(150, 'Laberintos', 'Gaskin','Planeta', 230);
 --Se comprueba en la tabala CONTROL.
 select * from control;
 truncate table control;
 --Actualizamos valores de la tabla LIBROS 
 update libros set precio = precio + precio * 0.1 where codigo = 105;
 -- Borra valores de la tabla LIBROS
 delete from libros where codigo = 150;
 --Mostrar errores del trigger
 show errors trigger tr_cambios_libros;
 --Trigger utilizando limitaciones 
 create or replace trigger tr_precio_libros
 before insert or update precio
 on libros
 for each row when(new.precio >50)
 begin 
 :new.precio := round(:new.precio);
 end tr_precio_libros;
 /

--
 
 
 
