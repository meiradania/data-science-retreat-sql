-- Join Exercises

-- 1) List all film titles with their actors’ names.
SELECT
f.film_id,
  f.title as film_title,
  actor.first_name,
  actor.actor_id,
  actor.last_name
FROM film as f
  JOIN film_actor ON f.film_id = film_actor.film_id
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
  public.film
  JOIN inventory
    ON inventory.film_id = film.film_id
  JOIN rental
      ON rental.inventory_id = inventory.inventory_id
  --    AND DATE_TRUNC('day',return_date) = '2005-05-27';
  and date(return_date)  = '2005-05-27'

select return_date, DATE_TRUNC('hour',return_date), DATE_PART('hour',return_date)
  from rental


select 'abc' like '__c'



SELECT DISTINCT film.title
FROM
  film
  JOIN inventory
    ON inventory.film_id = film.film_id
  JOIN rental
      ON rental.inventory_id = inventory.inventory_id
WHERE return_date BETWEEN '2005-05-27 00:00:00'
AND '2005-05-28 00:00:00';












