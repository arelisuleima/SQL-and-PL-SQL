 ## Building Blocks in PL/SQL
**PL/SQL** is a structured language with blocks. Each PL/SQL block is defined by the keywords `DECLARE`, `BEGIN`, `EXCEPTION`, and `END`, which divide the block into three sections:

- **Declarative**: Statements that declare variables, constants, and other code elements that can be used within the block.
- **Executable**: Executable statements.
- **Exception handling**: A structured section for handling any exceptions that occur during the execution of the executable section. It is not necessary to declare it in the block or handle the exceptions that may be thrown.
```sql
begin
dbms_output.put_line('Hello!');
end;
```
**Variables**: They are used to store data and manipulate stored values.

They can store any PL/SQL value such as variables, types, cursors, or subprograms.
The characters $ and # are allowed, they should not have more than 30 characters, and can include letters or numbers.
◼ **Handling of variables**:
- They can be declared anywhere in the block.
- They can be assigned an initial value and impose a NOT NULL constraint.
- Their values can be replaced.
- The assignment operator is `‘:=’`.
- If a delimiter (`! !, [], ‘ ’`) is desired, it is used to initialize the string.
> ***Block Structure***:
`DECLARE`: Variables, cursors, defined exceptions.
`BEGIN`: SQL and PL/SQL statements.
`EXCEPTION`: Actions to be taken when exceptions occur.
`END`: Mandatory.





