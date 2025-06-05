/*Subqueries*/

SELECT * FROM employees
WHERE department NOT IN (SELECT department from departments);


SELECT a.first_name, a.salary
FROM (SELECT * FROM employees WHERE salary > 150000) a;
/*When source of data is in FROM clause, we need to give it a name*/

SELECT first_name, last_name, salary, (SELECT first_name FROM employees limit 1)
FROM employees /*This query is just for example and doesnt make any sense */

/*Assignment
Write a select statment that returns all of the employees that work in electronic division*/ 

SELECT * FROM departments

SELECT * 
FROM employees
WHERE department IN (SELECT department FROM departments WHERE division = 'Electronics')

SELECT * FROM employees 
WHERE region_id > ALL (SELECT region_id FROM regions WHERE country = 'United States')


/*Assignment 
Write a query that returns all of those employees that work in the kids 
divison and the dates which those employees were hired is greater than all the 
hire_dates of employees who work in the mantenance department*/

Select * from departments

SELECT * FROM employees
WHERE department IN (SELECT department FROM departments WHERE division = 'Kids') 
AND hire_date > ALL (SELECT hire_date FROM employees WHERE department ='Maintenance')


