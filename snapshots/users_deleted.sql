{% snapshot users_deleted_snp%}

{{
    config(
        target_schema='snapshots',
        unique_key='DNI',
        hard_deletes='new_record',
        strategy='timestamp',
        updated_at='fecha_alta_sistema'
    )
}}

SELECT
    Nombre,
    DNI,
    email,
    fecha_alta_sistema
FROM {{ source('google_sheet', 'users') }}

{% endsnapshot %}