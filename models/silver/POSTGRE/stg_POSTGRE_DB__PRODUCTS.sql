with 

source as (

    select * from {{ source('POSTGRE_DB', 'PRODUCTS') }}

),

renamed as (

    select
        product_id,
        name,
        price,
        inventory,
        _fivetran_deleted as date_deleted,
        _fivetran_synced as date_load

    from source

)

select * from renamed