{{
    config(
        materialized='table'
    )
}}

SELECT
    event_at_utc,
    event_type,
    event_url,
    order_cost,
    shipping_cost,
    order_total_cost,
    shipping_service,
    estimated_delivery_utc,
    delivered_at_utc,
    delivery_status

FROM 
    {{ref('int_page_views')}}