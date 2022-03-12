{{
config(
    materialized='table'
)
}}

SELECT
    product_id,
    name AS name_of_product,
    price,
    inventory

FROM
    {{ source('source', 'products') }}