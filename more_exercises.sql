-- More Drills With The Sakila Database
USE sakila;
-- SELECT statements

-- Select all columns from the actor table.
SELECT * FROM actor;

-- Select only the last_name column from the actor table.
SELECT last_name FROM actor;

-- Select only the film_id, title, and release_year columns from the film table.
SELECT film_id, title, release_year FROM film;

-- DISTINCT operator
-- Select all distinct (different) last names from the actor table.
SELECT DISTINCT last_name FROM actor;

-- Select all distinct (different) ratings from the film table.
SELECT DISTINCT rating FROM film;

-- WHERE clause
-- Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date >= '2005-05-27';

-- Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date LIKE '2005-05-27%';

-- Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
SELECT * FROM customer WHERE last_name LIKE 'S%' AND first_name LIKE '%N';

-- Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
SELECT * FROM customer WHERE ACTIVE = FALSE OR last_name LIKE 'M%';

-- Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
SELECT * FROM category WHERE category_id > 4 AND (name LIKE 'C%' OR name LIKE 'S%' or name LIKE 'T%');

-- Select all columns minus the password column from the staff table for rows that contain a password.
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update
FROM staff 
WHERE password IS NOT NULL;

-- Select all columns minus the password column from the staff table for rows that do not contain a password.
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update
FROM staff 
WHERE password IS NULL;


-- IN operator
-- Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
SELECT phone, district FROM address WHERE district IN ('California', 'England', 'Taipei', 'West Java');

-- Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. 
-- (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
SELECT payment_id, amount, payment_date FROM payment WHERE DATE(payment_date) IN ('2005-05-25', '2005-05-27', '2005-05-29');

-- Select all columns from the film table for films rated G, PG-13 or NC-17.
SELECT * FROM film WHERE rating IN ('G', 'PG-13', 'NC-17');


-- BETWEEN operator
-- Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
SELECT * FROM payment WHERE payment_date BETWEEN '2005-05-26 00:00:00' AND '2005-05-26 23:59:59';

-- Select the film_id, title, and descrition columns from the film table for films where the length of the description is between 100 and 120.
SELECT film_id, title, description FROM film WHERE length(description) BETWEEN 100 AND 120;


-- LIKE operator
-- Select the following columns from the film table for rows where the description begins with "A Thoughtful".
SELECT * FROM film WHERE description LIKE 'A Thoughtful%';

-- Select the following columns from the film table for rows where the description ends with the word "Boat".
SELECT * FROM film WHERE description LIKE '%Boat';

-- Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.
SELECT * FROM film WHERE description LIKE '%Database%' AND length > 180;


-- LIMIT Operator
-- Select all columns from the payment table and only include the first 20 rows.
SELECT * FROM payment LIMIT 20;

-- Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, 
-- and only select rows whose zero-based index in the result set is between 1000-2000.
SELECT payment_date, amount 
FROM payment
WHERE amount > 5
LIMIT 1001 OFFSET 999;

-- Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.
SELECT * FROM customer 
LIMIT 100 OFFSET 100;

-- ORDER BY statement
-- Select all columns from the film table and order rows by the length field in ascending order.
SELECT * FROM film ORDER BY length;

-- Select all distinct ratings from the film table ordered by rating in descending order.
SELECT DISTINCT rating FROM film ORDER BY rating DESC;

-- Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.
SELECT payment_date, amount
FROM payment
ORDER BY amount DESC
LIMIT 20;

-- Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films 
-- with behind the scenes footage under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.
SELECT title, description, special_features, length, rental_duration
FROM film
WHERE special_features LIKE '%Behind the Scenes%' 
	AND length < 120 
    AND rental_duration BETWEEN 5 AND 7
ORDER BY length DESC
LIMIT 10;

-- JOINs
-- Select customer first_name/last_name and actor first_name/last_name columns from performing
-- a left join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
-- Label customer first_name/last_name columns as customer_first_name/customer_last_name
-- Label actor first_name/last_name columns in a similar fashion.
-- returns correct number of records: 620
SELECT c.first_name AS customer_first_name, c.last_name AS customer_last_name, a.first_name AS actor_first_name, a.last_name AS actor_last_name
FROM customer AS c
LEFT JOIN actor AS a
USING (last_name);

-- Select the customer first_name/last_name and actor first_name/last_name columns from performing 
-- a /right join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
-- returns correct number of records: 200
SELECT c.first_name AS customer_first_name, c.last_name AS customer_last_name, a.first_name AS actor_first_name, a.last_name AS actor_last_name
FROM customer AS c
RIGHT JOIN actor AS a
USING (last_name);

-- Select the customer first_name/last_name and actor first_name/last_name columns from performing an inner join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
-- returns correct number of records: 43
SELECT c.first_name AS customer_first_name, c.last_name AS customer_last_name, a.first_name AS actor_first_name, a.last_name AS actor_last_name
FROM customer AS c
JOIN actor AS a
USING (last_name);

-- Select the city name and country name columns from the city table, performing a left join with the country table to get the country name column.
-- Returns correct records: 600
SELECT city.city, country.country
FROM city
LEFT JOIN country
USING(country_id);

-- Select the title, description, release year, and language name columns from the film table, performing a left join with the language table to get the "language" column.
-- Label the language.name column as "language"
-- Returns 1000 rows
SELECT f.title, f.description, f.release_year, l.name AS 'language'
FROM film AS f
LEFT JOIN language as l
USING(language_id);

-- Select the first_name, last_name, address, address2, city name, district, and postal code columns from the staff table, 
-- performing 2 left joins with the address table then the city table to get the address and city related columns.
-- returns correct number of rows: 2
SELECT s.first_name, s.last_name, a.address, a.address2, c.city, a.district, a.postal_code
FROM staff AS s
LEFT JOIN address AS a
USING(address_id)
LEFT JOIN city as c
USING(city_id);

-- Display the first and last names in all lowercase of all the actors.
SELECT LOWER(first_name), LOWER (last_name) FROM actor;

-- You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
-- What is one query would you could use to obtain this information?
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'Joe';

-- Find all actors whose last name contain the letters "gen":
SELECT actor_id, first_name, last_name FROM actor WHERE last_name LIKE '%gen%';

-- Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.
SELECT actor_id, first_name, last_name FROM actor WHERE last_name LIKE '%li%'
ORDER BY last_name, first_name;

-- Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- List the last names of all the actors, as well as how many actors have that last name.
SELECT last_name, COUNT(last_name) 
FROM actor
GROUP BY last_name;

-- List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT last_name, COUNT(last_name) AS count
FROM actor
GROUP BY last_name
HAVING count(last_name) > 1;

-- You cannot locate the schema of the address table. Which query would you use to re-create it?
DESCRIBE address;

-- Use JOIN to display the first and last names, as well as the address, of each staff member.
SELECT s.first_name, s.last_name, a.address
FROM staff as s
JOIN address as a
USING(address_id);

-- Use JOIN to display the total amount rung up by each staff member in August of 2005.
	SELECT p.staff_id, SUM(p.amount)
	FROM payment as p
	WHERE p.payment_date LIKE '2005-08%'
	GROUP BY p.staff_id;

-- List each film and the number of actors who are listed for that film.
SELECT f.title, COUNT(actor_id)
FROM film_actor AS fa
JOIN film AS f
USING(film_id)
GROUP BY f.title;

-- How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT f.title, COUNT(i.film_id) as Copies
FROM inventory AS i
JOIN film AS f
USING(film_id)
GROUP BY f.title
HAVING f.title = 'Hunchback Impossible';

-- The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, 
-- films starting with the letters K and Q have also soared in popularity. 
-- Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
SELECT title FROM film WHERE language_id = (
	SELECT language_id FROM language WHERE name = 'English'
    )
AND title LIKE 'K%' OR title LIKE 'Q%';
	
-- Use subqueries to display all actors who appear in the film Alone Trip.
SELECT first_name, last_name FROM actor WHERE actor_id IN 
	(SELECT actor_id from film_actor WHERE film_id =
		(SELECT film_id FROM film WHERE title = 'Alone Trip'));
        
-- You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
SELECT c.first_name, c.last_name, c.email FROM customer AS c
JOIN address AS a USING(address_id)
JOIN city USING(city_id)
JOIN country USING(country_id)
WHERE country = 'canada';

-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
SELECT film.title, category.name FROM film
JOIN film_category USING(film_id)
JOIN category USING(category_id)
WHERE category.name LIKE '%family%';

-- Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, SUM(p.amount) FROM store AS s
JOIN staff USING(store_id)
JOIN payment AS p USING(staff_id)
GROUP BY s.store_id;

-- Write a query to display for each store its store ID, city, and country.
SELECT store_id, city.city, country.country FROM store
JOIN address USING(address_id)
JOIN city USING(city_id)
JOIN country USING(country_id);

-- List the top five genres in gross revenue in descending order. 
-- (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
SELECT category.name, SUM(payment.amount) AS gross_revenue FROM category
JOIN film_category USING(category_id)
JOIN inventory USING(film_id)
JOIN rental USING(inventory_id)
JOIN payment USING(rental_id)
GROUP BY category.name
ORDER BY gross_revenue DESC;

-- What is the average replacement cost of a film? 
SELECT AVG(replacement_cost) FROM film;
-- Does this change depending on the rating of the film?
SELECT rating, AVG(replacement_cost) FROM film GROUP BY rating;

-- How many different films of each genre are in the database?
SELECT name, COUNT(film_id) FROM category
JOIN film_category USING(category_id)
JOIN film USING(film_id)
GROUP BY name
ORDER BY name;

-- What are the 5 frequently rented films?
SELECT title, COUNT(rental.inventory_id) AS total FROM film_text
JOIN inventory USING(film_id)
JOIN rental USING(inventory_id)
GROUP BY title
ORDER BY total DESC
LIMIT 5;

-- What are the most most profitable films (in terms of gross revenue)?
SELECT title, SUM(payment.amount) AS total FROM film_text
JOIN inventory USING(film_id)
JOIN rental USING(inventory_id)
JOIN payment USING(rental_id)
GROUP BY title
ORDER BY total DESC
LIMIT 5;

-- Who is the best customer?
SELECT CONCAT(last_name, ', ',first_name) AS name,
	(SELECT SUM(amount) as total FROM payment
	GROUP BY customer_id
	ORDER BY SUM(amount) DESC LIMIT 1) AS total
FROM customer WHERE customer_id = (
	SELECT customer_id FROM payment
	GROUP BY customer_id
	ORDER BY SUM(amount) DESC LIMIT 1
	);

-- Who are the most popular actors (that have appeared in the most films)?
SELECT name, COUNT(film_id) AS total FROM film_actor
JOIN (SELECT actor_id, CONCAT(last_name, ', ',first_name) AS name FROM actor) AS actor_names
USING(actor_id)
GROUP BY actor_id 
ORDER BY total DESC LIMIT 5;

-- What are the sales for each store for each month in 2005?
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month, store_id, SUM(amount) AS sales FROM payment
JOIN staff USING(staff_id)
GROUP BY month, store_id
HAVING month LIKE '2005%'
ORDER BY month;

-- Bonus: Find the film title, customer name, customer phone number, and customer address for all the outstanding DVDs.
SELECT f.title, CONCAT(c.last_name, ', ', c.first_name) AS customer_name, phone
FROM rental AS r
JOIN inventory AS i USING(inventory_id)
JOIN film AS f USING(film_id)
JOIN customer as c USING(customer_id)
JOIN address AS a USING(address_id)
WHERE return_date IS NULL;

-- EMPLOYEES DATABASE
-- How much do the current managers of each department get paid, relative to the average salary for the department? 
-- Is there any department where the department manager gets paid less than the average salary?
USE employees;

SELECT CONCAT(first_name, ' ',last_name) AS Name, dept_name AS Department, Salary, Department_Average, (salary - Department_Average) AS Difference FROM dept_manager
JOIN departments USING(dept_no)
JOIN employees USING(emp_no)
JOIN salaries USING(emp_no)
JOIN (SELECT ROUND(AVG(salary)) as Department_Average, dept_name FROM (
	SELECT salary, emp_no 
    FROM salaries
	WHERE salaries.to_date > NOW()
    ) AS cur_sals
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
GROUP BY dept_name) AS dept_avgs USING(dept_name)
WHERE dept_manager.to_date > NOW()
	AND salaries.to_date > NOW()
ORDER BY difference DESC; 

-- WORLD DATABASE
-- Use the world database for the questions below.
USE world;

-- What languages are spoken in Santa Monica?
SELECT language, percentage FROM countrylanguage
WHERE countrycode IN(
	SELECT countrycode FROM city WHERE name = 'Santa Monica')
ORDER BY percentage;

-- How many different countries are in each region?
SELECT Region, COUNT(code) AS num_countries 
FROM country
GROUP BY Region
ORDER BY num_countries;

-- What is the population for each region?
SELECT Region, SUM(population) AS Population 
FROM country
GROUP BY Region
ORDER BY Population DESC;

-- What is the population for each continent?
SELECT Continent, SUM(population) AS Population 
FROM country
GROUP BY Continent
ORDER BY Population DESC;

-- What is the average life expectancy globally?
SELECT AVG(lifeexpectancy) FROM country;

-- What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
SELECT Region, AVG(lifeexpectancy) as life_expectancy
FROM country
GROUP BY Region
ORDER BY life_expectancy;

SELECT Continent, AVG(lifeexpectancy) as life_expectancy
FROM country
GROUP BY Continent
ORDER BY life_expectancy;

-- Find all the countries whose local name is different from the official name
SELECT localname, Name FROM country WHERE localname != name;

-- Advanced: Pizza Database
-- Use the pizza database to answer the following questions.
USE pizza;

-- What information is stored in the toppings table? How does this table relate to the pizzas table?
		-- toppings table contains a topping ID, the topping name, and topping price.  It relates to the pizzas table via the pizza_toppings table

-- What information is stored in the modifiers table? How does this table relate to the pizzas table?
		-- Modifiers table contains modifier ID, the modifier name, and modifier price.  It relates to the pizza table via the pizza_modifiers table

-- How are the pizzas and sizes tables related?
		-- via the size_id

-- What other tables are in the database?
SHOW TABLES;

-- How many unique toppings are there?
SELECT * FROM toppings; -- 9 toppings

-- How many unique orders are in this dataset?
SELECT DISTINCT order_id FROM pizzas; -- 10000 orders

-- Which size of pizza is sold the most?
SELECT size_name, COUNT(order_id) as ordered
FROM sizes
JOIN pizzas USING(size_id)
GROUP BY size_name
ORDER BY ordered DESC;

-- How many pizzas have been sold in total?
SELECT COUNT(pizza_id) FROM pizzas;    -- 20001

-- What is the most common size of pizza ordered?
SELECT size_name, COUNT(order_id) as ordered
FROM sizes
JOIN pizzas USING(size_id)
GROUP BY size_name
ORDER BY ordered DESC;		-- LARGE

-- What is the average number of pizzas per order?
SELECT  SUM(pizza_id) / SUM(order_id) FROM pizzas;  -- 1.8316 pizzas

-- Find the total price for each order. The total price is the sum of:
-- The price based on pizza size
-- Any modifiers that need to be charged for
-- The sum of the topping prices
-- Topping price is affected by the amount of the topping specified. 
-- A light amount is half of the regular price. An extra amount is 1.5 times the regular price, and double of the topping is double the price.

SELECT order_id, ROUND(SUM(total_price),2) AS Order_Total
FROM pizzas
JOIN (
-- price of each pizza 
		SELECT pizza_id, ROUND(size_price + COALESCE(topping_total,0),2) AS total_price
		FROM (SELECT pizza_id,											-- pizza ID
			SUM(size_price) +               						-- price of size
			COALESCE(SUM(modifier_price),0) as size_price					-- Price of pizza modifiers 
				FROM pizzas
				JOIN sizes USING(size_id)
				LEFT JOIN pizza_modifiers USING(pizza_id)
				LEFT JOIN modifiers USING(modifier_id)
				GROUP BY pizza_id) AS modified_price_table
		LEFT JOIN 
			(SELECT pizza_id, ROUND(SUM( 
			CASE topping_amount
				WHEN 'light' THEN ROUND(topping_price / 2, 2)
				WHEN 'extra' THEN ROUND(topping_price * 1.5, 2)
				WHEN 'double' THEN topping_price * 2
				ELSE topping_price
			END),2) AS topping_total
		FROM pizza_toppings
		JOIN toppings USING(topping_id)
		GROUP BY pizza_id
		ORDER BY pizza_id) AS topping_price_table
		USING(pizza_id)
		ORDER BY pizza_id) AS pizza_price
USING(pizza_id)
GROUP BY order_id
ORDER BY order_id;









