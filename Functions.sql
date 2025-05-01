"""Functions"""

-- SUBSTRING function
SELECT SUBSTRING('This is a Test String' FROM 11) test_data_extracted

-- REPLACE function
"Here we are replacing the word clothing with attire"
SELECT department, 
REPLACE(department, 'Clothing', 'Attire') modified_Data, 
department || ' Department' new_department
FROM departments

-- POSITION function
-- We can use the position function to help with extraction from a specific position

SELECT POSITION('@' IN email)
FROM employees

-- Using this information we can extract the domain name in email. 
SELECT SUBSTRING(email, POSITION('@' IN email) +1) as domain_name
FROM employees

-- COALESCE function
-- Is used to basically replace NULL or empty cells with some data or string that we can choose
SELECT COALESCE(email, 'NONE') as email
FROM employees