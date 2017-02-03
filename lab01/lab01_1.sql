SELECT * FROM departments;
SELECT COUNT(employee_id) FROM employees;
SELECT * FROM employees WHERE salary > 15000;
SELECT * FROM employees WHERE EXTRACT(Year FROM TO_DATE(hire_date, 'dd-mon-yy')) BETWEEN 2002 AND 2004;
SELECT * FROM employees WHERE NOT phone_number LIKE '515%';
SELECT E.first_name || ' ' || E.last_name FROM departments D INNER JOIN employees E ON D.department_id = E.department_id WHERE D.department_name = 'Finance';
SELECT L.city || ' ' || L.state_province || ' ' || C.country_name FROM locations L JOIN countries C ON L.country_id = C.country_id JOIN regions R ON C.region_id = R.region_id WHERE R.region_name = 'Asia';
SELECT location_id FROM locations WHERE state_province IS NULL;