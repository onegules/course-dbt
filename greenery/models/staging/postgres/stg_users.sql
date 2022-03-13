{{
config(
    materialized='table'
)
}}

SELECT
    user_id AS user_guid,
    first_name,
    last_name,
    email,
    phone_number,
    created_at AS created_at_utc,
    updated_at AS updated_at_utc,
    address_id AS address_guid
FROM
    {{ source('source', 'users') }}