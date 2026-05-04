{{
  config(
    materialized='table',
    database='DEV_DB57_GOLD_DB',
    schema='marts'
  )
}}

with dim_orders as (
    select * from {{ ref('stg_POSTGRE_DB__ORDERS') }}
),

dim_addresses as (
    select * from {{ ref('stg_POSTGRE_DB__ADDRESSES') }}
),

dim_users as (
    select * from {{ ref('stg_POSTGRE_DB__USERS') }}
),

final_orders as (
    select
        o.order_id,
        o.user_id,
        o.address_id,
        a.country as address_country,
        try_cast(replace(cast(o.order_total as string), ',', '.') as number(18, 2)) as order_total_amount,
        cast(o.created_at as timestamp_ntz) as order_date,
        o.status as order_status,
        o.shipping_service
    from dim_orders o
    inner join dim_addresses a
        on o.address_id = a.address_id
    inner join dim_users u
        on o.user_id = u.user_id
)

select * from final_orders