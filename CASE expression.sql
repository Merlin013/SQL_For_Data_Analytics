/*Conditional Expressions Using CASE Clause */

SELECT first_name, salary,
CASE
	WHEN salary < 100000 THEN 'UNDER PAID'
	WHEN salary > 100000 THEN 'WELL PAID'
	END as category
FROM employees
ORDER BY salary desc


Select a.category, count(*)
FROM (SELECT first_name, salary,
CASE
	WHEN salary < 100000 THEN 'UNDER PAID'
	WHEN salary > 100000 THEN 'WELL PAID'
	END as category
FROM employees
ORDER BY salary desc) a
group by a.category

SELECT SUM(CASE WHEN salary < 100000 THEN 1 ELSE 0 END) as under_paid, 
SUM(CASE WHEN salary > 100000 AND salary < 160000 THEN 1 ELSE 0 END) as well_paid, 
SUM(CASE WHEN salary > 160000 THEN 1 ELSE 0 END) as executive
FROM employees

SELECT department, count(*)
FROM employees
WHERE department IN ('Sports', 'Tools', 'Clothing', 'Computers')
GROUP BY department

SELECT SUM(CASE WHEN department = 'Sports' THEN 1 ELSE 0 END) as Sports_employees, 
SUM(CASE WHEN department = 'Tools' THEN 1 ELSE 0 END) as Tools_employees,
SUM(CASE WHEN department = 'Clothing' THEN 1 ELSE 0 END) as Clothing_employees,
SUM(CASE WHEN department = 'Computers' THEN 1 ELSE 0 END) as Computers_employees
FROM employees


SELECT first_name, 
CASE WHEN region_id = 1 THEN (SELECT country from regions where region_id = 1) END as region_01,
CASE WHEN region_id = 2 THEN (SELECT country from regions where region_id = 2) END as region_02,
CASE WHEN region_id = 3 THEN (SELECT country from regions where region_id = 3) END as region_03,
CASE WHEN region_id = 4 THEN (SELECT country from regions where region_id = 4) END as region_04,
CASE WHEN region_id = 5 THEN (SELECT country from regions where region_id = 5) END as region_05,
CASE WHEN region_id = 6 THEN (SELECT country from regions where region_id = 6) END as region_06,
CASE WHEN region_id = 7 THEN (SELECT country from regions where region_id = 7) END as region_07
FROM employees

SELECT count(a.region_01) + COUNT(a.region_02) + COUNT(a.region_03) AS United_states,
count(a.region_04) + COUNT(a.region_05) as Asia, 
count(a.region_06) + COUNT(a.region_07) as Canada
FROM (

SELECT first_name, 
CASE WHEN region_id = 1 THEN (SELECT country from regions where region_id = 1) END as region_01,
CASE WHEN region_id = 2 THEN (SELECT country from regions where region_id = 2) END as region_02,
CASE WHEN region_id = 3 THEN (SELECT country from regions where region_id = 3) END as region_03,
CASE WHEN region_id = 4 THEN (SELECT country from regions where region_id = 4) END as region_04,
CASE WHEN region_id = 5 THEN (SELECT country from regions where region_id = 5) END as region_05,
CASE WHEN region_id = 6 THEN (SELECT country from regions where region_id = 6) END as region_06,
CASE WHEN region_id = 7 THEN (SELECT country from regions where region_id = 7) END as region_07
FROM employees ) a


/*Assignment
Write a query that displays 3 columns. The query should display the
fruit and it's total supply along with a category of either LOW, 
ENOUGH or FULL. Low category means that the total supply of the 
fruit is less than 20,000. The enough category means that the total
supply is between 20,000 and 50,000. If the total supply is greater
than 50,000 then that fruit falls in the full category.*/

SELECT * FROM fruit_imports

SELECT name, total_supply, 
CASE WHEN total_supply < 20000 THEN 'LOW'
WHEN total_supply >=20000 AND total_supply <= 50000 THEN 'ENOUGH'
WHEN total_supply > 50000 THEN 'FULL' END as category
FROM (
SELECT name, sum(supply) total_supply
FROM fruit_imports
GROUP BY name
) a


/*Taking into consideration the supply column and the cost_per_unit
column, you should be able to tabulate the total cost to import 
fruits by each season. The result will look something like this:

"Winter" "10072.50"
"Summer" "19623.00"
"All Year" "22688.00"
"Spring" "29930.00"
"Fall" "29035.00"

Write a query that would transpose this data so that the seasons 
become columns and the total cost for each season fills the first 
row?*/

SELECT SUM(CASE WHEN season = 'Winter' THEN total_cost end) as Winter_total,
SUM(CASE WHEN season = 'Summer' THEN total_cost end) as Summer_total,
SUM(CASE WHEN season = 'Spring' THEN total_cost end) as Spring_total,
SUM(CASE WHEN season = 'Fall' THEN total_cost end) as Fall_total,
SUM(CASE WHEN season = 'All Year' THEN total_cost end) as All_Year_total
FROM (
select season, sum(supply * cost_per_unit) total_cost
from fruit_imports
group by season
    ) a