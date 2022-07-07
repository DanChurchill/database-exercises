USE join_example_db;

-- Use the join_example_db. Select all the records from both the users and roles tables.
SELECT * FROM users;
SELECT * FROM roles;

-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
	-- INNER JOIN
SELECT users.name AS 'name', roles.name AS 'role'
FROM users
JOIN roles ON users.role_id = roles.id;

	-- LEFT JOIN
SELECT users.name AS 'name', roles.name AS 'role'
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT users.name AS 'name', roles.name AS 'role'
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

-- Before you run each query, guess the expected number of results.

-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
-- Use count and the appropriate join type to get a list of roles along with the number of users that has the role. 
-- Hint: You will also need to use group by in the query.
SELECT roles.name AS 'Role', COUNT(*) AS 'Count'
FROM roles
JOIN users ON roles.id = users.role_id
GROUP BY roles.name;

-- Use the employees database.
USE employees;

-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department
-- along with the name of the current manager for that department.
SELECT D.dept_name AS 'Department Name', CONCAT(E.first_name, " ", E.last_name) AS 'Department Manager'
FROM departments AS D
JOIN dept_manager AS DM
ON D.dept_no = DM.dept_no
JOIN employees AS E
ON DM.emp_no = E.emp_no
WHERE DM.to_date > NOW();

-- Find the name of all departments currently managed by women.
SELECT D.dept_name AS 'Department Name', CONCAT(E.first_name, " ", E.last_name) AS 'Department Manager'
FROM departments AS D
JOIN dept_manager AS DM
ON D.dept_no = DM.dept_no
JOIN employees AS E
ON DM.emp_no = E.emp_no
WHERE DM.to_date > NOW() AND E.gender = 'F';


-- Find the current titles of employees currently working in the Customer Service department.
SELECT T.title as 'Title', COUNT(*) 
FROM titles as T
JOIN dept_emp as DE
ON T.emp_no = DE.emp_no
JOIN departments AS D
ON DE.dept_no = D.dept_no
WHERE T.to_date > NOW() AND D.dept_name = 'Customer Service'
GROUP BY T.title;


-- Find the current salary of all current managers.
SELECT D.dept_name AS 'Department Name', CONCAT(E.first_name, " ", E.last_name) AS 'Name', S.salary AS 'Salary'
FROM departments AS D
JOIN dept_manager AS DM
ON D.dept_no = DM.dept_no
JOIN employees AS E
ON DM.emp_no = E.emp_no
JOIN salaries AS S
ON E.emp_no = S.emp_no
WHERE DM.to_date > NOW() and S.to_date > NOW();


-- Find the number of current employees in each department.
SELECT D.dept_no, D.dept_name, COUNT(*) AS 'num_employees'
FROM departments AS D
JOIN dept_emp AS DE
ON D.dept_no = DE.dept_no
WHERE DE.to_date > NOW()
GROUP BY D.dept_no
ORDER BY D.dept_no;

-- Which department has the highest average salary? Hint: Use current not historic information.
SELECT D.dept_name AS 'Department', AVG(S.salary) AS Average_Salary
FROM departments AS D
JOIN dept_emp as DE
ON D.dept_no = DE.dept_no
JOIN salaries AS S
ON DE.emp_no = S.emp_no
WHERE S.to_date > NOW()
GROUP BY D.Dept_no
ORDER BY Average_Salary DESC
LIMIT 1;

-- Who is the highest paid employee in the Marketing department?
SELECT CONCAT(E.first_name, ' ', E.last_name) AS 'Full Name'
FROM employees AS E
JOIN salaries AS S
ON E.emp_no = S.emp_no
JOIN dept_emp AS DE
ON E.emp_no = DE.emp_no
JOIN departments AS D
ON DE.dept_no = D.dept_no
WHERE S.to_date > NOW() and D.dept_name = 'Marketing'
ORDER BY S.salary DESC
LIMIT 1;


-- Which current department manager has the highest salary?
SELECT CONCAT(E.first_name, ' ', E.last_name) AS 'Full Name', S.salary AS 'salary', D.dept_name AS 'Department Name'
FROM departments AS D
JOIN dept_manager as DM
ON D.dept_no = DM.dept_no
JOIN employees AS E
ON DM.emp_no = E.emp_no
JOIN salaries as S
ON E.emp_no = S.emp_no
WHERE DM.to_date > NOW() AND S.to_date > NOW()
ORDER BY S.salary DESC
LIMIT 1;

-- Determine the average salary for each department. Use all salary information and round your results.
SELECT D.dept_name as 'Department Name', ROUND(AVG(S.salary),0) AS Average_Salary
FROM departments AS D
JOIN dept_emp as DE
ON D.dept_no = DE.dept_no
JOIN salaries as S
ON DE.emp_no = S.emp_no
GROUP BY D.dept_name
ORDER BY Average_Salary DESC;


-- Bonus Find the names of all current employees, their department name, and their current manager's name.
-- 240,124 Rows
SELECT CONCAT(E.first_name, ' ', E.last_name) AS 'Full Name',
	D.dept_name AS 'Department Name',
	CONCAT(M.first_name, ' ', M.last_name) AS 'Manager Name'
FROM employees AS E
JOIN dept_emp as DE
ON E.emp_no = DE.emp_no
JOIN departments AS D
ON DE.dept_no = D.dept_no
JOIN dept_manager AS DM
ON D.dept_no = DM.dept_no
JOIN employees AS M
ON M.emp_no = DM.emp_no
WHERE DE.to_date > NOW() AND DM.to_date > NOW();


-- Bonus Who is the highest paid employee within each department.
SELECT A.department, A.Salary,
	CONCAT(E.first_name, ' ', E.last_name) AS 'Full Name'
FROM 
(SELECT D.dept_name AS Department
	, MAX(S.salary) AS Salary
FROM departments AS D
JOIN dept_emp AS DE
ON D.dept_no = DE.dept_no
JOIN salaries AS S
ON DE.emp_no = S.emp_no
WHERE (DE.to_date > NOW() AND S.to_date > NOW())
GROUP BY Department) AS A
JOIN salaries
ON A.salary = salaries.salary
JOIN employees AS E
ON salaries.emp_no = E.emp_no
ORDER BY department
;

