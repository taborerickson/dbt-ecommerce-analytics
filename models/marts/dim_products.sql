with products as (
    select * from {{ ref('stg_products') }}
),

distribution_centers as (
    select * from {{ ref('stg_distribution_centers') }}
)

select
    p.product_id,
    p.product_name,
    p.category,
    p.brand,
    p.department,
    p.sku,
    p.retail_price,
    p.cost,
    round(p.retail_price - p.cost, 2) as gross_margin,
    dc.distribution_center_name,
    dc.latitude as dc_latitude,
    dc.longitude as dc_longitude
from products p
left join distribution_centers dc
    on p.distribution_center_id = dc.distribution_center_id


