-- With Exercises

-- Re-do Subquery exercise 1) using WITH.
-- 1) names of all customers who returned a rental on 2005-05-27
WITH transactions AS (
  SELECT customer_id
    FROM rental
    WHERE CAST(return_date AS DATE) = '2005-05-27'
)
SELECT
  customer.first_name,
  customer.last_name
FROM
  transactions
  JOIN customer
  on transactions.customer_id = customer.customer_id;


WITH transactions AS (
  SELECT customer_id
    FROM rental
    WHERE CAST(return_date AS DATE) = '2005-05-27'
)
select * from transactions

