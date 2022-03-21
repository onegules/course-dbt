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
    od.discount,
    od.shipping_cost,
    od.order_total_cost, 
    od.shipping_service,
    od.estimated_delivery_utc,
    od.delivered_at_utc,
    od.delivery_status

FROM 
    {{ ref('stg_users') }} AS u
LEFT JOIN 
    {{ ref('int_orders_discounts') }} AS od
    ON u.user_guid = od.user_guid
