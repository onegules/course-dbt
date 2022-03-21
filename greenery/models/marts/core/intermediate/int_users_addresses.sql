{{
  config(
    materialized='view'
  )
}}

SELECT
  u.user_guid,
  u.first_name,
  u.last_name,
  u.email,
  u.phone_number,
  u.created_at_utc AS registered_at_utc,
  u.updated_at_utc,
  ad.address_guid,
  ad.street_address,
  ad.zipcode,
  ad.state,
  ad.country
FROM
  {{ref('stg_users')}} AS u
LEFT JOIN {{ ref('stg_addresses') }} AS ad
  ON u.address_guid = ad.address_guid

