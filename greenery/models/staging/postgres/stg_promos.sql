{{
config(
    materialized='table'
)
}}

SELECT
    promo_id AS promo_type,
    discount,
    status
FROM
   {{ source('source', 'promos') }}