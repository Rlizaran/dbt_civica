{{ config(
    materialized='view',
    tags = ['silver']
) }}


with 

source as (

    select * from {{ source('POSTGRE_DB', 'ADDRESSES') }}

),

renamed as (

    select
        address_id,
        address,
        state,
        zipcode,
        country,
        _fivetran_deleted,
        _fivetran_synced
    from source

)

select * from address_casted