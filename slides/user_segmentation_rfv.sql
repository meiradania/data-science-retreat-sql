-- User Segmentation (RFV)

-- R: recency - the last transaction
-- F: frequency - how many transactions
-- V: value - the total value of the transactions
-- Optional: for a determined period, e.g. year, quarter, month
DROP TABLE IF EXISTS rfv_customers;
CREATE TABLE rfv_customers AS
  (
    WITH customer_data AS (
        SELECT
          customer.customer_id,
          customer.first_name,
          customer.last_name,
          max(rental.rental_date)                   AS last_rental_date,
          count(rental.rental_id)                   AS total_transactions,
          sum(payment.amount)                       AS total_amount,
          NTILE(2)
          OVER (
            ORDER BY max(rental.rental_date) DESC ) AS median_r,
          NTILE(2)
          OVER (
            ORDER BY count(rental.rental_id) DESC ) AS median_f,
          NTILE(2)
          OVER (
            ORDER BY sum(payment.amount) DESC )     AS median_v
        FROM
          rental
          JOIN payment ON rental.rental_id = payment.rental_id
          JOIN customer ON payment.customer_id = customer.customer_id
        --WHERE date_part('year',rental.rental_date) = 2005
        GROUP BY 1, 2, 3
        ORDER BY 3 DESC, 4 DESC, 5 DESC
    )
    SELECT
      *,
      CASE
      WHEN median_r = 1 AND median_f = 1 AND median_v = 1
        THEN 'Top Customers'
      WHEN median_r = 1 AND median_f = 2 AND median_v = 2
        THEN 'Newest Customers'
      WHEN median_r = 2 AND median_f = 2 AND median_v = 2
        THEN 'Least Engaged Customers'
      ELSE 'Undefined' END AS segment_name
    FROM customer_data
  );

--- Checking the table
SELECT *
FROM rfv_customers
ORDER BY segment_name;

--- Customers per segment
SELECT
  segment_name,
  count(customer_id)                customers,

  min(last_rental_date)             min_last_rental_date,
  max(last_rental_date)             max_last_rental_date,

  min(total_transactions)           min_transactions,
  round(avg(total_transactions), 2) avg_transactions,
  max(total_transactions)           max_transactions,

  min(total_amount)                 min_value,
  round(avg(total_amount), 2)       avg_value,
  max(total_amount)                 max_value
FROM rfv_customers
WHERE segment_name != 'Undefined'
GROUP BY segment_name
ORDER BY avg_value DESC;