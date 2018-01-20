-- List all films with their title and language
SELECT
  film.title,
  language.name
FROM
  film
  JOIN language
    ON film.language_id = language.language_id;

--- List all rented movies titles with the customer names
WITH rentals AS (
    SELECT
      c.first_name,
      c.last_name,
      r.rental_id,
      i.film_id
    FROM customer c, rental r, inventory i
    WHERE c.customer_id = r.customer_id
          AND r.inventory_id = i.inventory_id
)
SELECT
  f.title,
  r.first_name,
  r.last_name
FROM film f, rentals r
WHERE f.film_id = r.film_id
ORDER BY title;

-- the above query with joins
SELECT
  f.title,
  c.first_name,
  c.last_name
FROM customer c, rental r, inventory i, film f
WHERE c.customer_id = r.customer_id
      AND r.inventory_id = i.inventory_id
      AND i.film_id = f.film_id
ORDER BY title;

-- window example
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
    ORDER BY payment_date DESC )
FROM
  payment
  JOIN customer ON payment.customer_id = customer.customer_id
ORDER BY payment_date DESC;
