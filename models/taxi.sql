
{{ config(materialized='table') }}



select *
from {{ source('labs','taxi_tripdata')}}
LIMIT 3


