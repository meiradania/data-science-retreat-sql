-- Aggregate Exercises

-- 1) customers ordered by how much they've spent
SELECT
  customer.first_name,
  customer.last_name,
  SUM(amount)
FROM payment
  JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY 1, 2
ORDER BY 3 DESC;

-- 2) customers who have spent more than 200
SELECT
  customer.first_name,
  customer.last_name,
  SUM(amount)
FROM payment
  JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY 1,2
HAVING SUM(amount) > 200;

-- using WITH
WITH customer_totals AS (
    SELECT
      customer_id,
      SUM(amount) AS total
    FROM payment
    GROUP BY customer_id
)
SELECT
  customer.first_name,
  customer.last_name,
  total
FROM customer_totals
  JOIN customer ON customer_totals.customer_id = customer.customer_id
WHERE total > 200
ORDER BY total DESC;

-- 3) stores with more than 200 customers
SELECT
  store_id,
  COUNT(customer_id)
FROM customer
GROUP BY 1
HAVING COUNT(customer_id) > 200;

-- 4) the number of rentals from each category
SELECT
  category.name,
  count(*)
FROM rental
  JOIN inventory ON rental.inventory_id = inventory.inventory_id
  JOIN film_category ON inventory.film_id = film_category.film_id
  JOIN film ON inventory.film_id = film.film_id
  JOIN category ON film_category.category_id = category.category_id
GROUP BY 1
ORDER BY 2 DESC;

-- EXTRA: films whose rental_rate is higher than the average rental_rate
SELECT
  film_id,
  title,
  rental_rate
FROM
  film
WHERE
  rental_rate > (SELECT AVG(rental_rate)
                 FROM film);

