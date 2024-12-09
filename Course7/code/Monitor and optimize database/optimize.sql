CREATE DATABASES bruh;
USE bruh;
SOURCE employeesdb/employees.sql;
-- 300024 records
SELECT * FROM employees;

-- Tips: Use Indexes
EXPLAIN SELECT * FROM employees;
SHOW INDEX FROM employees;
-- Watching the searching time and the number of rows 
EXPLAIN SELECT * FROM employees WHERE hire_date >= '2000-01-01';
-- Creating an index on the hire_date column
CREATE INDEX hire_date_index ON employees(hire_date);
SHOW INDEX FROM employees;
-- Watching the searching time and the number of rows after creating an index
SELECT * FROM employees WHERE hire_date >= '2000-01-01';
EXPLAIN SELECT * FROM employees WHERE hire_date >= '2000-01-01';
-- Dropping the index
DROP INDEX hire_date_index ON employees;

-- Tips: Use an UNION ALL Clause
SELECT * FROM employees WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';
EXPLAIN SELECT * FROM employees WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';
-- Creating an index on the first_name and last_name columns
CREATE INDEX first_name_index ON employees(first_name);
CREATE INDEX last_name_index ON employees(last_name);
-- Watching the searching time and the number of rows after creating an index
SELECT * FROM employees WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';
EXPLAIN SELECT * FROM employees WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';
-- Watching the searching time and the number of rows after using an UNION ALL clause and creating an index
SELECT * FROM employees WHERE first_name LIKE 'C%' UNION ALL SELECT * FROM employees WHERE last_name LIKE 'C%';

-- Tips: Be SELECTIVE
SELECT * FROM employees;
SELECT first_name, last_name, hire_date FROM employees;