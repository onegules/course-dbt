{{
    config(
        materialized='table'
    )
}}

SELECT
    product_name,
    price,
    inventory
FROM
    {{ref('stg_products')}}