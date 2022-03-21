{{
  config(
    materialized='view'
  )
}}

SELECT
    o.order_guid,
    o.user_guid,
    o.promo_type,
    p.discount
    o.created_at_utc,
    o.order_cost,
    o.shipping_cost,
    o.order_total as order_total_cost,
    o.shipping_service,
    o.estimated_delivery_utc,
    o.delivery_at_utc,
    o.delivery_status

FROM {{ref('stg_orders')}} AS o
LEFT JOIN {{ref('stg_promos')}} AS p
    on o.promo_type = p.promo_type