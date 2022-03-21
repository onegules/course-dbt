{{
  config(
    materialized='table'
  )
}}

SELECT
    o.order_guid,
    o.promo_type,
    ua.first_name,
    ua.last_name,
    ua.email,
    ua.phone_number,
    o.created_at_utc AS ordered_at_utc,
    o.order_cost,
    o.shipping_cost,
    o.order_total AS order_total_cost,
    ua.street_address,
    ua.zipcode,
    ua.state,
    ua.country,
    o.shipping_service,
    o.estimated_delivery_utc,
    o.delivered_at_utc,
    o.delivery_status
FROM 
  {{ref('stg_orders')}} AS o
LEFT JOIN 
  {{ref('int_users_addresses')}} AS ua
  ON o.user_guid = ua.user_guid