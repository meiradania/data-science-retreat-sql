-- Subquery Exercises

-- 1) names of all customers who returned a rental on 2005-05-27
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  customer_id IN (
    SELECT customer_id
    FROM payment
    --rental
    --WHERE CAST(return_date AS DATE) = '2005-05-27'
  );

-- 2) names of customers who have made a payment
-- 2a) with a subquery
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  EXISTS(
      SELECT 777
      FROM
        payment
      WHERE
        payment.customer_id = customer.customer_id
  );

-- 2b) with a JOIN
SELECT
  DISTINCT
  payment.customer_id,
  first_name,
  last_name
FROM
  customer
  JOIN
  payment ON payment.customer_id = customer.customer_id