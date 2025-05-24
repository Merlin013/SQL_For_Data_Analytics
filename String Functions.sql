SELECT 'This is test data' test_data

SELECT SUBSTRING('This is test data' FROM 1 FOR 4) test_data_extracted

SELECT SUBSTRING('This is test data' FROM 9 FOR 4) test_data_extracted

SELECT SUBSTRING('This is test data' FROM 9) test_data_extracted

SELECT department, REPLACE(department, 'Clothing', 'Attire') modified_data
FROM departments

SELECT department, 
REPLACE(department, 'Clothing', 'Attire') modified_data, 
(department || ' Department') as "Complete department name"
FROM departments

SELECT SUBSTRING(email, POSITION ('@' IN email) +1)
FROM employees

SELECT COALESCE(email, 'NONE') as email
FROM employees