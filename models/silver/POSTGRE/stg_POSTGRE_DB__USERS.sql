with source as (

    select * from {{ source('POSTGRE_DB', 'USERS') }}

),

renamed as (

    select
        user_id,
        first_name,
        last_name,
        phone_number,
        email,
        address_id,
        total_orders,
        created_at,
        updated_at,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed