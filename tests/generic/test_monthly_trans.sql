{% test is_null(model, column_name) %}

with validation as (

    select
        {{ column_name }} as field

    from {{ model }}

),

validation_errors as (

    select
        field

    from validation
    -- if this is true, then field is actually odd!
    where (field) = NULL

)

select *
from validation_errors

{% endtest %}