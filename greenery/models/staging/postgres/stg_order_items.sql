{{
config(
    materialized='table'
)
}}

SELECT
    order_id,
    product_id,
    quantity

FROM
    {{ source('source', 'order_items') }}