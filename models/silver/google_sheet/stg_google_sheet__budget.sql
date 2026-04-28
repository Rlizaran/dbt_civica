with source as (

    select * from {{ source('google_sheet', 'budget') }}

),

renamed as (

    select
        _row,
        product_id,
        quantity,
        month,
        _fivetran_synced as date_load

    from source

)

select * from renamed