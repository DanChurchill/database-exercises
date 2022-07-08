-- Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria:
USE employees;

-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT * FROM employees
WHERE hire_date = (SELECT hire_date FROM employees WHERE emp_no = '101010');


-- 2. Find all the titles ever held by all current employees with the first name Aamod.
SELECT * FROM titles WHERE emp_no IN (SELECT emp_no FROM employees WHERE first_name = 'Aamod');


-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
SELECT * FROM employees WHERE emp_no NOT IN (SELECT emp_no FROM salaries WHERE to_date > NOW());
		-- 59900 employees no longer working for the company

-- 4. Find all the current department managers that are female. List their names in a comment in your code.
SELECT * FROM employees WHERE emp_no IN (SELECT emp_no FROM dept_manager WHERE to_date > NOW()) 
	AND gender = 'F';
		-- Isamu Legieitner, Karsten Sigstam, Leon DasSarma, Hilary Kambii

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT * FROM employees WHERE emp_no IN(
	SELECT emp_no FROM salaries WHERE salary > (SELECT AVG(salary) FROM salaries) AND to_date > NOW());
		-- 154543 employees returned

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? 
-- (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

	-- get current salaries:  240,124
SELECT salary FROM salaries WHERE to_date > NOW();

	-- get Mean salary: 72,012.2359
SELECT AVG(salary) FROM salaries WHERE to_date > NOW();

	-- get Standard deviatioin:  17309.95...
SELECT STDDEV(salary) FROM salaries WHERE to_date > NOW();

	-- get salaries +/- one std deviation from mean (should be ~68% of 240,124, or ~163,284)
SELECT salary FROM salaries 
WHERE (to_date > NOW())
	AND salary BETWEEN (SELECT AVG(salary) FROM salaries WHERE to_date > NOW()) - (SELECT STDDEV(salary) FROM salaries WHERE to_date > NOW())
	AND (SELECT AVG(salary) FROM salaries WHERE to_date > NOW()) + (SELECT STDDEV(salary) FROM salaries WHERE to_date > NOW())
ORDER BY salary;
				-- returned 161,846 salaries ranging from 54,703 to 89,322


-- BONUS
-- 1. Find all the department names that currently have female managers.

-- 2. Find the first and last name of the employee with the highest salary.

-- 3. Find the department name that the employee with the highest salary works in.