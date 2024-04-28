{{ config(materialized='table') }}

-- This model calculates monthly transactions per payment type in IDR


SELECT
  payment_type,
  EXTRACT(MONTH FROM lpep_pickup_datetime) AS month,
  EXTRACT(YEAR FROM lpep_pickup_datetime) AS year,
  ROUND(SUM(total_amount), 2) AS monthly_transactions_per_payment_type,
  {{ get_exchange_rate('total_amount') }} as monthly_transactions_idr,
FROM
  {{ source('labs','taxi_tripdata')}}
WHERE payment_type IS NOT NULL
GROUP BY
  payment_type, month, year
ORDER BY
  payment_type, month, year ASC