{{
config(
    materialized='table'
)
}}

SELECT
    address_id AS address_guid,
    address AS street_address,
    zipcode,
    state,
    country
FROM
    {{ source('source', 'addresses') }}