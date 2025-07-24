/*Correlated functions*/

SELECT department, max(salary), min(salary)
FROM employees
GROUP BY department


SELECT department, first_name, salary,
CASE WHEN salary = max_by_department THEN 'HIGHEST SALARY'
	 WHEN salary = min_by_department THEN 'LOWEST SALARY'
END as salary_in_department
FROM (

SELECT department, first_name, salary, 
(SELECT max(salary) FROM employees e2 WHERE 
e1.department = e2.department) as max_by_department,
(SELECT min(salary) FROM employees e2 WHERE 
e1.department = e2.department) as min_by_department
FROM employees e1
) a
WHERE salary in (max_by_department, min_by_department)
ORDER BY department


/*Table Joins*/

SELECT first_name, country
FROM employees e, regions r
WHERE e.region_id = r.region_id

SELECT first_name, email, division, country
FROM employees e, departments d, regions r
WHERE e.department = d.department AND e.region_id=r.region_id
AND email IS NOT NULL 

SELECT country, count(employee_id)
FROM employees e, regions r
WHERE e.region_id = r.region_id
GROUP BY country


/*Inner and Outer Joins*/
SELECT first_name, country
FROM employees e INNER JOIN regions r
ON e.region_id = r.region_id

SELECT first_name, email, division
FROM employees e INNER JOIN departments d
ON e.department = d.department

SELECT first_name, email, division, country
FROM employees e INNER JOIN departments d
ON e.department = d.department
INNER JOIN regions r ON e.region_id = r.region_id
WHERE email is not NULL


SELECT distinct department FROM employees
-- 27 departments

SELECT distinct department from departments
-- 24 departments

--Left Join/Right Join

SELECT distinct e.department, d.department
FROM employees e INNER JOIN departments d 
ON e.department = d.department

SELECT distinct e.department, d.department
FROM employees e LEFT JOIN departments d 
ON e.department = d.department

SELECT distinct e.department, d.department
FROM employees e RIGHT JOIN departments d 
ON e.department = d.department

SELECT distinct e.department
FROM employees e LEFT JOIN departments d
ON e.department = d.department 
WHERE d.department IS NULL