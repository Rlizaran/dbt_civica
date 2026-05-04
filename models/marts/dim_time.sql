
with raw_data as (
    select 
        dateadd(day, seq4(), '2020-01-01') as date_day
    from table(generator(rowcount => 4000))
)

select 
    cast(date_day as date) as date_day
from raw_data