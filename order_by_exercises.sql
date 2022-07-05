-- Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. 
SELECT first_name, last_name FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

-- In your comments, answer: What was the first and last name in the first row of the results? 
	-- Irena Reutenauer
-- What was the first and last name of the last person in the table?
	-- Vidya Simmen
    
-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name.
 SELECT first_name, last_name FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;

-- In your comments, answer: What was the first and last name in the first row of the results? 
	-- Irena Acton
-- What was the first and last name of the last person in the table?
	-- Vidya Zweizig
    
-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. 
SELECT first_name, last_name FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

-- In your comments, answer: What was the first and last name in the first row of the results?
	-- Irena Acton
-- What was the first and last name of the last person in the table?
	-- Maya Zyda
    
-- Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. 
SELECT * FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
ORDER BY emp_no;

-- Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
	-- 899 returned, 10021 Ramzi Erde, 499648 Tadahiro Erde
    
-- Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. 
SELECT * FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
ORDER BY hire_date DESC;

-- Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.
	-- 899 returned, Teiji Eldridge,  Sergi Erde
    
-- Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. 
SELECT * FROM employees
WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') AND birth_date LIKE '%-12-25'
ORDER BY birth_date, hire_date desc;

-- Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.
	-- 362 records returned, Khun Bernini, Douadi Pettis