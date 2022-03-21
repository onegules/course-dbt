{{
    config(
        materialized='table'
    )
}}


SELECT
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.created_at_utc,
    od.created_at_utc AS order_created_at_utc,
    od.order_cost,
    od.promo_type,
    od.discount
    od.shipping_cost,
    od.order_total AS order_total_cost,
    od.shipping_service,
    od.estimated_delivery,
    od.delivered_at,
    od.delivery_status
FROM {{ref('stg_users')}} AS u
LEFT JOIN {{ref('orders_discounds')}} AS od
    ON u.user_guid = od.user_guid

