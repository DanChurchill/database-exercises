-- #3 use the employees database
USE employees;

-- #4 list all tables in database
SHOW tables;

-- #5 explore datatypes in employees table
DESCRIBE employees;

-- #6 Which table(s) do you think contain a numeric type column? 
-- 		dept_emp, dept_manager, employees, salaries, titles

-- #7 Which table(s) do you think contain a string type column?
--  	departments, dept_emp, dept_manager, employees, titles

-- #8 Which table(s) do you think contain a date type column?
-- 		dept_emp, dept_manager, employees, salaries, titles

-- #9 What is the relationship between the employees and the departments tables?
-- 		There is no direct relationship as they share no common fields/keys.  They would have to be related to each other through another table

-- #10 Show the SQL that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.
SHOW CREATE TABLE dept_manager;