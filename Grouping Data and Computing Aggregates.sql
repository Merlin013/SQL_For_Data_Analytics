"""GROUP BY Function"""


SELECT SUM(salary), department
FROM employees
WHERE 1=1
GROUP BY department;

"""Assignment"""
"""Total count of employees working for each department"""
SELECT COUNT(employee_id) total_number_employees, department, ROUND(AVG(salary)) Average_Salary, MIN(salary), MAX(salary) 
FROM employees
GROUP BY department;
