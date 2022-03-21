{{
    config(
        materialized='table'
    )
}}

SELECT
    e.created_at_utc AS event_at_utc,
    e.event_type,
    e.event_url,
    o.order_cost,
    o.shipping_cost,
    o.order_total as order_total_cost,
    o.shipping_service,
    o.estimated_delivery_utc,
    o.delivered_at_utc,
    o.delivery_status

FROM {{ref('stg_events')}} AS e
LEFT JOIN {{ref('stg_orders')}} AS o
    ON e.order_guid = o.order_guid