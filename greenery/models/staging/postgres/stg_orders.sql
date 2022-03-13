{{
config(
    materialized='table'
)
}}

SELECT 
    order_id AS order_guid,
    user_id AS user_guid,
    promo_id AS promo_type,
    address_id AS address_guid,
    created_at AS created_at_utc,
    order_cost,
    shipping_cost,
    order_total,
    tracking_id AS tracking_guid,
    shipping_service,
    estimated_delivery_at AS estimated_delivery_utc,
    delivered_at AS delivered_at_utc,
    status AS delivery_status
FROM 
    {{ source('source', 'orders')}}
