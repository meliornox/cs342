-- Theodore Bigelow
-- CS 342 Spring 2017
-- 03/31/17
--
-- SQL file for homework 7 as per the assignment at 
-- https://cs.calvin.edu/courses/cs/342/kvlinden/07sql/homework.html

-- Create a view of all employees and their department; include the employee ID, name, email, hire date and department name. Then write SQL commands to do the following. If any of these view-based queries won’t work, show the query and explain why it generates an error.

DROP VIEW [Employee Departments];

CREATE VIEW [Employee Departments] AS
SELECT E.employee_id, E.first_name, E.last_name, E.email, E.hire_date, D.department_name
FROM Employees E 
JOIN Departments D ON E.department_id = D.department_id;

--   Get the name and ID of the newest employee in the “Executive” department.
SELECT * FROM(
	SELECT first_name || ' ' || last_name Name, employee_id
	FROM [Employee Departments]
	WHERE department_name = 'Executive'
	ORDER BY hire_date DESC)
WHERE ROWNUM = 1;

--   Change the name of the “Administration” department to “Bean Counting”.
UPDATE [Employee Departments]
SET department_name = 'Bean Counting'
WHERE department_name = 'Administration';
--     This generates an error because Departments is not key-preserved in our view.

--   Change the name of “Jose Manuel” to just “Manuel”
UPDATE [Employee Departments]
SET first_name = 'Manuel'
WHERE first_name = 'Jose Manuel';

--   Insert a new employee in the “Payroll” department (make up appropriate data for this record).
INSERT INTO [Employee Departments] VALUES(207, 'John', 'Smith', 'jsmith', '05-JAN-08', 'Shipping');
--     This generates an error because Employees is not key-preserved in our view.

-- Redo the previous exercise with a materialized view.
DROP MATERIALIZED VIEW [Materialized Employee Departments];

CREATE MATERIALIZED VIEW [Materialized Employee Departments] 
AS SELECT E.employee_id, E.first_name, E.last_name, E.email, E.hire_date, D.department_name
FROM Employees E 
JOIN Departments D ON E.department_id = D.department_id;

SELECT * FROM(
	SELECT first_name || ' ' || last_name, employee_id
	FROM [Materialized Employee Departments]
	WHERE department_name = 'Executive'
	ORDER BY hire_date DESC)
WHERE ROWNUM = 1;

UPDATE [Materialized Employee Departments]
SET department_name = 'Bean Counting'
WHERE department_name = 'Administration';
--   Materialized views are read-only.

UPDATE [Materialized Employee Departments]
SET first_name = 'Manuel'
WHERE first_name = 'Jose Manuel';
--   Materialized views are read-only.

INSERT INTO [Materialized Employee Departments] VALUES(207, 'John', 'Smith', 'jsmith', '05-JAN-08', 'Shipping');
--   Materialized views are read-only.

-- Write the following queries as specified:

-- The query on which your view from exercise 1 is based - Write this query using both the relational algebra and tuple relational calculus, with respect to the original HR relations.

--   [Employee Departments] <- π<E.employee_id, E.first_name, E.last_name, E.email, E.hire_date, D.department_name>(ρ<E>(Employees)⋈<E.department_id=D.department_id>ρ<D>(Departments))
--   [Employee Departments] <- {E.employee_id, E.first_name, E.last_name, E.email, E.hire_date, d.department_name | Employees(E) ^ Departments(D) ^ D.department_id=D.department_id}

-- The query from exercise 1.a - Write this query using (only) the relational calculus, with respect to DeptView.
--   {E.first_name, E.last_name, E.employee_id | EMP_DEP(E) ^ E.department_name='Executive' ^ ¬(EMP_DEPT(E1) (E1.hire_date > E.hire_date))}