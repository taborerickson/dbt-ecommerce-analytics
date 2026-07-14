with source as (
    select * from {{ source('thelook_ecommerce', 'users') }}
),

renamed as (
    select
        id as user_id,
        first_name,
        last_name,
        email,
        age,
        gender,
        state,
        city,
        country,
        traffic_source,
        created_at
    from source
)

select * from renamed

