with order_items as (
    select * from {{ ref('stg_order_items') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
)

select
    oi.order_item_id,
    oi.order_id,
    oi.user_id,
    oi.product_id,
    o.order_status,
    oi.item_status,
    o.created_at as order_created_at,
    oi.shipped_at,
    oi.delivered_at,
    oi.returned_at,
    oi.sale_price,
    o.num_of_item as items_in_order,
    case when oi.returned_at is not null then 1 else 0 end as is_returned,
    date_diff(date(oi.delivered_at), date(o.created_at), day) as days_to_deliver
from order_items oi
left join orders o on oi.order_id = o.order_id

