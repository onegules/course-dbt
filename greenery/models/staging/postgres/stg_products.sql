{{
config(
    materialized='table'
)
}}

SELECT
    product_id AS product_guid,
    name AS product_name,
    price,
    inventory

FROM
    {{ source('source', 'products') }}