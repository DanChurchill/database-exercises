USE leavitt_1861;
USE employees;
-- 1.  Using the example from the lesson, create a temporary table called employees_with_departments 
-- that contains first_name, last_name, and dept_name for employees currently with that department. 
-- Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", 
-- it means that the query was attempting to write a new table to a database that you can only read.
CREATE TEMPORARY TABLE leavitt_1861.employees_with_departments AS
SELECT first_name, last_name, dept_name
FROM employees
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no);

SELECT * FROM employees_with_departments LIMIT 10;
-- 1A. Add a column named full_name to this table. 
ALTER TABLE employees_with_departments ADD full_name VARCHAR(35);


-- 1B.  Update the table so that full name column contains the correct data
UPDATE employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name);


-- 1C.  Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;


-- 1D.  What is another way you could have ended up with this same table?
CREATE TABLE leavitt_1861.employees_with_departments AS
SELECT CONCAT(first_name, ' ',last_name) AS full_name, dept_name
FROM employees
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no);

DROP TABLE employees_with_departments;

-- 2. Create a temporary table based on the payment table from the sakila database.
USE sakila;
USE leavitt_1861;

CREATE TEMPORARY TABLE leavitt_1861.payments AS
SELECT * FROM payment;

SELECT * FROM payments LIMIT 10;
DESCRIBE payments;
DROP TABLE payments;
	-- Write the SQL necessary to transform the amount column such that it is stored as an integer 
	-- representing the number of cents of the payment. For example, 1.99 should become 199.
ALTER TABLE payments MODIFY amount FLOAT;
UPDATE payments SET amount = amount * 100;
ALTER TABLE payments MODIFY amount int(100);

  

-- 3.  Find out how the current average pay in each department compares to the overall current pay for everyone at the company.
--     In order to make the comparison easier, you should use the Z-score for salaries. 
USE employees; 
USE leavitt_1861;

-- create temp table with avg salary by department
CREATE TABLE leavitt_1861.department_salaries AS
SELECT dept_name, AVG(salary) AS 'avg_sal'
FROM salaries
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
WHERE salaries.to_date > NOW()
GROUP BY dept_name;

-- add column for z-score
ALTER TABLE department_salaries ADD z_score DECIMAL(14,4);

-- create temp table with all current salaries copied from salary table
CREATE TABLE leavitt_1861.current_salaries AS
SELECT salary FROM salaries
WHERE to_date > NOW();

-- Select statement for Mean
(SELECT AVG(salary) FROM current_salaries);

-- Select statement for std deviation
(SELECT STDDEV(salary) FROM current_salaries);

-- populate z_score column of department salaries table
UPDATE department_salaries
SET z_score = (avg_sal - (SELECT AVG(salary) FROM current_salaries))/(SELECT STDDEV(salary) FROM current_salaries);

-- show departments with z_score
select * from department_salaries
ORDER BY z_score DESC;






--     In terms of salary, what is the best department right now to work for? 
	-- Sales
--     The worst?
	-- Human Reasources


-- BONUS To your work with current salary zscores, determine the overall historic average departement average salary,
-- the historic overall average, and the historic zscores for salary. 
-- Do the zscores for current department average salaries tell a similar or a different story 
-- than the historic department salary zscores?

