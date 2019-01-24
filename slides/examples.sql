--SQL Basics 21/21: List all films with their title, rating and length
SELECT
  title,
  rating,
  length
FROM
  film









  ;

--- WITH example (SQL Operations 9/9): List all rented movies titles with the customer names
WITH rentals AS (
    SELECT
      c.first_name,
      c.last_name,
      r.rental_id,
      i.film_id
    FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
)
SELECT
  f.title,
  r.first_name,
  r.last_name
FROM film f
JOIN rentals r ON f.film_id = r.film_id
ORDER BY title;

-- WINDOW example (SQL Functions 9/13)
with tb as (
SELECT
  payment.customer_id,
  customer.first_name,
  customer.last_name,
  payment_date,
  row_number()
  OVER (
    ORDER BY payment_date DESC ),
  rank()
  OVER (
    ORDER BY payment_date DESC ),
  dense_rank()
  OVER (
    ORDER BY payment_date DESC ),
    NTILE(10) OVER (
    ORDER BY payment_date DESC ) decile
FROM
  payment
  JOIN customer ON payment.customer_id = customer.customer_id
ORDER BY payment_date DESC
)
select count(*), decile
from tb
group by decile

-- DATE function example (SQL Functions 10/13)
SELECT
  DATE_PART('year', rental_date) year_of_rental,
  COUNT(customer_id) customers
FROM rental
GROUP BY 1;



