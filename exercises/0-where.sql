-- 1) Find the film titles that are R rated and have less than 1 hour of length.
SELECT f.title
FROM film f
WHERE f.rating = 'R'
      AND f.length <= 60


-- EXTRA: Order the list of films above by length - from longer to shorter.
SELECT f.title
FROM film f
WHERE f.rating = 'R'
      AND f.length <= 60
ORDER BY f.title ASC;
