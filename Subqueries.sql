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



/*Creating a new table*/

CREATE table dupes (id integer, name varchar(10));

INSERT INTO dupes VALUES (1, 'FRANK');
INSERT INTO dupes VALUES (2, 'FRANK');
INSERT INTO dupes VALUES (3, 'ROBERT');
INSERT INTO dupes VALUES (4, 'ROBERT');
INSERT INTO dupes VALUES (5, 'SAM');
INSERT INTO dupes VALUES (6, 'FRANK');
INSERT INTO dupes VALUES (7, 'PETER');

SELECT * FROM dupes

/*Assignment
Write query that returns only unique names*/

SELECT min(id), name
FROM dupes
GROUP BY name

DELETE FROM dupes 
WHERE id NOT IN (SELECT min(id)
FROM dupes
GROUP BY name)

DROP TABLE dupes


SELECT * FROM employees

SELECT ROUND(AVG (salary)) 
FROM employees 
WHERE salary NOT IN ((SELECT MAX(salary) FROM employees), 
(SELECT MIN(salary) FROM employees))