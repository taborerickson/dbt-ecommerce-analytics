with source as (
    select * from {{ source('thelook_ecommerce', 'products') }}
),

renamed as (
    select
        id as product_id,
        name as product_name,
        category,
        brand,
        retail_price,
        cost,
        department,
        sku,
        distribution_center_id
    from source
)

select * from renamed
