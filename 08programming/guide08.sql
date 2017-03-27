-- Theodore Bigelow
-- CS 342 Spring 2017
-- 03/27/17
--
-- SQL file for homework 6 AS per the assignment at 
-- https://cs.calvin.edu/courses/cs/342/kvlinden/06sql/homework.html

-- Work through the following materials this week, making sure that you can do the given activities.
--   Read Sections 10.1, 10.4.1 & 26.1.1–2:
--     Name the three basic approaches to database programming.
--       1. Embed database commands in an existing language
--       2. Make a library of database commands for use with an existing language
--       3. Make an entirely new programming language to handle database commands
--     Explain the concepts of:
--       impedance mismatch - occurs when the database model and the programming language model differ
--       stored procedures - procedures stored in the DBMS and executed at the database server
--       triggers - a way to specify active rules
			
--   Read Server-Side Programming: PL/SQL and Java.. Focus on server-side programming, PL/SQL and triggers; skip the section on “Overview of Java in Oracle Database”.
--     Compare and contrast:
--       procedural vs non-procedural languages
--         procedural: Allows programmers to specify the way they want the information to be gathered
--         non-procedural: Allows programmers to specify the information they want without specifying the way it's gathered			
--       client-side vs server-side database programming.
--         client-side: embedding database commands in programs written in higher-level languages like Java or C
--         server-side: stored proedures written with database commands that can be called with client-side code
--     Explain why one would want to do server-side programming using PL/SQL.
--       Server-side code deploys uniformly across clients.  With server-side code the most efficient ways to perform tasks can be used every time.
--     For each of the following code segments, identify the type of the database object and explain what it does.

-- i. 
CREATE PROCEDURE limited_count (limit IN integer) AS
BEGIN
  FOR i IN 1..limit LOOP
      dbms_output.put_line(i);
  END LOOP;
END;
-- Type of object: Stored Procedure
-- Function: Outputs the lines up to the line given
 
-- ii.
BEGIN
  dbms_output.put_line('Hello, PL/SQL!');
END;
-- Type of object: Stored Procedure
-- Function: Prints 'Hello, PL/SQL!'
 
 -- iii.
CREATE TRIGGER log_trigger
  BEFORE INSERT OR UPDATE OF lastName ON Person
  FOR each row
BEGIN
  dbms_output.put_line('Hello, name change!');
END;
-- Type of object: Trigger
-- Function: Output 'Hello, name change!' when lastName is changed or inserted in the Person table