{{
  config(
    materialized='table'
  )
}}

SELECT
  first_name,
  last_name,
  email,
  phone_number,
  created_at_utc AS registered_at_utc,
  updated_at_utc,
  street_address,
  zipcode,
  state,
  country
FROM
  ref{{('int_users_addresses')}} 
