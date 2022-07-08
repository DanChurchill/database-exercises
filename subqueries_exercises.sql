-- Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria:
USE employees;

-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT * FROM employees
WHERE hire_date = (SELECT hire_date FROM employees WHERE emp_no = '101010') AND
	emp_no IN (SELECT emp_no FROM salaries WHERE to_date > NOW());
		-- 55 rows returned

-- 2. Find all the titles ever held by all current employees with the first name Aamod.
SELECT title FROM titles WHERE emp_no IN (SELECT emp_no FROM employees WHERE first_name = 'Aamod') AND
	emp_no IN (SELECT emp_no FROM salaries WHERE to_date > NOW())
GROUP BY title;
		-- 6 rows returned


-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
SELECT * FROM employees WHERE emp_no NOT IN (SELECT emp_no FROM salaries WHERE to_date > NOW());
		-- 59900 employees no longer working for the company

-- 4. Find all the current department managers that are female. List their names in a comment in your code.
SELECT * FROM employees WHERE emp_no IN (SELECT emp_no FROM dept_manager WHERE to_date > NOW()) 
	AND gender = 'F';
		-- Isamu Legieitner, Karsten Sigstam, Leon DasSarma, Hilary Kambii

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT * FROM employees WHERE emp_no IN(
	SELECT emp_no FROM salaries 
    WHERE salary > (SELECT AVG(salary) FROM salaries) AND to_date > NOW());
		-- 154543 employees returned

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? 
-- (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

	-- get current salaries:  240,124
SELECT salary FROM salaries WHERE to_date > NOW();

	-- get MAX current salary: 158,220
SELECT MAX(salary) FROM salaries WHERE to_date > NOW();

	-- get Standard deviatioin:  17309.95...
SELECT STDDEV(salary) FROM salaries WHERE to_date > NOW();

	-- get salaries between MAX minus  one std deviation from max
SELECT salary FROM salaries 
WHERE (to_date > NOW())
	AND salary BETWEEN (SELECT MAX(salary) FROM salaries WHERE to_date > NOW()) - (SELECT STDDEV(salary) FROM salaries WHERE to_date > NOW())
    AND (SELECT MAX(salary) FROM salaries WHERE to_date > NOW())
ORDER BY salary;
				-- returned 83 salaries ranging from 140,974 and 158,220
                -- .0345%


-- BONUS
-- 1. Find all the department names that currently have female managers.

SELECT dept_name FROM departments AS D
JOIN dept_manager AS DM ON D.dept_no = DM.dept_no
JOIN employees AS E ON DM.emp_no = E.emp_no
WHERE E.emp_no IN (SELECT emp_no FROM employees WHERE emp_no IN (SELECT emp_no FROM dept_manager WHERE to_date > NOW()) 
	AND gender = 'F')
;

-- 2. Find the first and last name of the employee with the highest salary.
SELECT first_name, last_name FROM employees WHERE emp_no = (
	SELECT emp_no FROM salaries WHERE to_date > NOW() ORDER BY salary DESC LIMIT 1
	);
		-- Tokuyasu Pesch

-- 3. Find the department name that the employee with the highest salary works in.
SELECT dept_name FROM departments AS D
JOIN dept_emp AS DE ON D.dept_no = DE.dept_no
WHERE DE.emp_no = (
	SELECT emp_no FROM salaries WHERE to_date > NOW() ORDER BY salary DESC LIMIT 1);
		-- Sales
