-- Window Exercises

-- 1) Find the most recent returned film title - show customer name and return date
WITH transactions AS (
    SELECT
      film.title,
      rental.return_date,
      customer.first_name,
      customer.last_name,
      DENSE_RANK()
      OVER (
        ORDER BY rental.return_date DESC )
        AS rental_rank
    FROM rental
      JOIN customer ON rental.customer_id = customer.customer_id
      JOIN inventory ON rental.inventory_id = inventory.inventory_id
      JOIN film ON inventory.film_id = film.film_id
    WHERE rental.return_date IS NOT NULL
    LIMIT 1

)
SELECT *
FROM transactions
WHERE rental_rank = 1;

-- 2) Find the 10% most profitable customers (top 10%)
WITH customer_totals AS (
    SELECT
      customer.first_name,
      customer.last_name,
      sum(payment.amount)                   AS total_amount,
      NTILE(10)
      OVER (
        ORDER BY sum(payment.amount) DESC ) AS decile
    FROM
      payment
      JOIN customer ON payment.customer_id = customer.customer_id
    GROUP BY 1, 2
    ORDER BY 3 DESC
)
SELECT *
FROM customer_totals
WHERE decile <= 5;

-- 3) Find the most rented film in each category.
WITH category_rank AS (
    SELECT
      category.name           AS category,
      film.title,
      DENSE_RANK()
      OVER (
        PARTITION BY category.name
        ORDER BY count(rental.rental_id) DESC )
                              AS rank_in_category,
      count(rental.rental_id) AS number_of_rentals
    FROM rental
      JOIN inventory ON rental.inventory_id = inventory.inventory_id
      JOIN film_category ON inventory.film_id = film_category.film_id
      JOIN category ON film_category.category_id = category.category_id
      JOIN film ON inventory.film_id = film.film_id
    GROUP BY 1, 2
)
SELECT *
FROM category_rank
WHERE rank_in_category = 1
ORDER BY
  category,
  number_of_rentals DESC;
