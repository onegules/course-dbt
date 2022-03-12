{{
config(
    materialized='table'
)
}}

SELECT 
    order_id,
    user_id,
    promo_id,
    address_id,
    created_at AS created_at_utc,
    order_cost,
    shipping_cost,
    order_total,
    tracking_id,
    shipping_service,
    estimated_delivery_at AS estimated_delivery,
    delivered_at,
    status AS delivery_status
FROM 
    {{ source('source', 'orders')}}
