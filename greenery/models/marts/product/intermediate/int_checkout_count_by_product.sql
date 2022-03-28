{{
    config(
        materialized='view'
    )
}}

WITH checkout_count_by_product AS (
    SELECT 
        e.session_guid,
        p.product_name
    FROM 
        {{ ref('stg_events') }} AS e
    LEFT JOIN
        {{ ref('stg_order_items') }} AS o
    ON
        e.order_guid = o.order_guid
    LEFT JOIN
        {{ ref('stg_products') }} AS p
    ON
        o.product_guid = p.product_guid
    WHERE 
        e.event_type = 'checkout'
    ORDER BY 
        product_name
)

SELECT 
    product_name, 
    count(product_name) AS check_count
FROM 
  checkout_count_by_product
GROUP BY
  product_name