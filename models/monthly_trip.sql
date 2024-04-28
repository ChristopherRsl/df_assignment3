{{
    config(
        materialized = "table"
    )
}}

SELECT
  payment_type,
  EXTRACT(MONTH FROM lpep_pickup_datetime) AS month,
  EXTRACT(YEAR FROM lpep_pickup_datetime) AS year,
  ROUND(SUM(total_amount * {{ macro('get_exchange_rate') }}.exchange_rate), 2) 
    AS monthly_transactions_per_payment_type_idr
FROM
  {{ source('labs','taxi_tripdata')}}
WHERE VendorID IS NOT NULL
GROUP BY
  payment_type, month, year
ORDER BY
  payment_type, month, year ASC