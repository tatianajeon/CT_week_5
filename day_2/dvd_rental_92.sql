-- Hello World Query, SELECT ALL records from actor table
SELECT *
FROM actor;

-- Query for first and last names in actor table
SELECT first_name, last_name
FROM actor;

-- Query for first_names that equal "Nick" using WHERE clause
SELECT first_name, last_name
FROM actor
WHERE first_name = 'Nick';

-- Query for same 👆🏾 using 'LIKE'
SELECT first_name, last_name
FROM actor
WHERE first_name LIKE 'Nick';

-- Query for first names that start with J using LIKE, WHERE, and % (wildcard)
SELECT first_name, last_name
FROM actor
WHERE first_name LIKE 'J%';

-- Query for first_names starting with K and having 2 more letters 
-- using '_' (underscore)
SELECT last_name, first_name
FROM actor
WHERE first_name LIKE 'K__';

-- Underscore and Wildcard Search
SELECT *
FROM actor
WHERE first_name LIKE 'K__%th';


-- Comparative Operators
-- Greater Than (>) or Less Than (<)
-- Greater or Equal (>=) -- Less or Equal (<=)
-- Not Equal(<>)

-- Explore the Payment table
SELECT *
FROM payment;

-- Show all customers who paid
-- an amount greater than $2
SELECT customer_id, amount
FROM payment
WHERE amount > 2.00;

-- query for data showing who paid less than or equal to $7.99
SELECT customer_id, amount
FROM payment
WHERE amount <= 7.99
ORDER BY amount DESC;

-- QUERY for data showing customers who paid amounts BETWEEN $3 AND $5
SELECT *
FROM payment
WHERE amount BETWEEN 3.00 AND 5.00;


-- SQL AGREGATE FUNCTIONS => SUM(), AVG(), COUNT(), MIN(), MAX()

-- Sum of amounts paid greater than 5.99
SELECT SUM(amount)
FROM payment
WHERE amount > 5.99;

-- Averages of the same 👆🏾
SELECT ROUND(AVG(amount))
FROM payment
WHERE amount > 5.99;

-- COUNT AMOUNTS greater than 5.99
SELECT COUNT(DISTINCT amount)
FROM payment
WHERE amount > 5.99;

-- USE AS KEYWORD TO NAME COLUMN
SELECT MIN(amount) AS lowest_payment
FROM payment;

-- When using Agregate you must group other columns together with GROUP BY

-- query displaying different amounts grouped together
SELECT amount, COUNT(amount)
FROM payment
GROUP BY amount
ORDER BY amount;

-- query displaying amounts grouped by customer_id
SELECT customer_id, SUM(amount) AS total
FROM payment
GROUP BY customer_id
ORDER BY total DESC;

-- HAVING can be used to filter by agregate
SELECT customer_id, SUM(amount) AS total
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 200.00
ORDER BY total DESC;

-- What Film does the store have the most of
SELECT film_id, COUNT(film_id)
FROM inventory
GROUP BY film_id
ORDER BY COUNT(film_id) DESC;