{{ config(materialized='table') }}

select
  extract(year from lpep_pickup_datetime) AS year,
  extract(month from lpep_pickup_datetime) AS month,
  SUM(passenger_count) AS total_passengers
from {{ source('labs','taxi_tripdata')}}
group by extract(year from lpep_pickup_datetime), extract(month from lpep_pickup_datetime)
order by year, month


