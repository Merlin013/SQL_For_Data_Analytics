"""Grouping Functions: To do calculations and get insights from the data"""
"""Grouping functions are desiged to work with numeric data"""

SELECT UPPER(first_name), LOWER(last_name)
FROM employees 
"""These are referred to as single row functions"""

SELECT MAX(salary)
FROM employees

SELECT MIN(salary)
FROM employees

SELECT ROUND(AVG(salary))
FROM employees

SELECT COUNT(employee_id)
FROM employees

SELECT COUNT(email)
FROM employees

SELECT SUM(salary)
FROM employees
WHERE department = 'Clothing'


