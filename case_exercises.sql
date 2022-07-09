-- Create a file named case_exercises.sql and craft queries to return the results for the following criteria:
USE employees;

-- 1. Write a query that returns all employees, their department number, their start date, 
--    their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
SELECT *, 
	CASE
		WHEN  to_date > NOW() THEN TRUE
		ELSE FALSE
	END AS is_active
FROM dept_emp;

-- 2. Write a query that returns all employee names (previous and current), 
--    and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
SELECT first_name, last_name,
	CASE
		WHEN last_name < 'I' THEN 'A-H'
        WHEN last_name < 'R' THEN 'I-Q'
        ELSE 'R-Z'
	END AS alpha_group
FROM employees;
    
-- 3.  How many employees (current or previous) were born in each decade?
SELECT *,
	CASE 
		WHEN birth_date < '1930-01-01' THEN 'Geezer'
        WHEN birth_date < '1940-01-01' THEN '1930s'
        WHEN birth_date < '1950-01-01' THEN '1940s'
        WHEN birth_date < '1960-01-01' THEN '1950s'
        WHEN birth_date < '1970-01-01' THEN '1960s'
		WHEN birth_date < '1980-01-01' THEN '1970s'
        ELSE 'Baby'
	END AS decade
FROM employees;


-- 4.  What is the current average salary for each of the following department groups:
--     R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT ROUND(AVG(salary),2),
	CASE 
		WHEN dept_name IN ('Research' ,'Development') THEN 'R&D'
        WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
        WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
        WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
        ELSE 'Customer Service'
	END AS dept_group
FROM departments
JOIN dept_emp USING(dept_no)
JOIN salaries USING(emp_no) WHERE salaries.to_date > NOW()
GROUP BY dept_group;













