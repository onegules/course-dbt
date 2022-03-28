{{
    config(
        materialized='view'
    )
}}

WITH page_view_counts_by_product AS (
    SELECT
        e.session_guid,
        p.product_name
    FROM 
        {{ ref('stg_events') }} AS e
    LEFT JOIN 
        {{ ref('stg_products') }} AS p
    ON
        e.product_guid = p.product_guid
    WHERE 
        e.event_type = 'page_view'
    ORDER BY
        p.product_name
)

SELECT 
    product_name, 
    count(product_name) AS view_count
FROM 
  page_view_counts_by_product
GROUP BY
  product_name