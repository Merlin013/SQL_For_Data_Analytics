"""GROUP BY Function"""


SELECT SUM(salary), department
FROM employees
WHERE 1=1
GROUP BY department;

/*Assignment
Total count of employees working for each department*/
SELECT COUNT(employee_id) total_number_employees, department,
ROUND(AVG(salary)) Average_Salary, MIN(salary), MAX(salary) 
FROM employees
WHERE salary > 70000
GROUP BY department
ORDER BY total_number_employees DESC;

/* HAVING Command
is used to filter aggregated data*/

SELECT department, COUNT(*)
FROM employees
GROUP BY department
HAVING COUNT(*) > 35
ORDER BY department;

/* Assignment
How many employees have the same first name */

SELECT COUNT(first_name), first_name
FROM employees
GROUP BY first_name
HAVING COUNT(first_name) >1

/* Assignment
Find the unique departments in the employees table without using the DISTINCT command */

SELECT department
FROM employees
GROUP BY department

/* Assignment
Find all the domain names and the total number of employees that have that
given domain name*/

SELECT SUBSTRING(email, POSITION('@' IN email) +1) domain_name, COUNT(*)
FROM employees
WHERE email IS NOT NULL
GROUP BY domain_name
ORDER BY COUNT(*) DESC

/* Assignment
Display MIN, MAX and AVG salaries broken down by region and gender*/

SELECT gender, region_id, MIN(salary) min_salary, MAX(salary) max_salary, ROUND(AVG(salary)) avg_salary 
FROM employees
GROUP BY gender, region_id
ORDER BY gender ASC, region_id ASC



