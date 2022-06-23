-- WEEK 5 Wednesday Questions
-- Tatiana Jeon

-- 1. List all customers who live in TX (use JOINs)
SELECT first_name, last_name, district 
FROM customer 
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';


-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT first_name, last_name, amount
FROM customer
INNER JOIN payment
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99;

-- 3. Show all customers names who have made payments over $175 (use subqueries)
SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175.00;

SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175.00
);

-- 4. List all customers that live in Nepal (use the city table)
SELECT first_name, last_name, country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';


-- 5. Which staff member had the most transactions?
SELECT first_name, last_name, staff.staff_id, COUNT(payment_id)
FROM staff
INNER JOIN payment
ON payment.staff_id = staff.staff_id
GROUP BY first_name, last_name, staff.staff_id
ORDER BY COUNT(payment_id) DESC
FETCH FIRST ROW ONLY;


-- 6. How many movies of each rating are there?
SELECT COUNT(title), rating
FROM film
GROUP BY DISTINCT rating;


-- 7. Show all customers who have made a single payment above $6.99 (use subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    WHERE amount > 6.99
    GROUP BY customer_id
    HAVING COUNT(amount) = 1
);


-- 8. How many free rentals did our stores give away?
SELECT COUNT(rental_id), amount
FROM payment
WHERE amount = 0
GROUP BY amount;

