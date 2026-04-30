{{ config(
    materialized='incremental',
    incremental_strategy='append'
)}}

with source as (

    select * from {{ source('google_sheet', 'budget') }}

),

renamed as (

    select
        _row,
        product_id,
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS sk,
        quantity,
        month,
        _fivetran_synced as date_load

    from source

)

select * from renamed

{% if is_incremental() %}
 WHERE date_load > (select MAX(date_load) from {{this}})
{% endif %}