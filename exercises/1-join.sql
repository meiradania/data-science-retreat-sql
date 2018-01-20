-- Join Exercises

-- 1) List all film titles with their actors’ names.
SELECT
  film.title,
  actor.first_name,
  actor.last_name
FROM film
  JOIN film_actor ON film.film_id = film_actor.film_id
  JOIN actor ON film_actor.actor_id = actor.actor_id
ORDER BY 1;

-- 2) List titles of films that are not in the inventory.
SELECT film.title
FROM
  film
  LEFT JOIN
  inventory ON inventory.film_id = film.film_id
WHERE
  inventory.film_id IS NULL;

-- 3) List distinct titles of all films returned on 2005-05-27
SELECT DISTINCT film.title
FROM
  film
  JOIN inventory ON inventory.film_id = film.film_id
  JOIN rental ON rental.inventory_id = inventory.inventory_id
                 AND CAST(return_date AS DATE) = '2005-05-27';







