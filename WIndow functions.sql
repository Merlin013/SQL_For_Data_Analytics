/*Window function*/

SELECT department, count(*)
FROM employees
GROUP BY department

/*Combining grouping columns with non grouping columns*/
SELECT first_name, department, (SELECT count(*) FROM employees e1
WHERE e1.department = e2.department)
FROM employees e2
GROUP BY department, first_name

SELECT first_name, department, 
COUNT(*) OVER(PARTITION by department)
FROM employees 

SELECT first_name, department, 
SUM(salary) OVER(PARTITION by department)
FROM employees

/*Using Order by in the OVER clause*/

SELECT first_name, hire_date, salary, 
SUM (salary) OVER(ORDER BY hire_date RANGE BETWEEN UNBOUNDED PRECEDING AND
CURRENT ROW) AS running_total_of_salaries
FROM employees
ORDER BY hire_date


SELECT first_name, hire_date, department, salary, 
SUM(salary) OVER(ORDER BY hire_date ROWS BETWEEN 1 PRECEDING AND
CURRENT ROW)
FROM employees

/*Ranking and Bucketing functions*/

SELECT first_name, email, department, salary,
RANK() OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees

SELECT * FROM 
(SELECT first_name, email, department, salary,
RANK() OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees) a
WHERE RANK = 8

--NTILE function/ Bucketing function

SELECT first_name, email, department, salary,
NTILE(5) OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees

--first_value function

SELECT first_name, email, department, salary,
first_value(salary) OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees

--nth_value function

SELECT first_name, email, department, salary,
NTH_VALUE(salary, 5) OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees

-- LEAD and LAG function

SELECT first_name, last_name, salary, 
LEAD(salary) OVER() next_salary
FROM employees

SELECT first_name, last_name, salary, 
LAG(salary) OVER() previous_salary
FROM employees

SELECT department, last_name, salary,
LAG(salary) OVER(Partition BY department ORDER BY salary desc) closest_higher_salary
FROM employees

/*Working with Rollups and cubes*/

CREATE TABLE sales
(
	continent varchar(20),
	country varchar(20),
	city varchar(20),
	units_sold integer
);

INSERT INTO sales VALUES ('North America', 'Canada', 'Toronto', 10000);
INSERT INTO sales VALUES ('North America', 'Canada', 'Montreal', 5000);
INSERT INTO sales VALUES ('North America', 'Canada', 'Vancouver', 15000);
INSERT INTO sales VALUES ('Asia', 'China', 'Hong Kong', 7000);
INSERT INTO sales VALUES ('Asia', 'China', 'Shanghai', 3000);
INSERT INTO sales VALUES ('Asia', 'Japan', 'Tokyo', 5000);
INSERT INTO sales VALUES ('Europe', 'UK', 'London', 6000);
INSERT INTO sales VALUES ('Europe', 'UK', 'Manchester', 12000);
INSERT INTO sales VALUES ('Europe', 'France', 'Paris', 5000);

SELECT * from sales
order by continent, country, city

SELECT continent, sum(units_sold)
FROM sales
GROUP by continent

SELECT city, sum(units_sold)
FROM sales
GROUP by city

SELECT continent, country, city, sum(units_sold)
FROM sales
GROUP BY GROUPING SETS(continent, country, city, ())

SELECT continent, country, city, sum(units_sold)
FROM sales
GROUP BY ROLLUP(continent, country, city)

SELECT continent, country, city, sum(units_sold)
FROM sales
GROUP BY CUBE(continent, country, city)

/*Assignment

Write a query that finds students who do not take CS180.*/
SELECT * FROM students
WHERE student_no NOT IN (
    SELECT student_no
    FROM student_enrollment
    WHERE course_no = 'CS180'
    );

/*Write a query to find students who take CS110 or
CS107 but not both.*/

SELECT s.*
FROM students s, student_enrollment se
WHERE s.student_no = se.student_no
AND se.course_no IN ('CS110', 'CS107')
AND s.student_no NOT IN ( SELECT a.student_no
                          FROM student_enrollment a, student_enrollment b
                          WHERE a.student_no = b.student_no
                          AND a.course_no = 'CS110'
                          AND b.course_no = 'CS107');

/*Write a query to find students who take 
CS220 and no other courses.*/

SELECT s.*
FROM students s, student_enrollment se
WHERE s.student_no = se.student_no
AND s.student_no NOT IN ( SELECT student_no
                          FROM student_enrollment
                          WHERE course_no != 'CS220');

/*Write a query that finds those students who take at 
most 2 courses. Your query should exclude students that 
don't take any courses as well as those that take more 
than 2 course.*/

SELECT s.student_no, s.student_name, s.age
FROM students s, student_enrollment se
WHERE s.student_no = se.student_no
GROUP BY s.student_no, s.student_name, s.age
HAVING COUNT(*) <= 2;

/*Write a query to find students who are older 
than at most two other students.*/

SELECT s1.*
FROM students s1
WHERE 2 >= (SELECT count(*)
                FROM students s2
                WHERE s2.age < s1.age)