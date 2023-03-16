# Lab | SQL Joins on multiple tables
USE sakila;

# 1. Write a query to display for each store its store ID, city, and country. (store, address, city, country)

SELECT store_id, city, country
FROM store
LEFT JOIN address
ON store.address_id = address.address_id
LEFT JOIN city
ON address.city_id = city.city_id
LEFT JOIN country
ON city.country_id = country.country_id;

# 2. Write a query to display how much business, in dollars, each store brought in. (store, payment)
SELECT *
FROM payment;

SELECT store.store_id, CONCAT(ROUND(SUM(amount),1), "$") AS amount_in_dollar
FROM store
LEFT JOIN staff
ON store.store_id = staff.store_id
LEFT JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY store_id;

# 3. What is the average running time of films by category?
SELECT name, CONCAT (ROUND(AVG(length)), " minutes") AS average_length
FROM film
LEFT JOIN film_category
ON film.film_id = film_category.film_id
LEFT JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name;

# 4. Which film categories are longest? - do you want the longest average? or longest movie?
SELECT name, CONCAT (ROUND(AVG(length)), " minutes") AS average_length
FROM film
LEFT JOIN film_category
ON film.film_id = film_category.film_id
LEFT JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY average_length DESC
LIMIT 3; #TOP 3

# 5. Display the most frequently rented movies in descending order. (rental inventory film)
SELECT film.film_id, title, COUNT(rental_id) AS rental_freq
FROM film 
LEFT JOIN inventory
ON film.film_id = inventory.film_id
LEFT JOIN rental
ON inventory.inventory_id = rental.inventory_id
GROUP BY film_id
ORDER BY rental_freq DESC;

# 6. List the top five genres (categories??) in gross revenue in descending order.
SELECT category.name, CONCAT(ROUND(SUM(payment.amount)), " $") AS gross_revenue
FROM category
LEFT JOIN film_category
ON category.category_id = film_category.category_id
LEFT JOIN inventory
ON film_category.film_id = inventory.film_id
LEFT JOIN rental
ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment
ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY gross_revenue DESC
LIMIT 5;

# 7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT title, store.store_id
FROM film
LEFT JOIN inventory
ON film.film_id = inventory.film_id
LEFT JOIN store
ON inventory.store_id = store.store_id
WHERE title = "Academy Dinosaur" AND store.store_id = 1;
# The answer is , yes, it is available