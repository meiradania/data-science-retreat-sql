-- Aggregate Exercises

-- 1) customers ordered by how much they've spent
SELECT
  customer.first_name,
  customer.last_name,
  SUM(amount) as total_payment_amount
FROM payment
  JOIN customer
    ON payment.customer_id = customer.customer_id
GROUP BY 1, 2
ORDER BY total_payment_amount DESC;






-- 2) customers who have spent more than $200
SELECT
  customer.first_name,
  customer.last_name,
  SUM(amount)
FROM payment
  JOIN customer
  ON payment.customer_id = customer.customer_id
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
  JOIN customer
  ON customer_totals.customer_id = customer.customer_id
WHERE total > 200
ORDER BY total DESC;







-- 3) the number of rentals from each category
SELECT
  category.name,
  count(rental.rental_id)
FROM rental
  JOIN inventory ON rental.inventory_id = inventory.inventory_id
  JOIN film_category ON inventory.film_id = film_category.film_id
  JOIN category ON film_category.category_id = category.category_id
GROUP BY 1
ORDER BY 2 DESC;

-- 4) the number of rentals from each film and category combination
SELECT
  film.title,
  category.name,
  count(rental.rental_id)
FROM rental
  JOIN inventory ON rental.inventory_id = inventory.inventory_id
  JOIN film_category ON inventory.film_id = film_category.film_id
  JOIN category ON film_category.category_id = category.category_id
  JOIN film ON inventory.film_id = film.film_id
GROUP BY 1, 2
ORDER BY 3 DESC;

-- EXTRA: films whose rental_rate is higher than the average rental_rate between all films in the DB
SELECT
  film_id,
  title,
  rental_rate
FROM
  film
WHERE
  rental_rate >
  (
    SELECT AVG(rental_rate)
    FROM film
  );





with average as (
  select
    avg(rental_rate) as average_rental_rate
  from film
)
select distinct
  film.title,
  film.rental_rate,
  average_rental_rate
from
  film
join average
on film.rental_rate > average.average_rental_rate
order by 2 desc;

