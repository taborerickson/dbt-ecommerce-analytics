with users as (
    select * from {{ ref('stg_users') }}
),

order_stats as (
    select
        user_id,
        count(distinct order_id) as lifetime_orders,
        min(created_at) as first_order_date,
        max(created_at) as most_recent_order_date
    from {{ ref('stg_orders') }}
    group by user_id
)

select
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.age,
    u.gender,
    u.state,
    u.city,
    u.country,
    u.traffic_source,
    u.created_at as signup_date,
    coalesce(o.lifetime_orders, 0) as lifetime_orders,
    o.first_order_date,
    o.most_recent_order_date
from users u
left join order_stats o on u.user_id = o.user_id

