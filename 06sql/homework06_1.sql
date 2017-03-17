-- Theodore Bigelow
-- CS 342 Spring 2017
-- 03/10/17
--
-- SQL file for homework 6 AS per the assignment at 
-- https://cs.calvin.edu/courses/cs/342/kvlinden/06sql/homework.html

-- Please write SQL queries that retrieve the following information FROM the HR database.
--     a. The IDs and full names of managers and the number of employees each of them manages. Order the results BY decreasing number of employees and return only the top ten results.

SELECT * FROM(
	SELECT M.employee_id, M.first_name || ' '|| M.last_name AS Name, COUNT(E.employee_id) AS Employees
    FROM Employees M
	JOIN Employees E ON M.employee_id = E.manager_id
	GROUP BY M.employee_id, M.first_name, M.last_name
	ORDER BY COUNT(E.employee_id) DESC)
WHERE ROWNUM <= 10;

--     b. The name, number of employees and total salary for each department outside of the US with less than 100 employees. The total salary is the SUM of the salaries of each of the department's employees.

SELECT D.department_name, COUNT(1) AS Employees, SUM(E.salary) AS Total_Salary
FROM Departments D 
JOIN Locations L ON D.location_id = L.location_id
AND L.country_id <> 'US'
JOIN Employees E
ON E.department_id = D.department_id
GROUP BY D.department_name
HAVING COUNT(1) < 100;

--     c. The department name, department manager name and manager job title for all departments. If the department has no manager, include it in the output with NULL values for the manager and title.

SELECT D.department_name, M.first_name || ' ' || M.last_name AS Name, J.job_title
FROM Departments D
LEFT JOIN Employees M ON D.manager_id = M.employee_id
LEFT JOIN Jobs J ON M.job_id = J.job_id;


--     d. The name of each department along with the average salary of the employees of that department. If a department has no employees, include it in the list with no salary value. Order your results BY decreasing salary. You may ORDER the NULL-valued salaries however you’d like.

SELECT D.department_name, TRUNC(AVG(E.salary)) AS Average 
FROM Departments d
LEFT OUTER JOIN Employees E ON D.department_id = E.department_id
GROUP BY D.department_name
ORDER BY Average_salary DESC NULLS LAST;	