{{
  config(
    materialized='table'
  )
}}

SELECT
  u.user_id,
  u.email,
  u.first_name,
  u.last_name,
  u.birth_date,
  u.status,
  CASE
    WHEN u.status = 1 THEN 'Active'
    WHEN u.status = 3 THEN 'Banned'
    ELSE 'Other'
  END AS status_label,
  u.registered_at_utc,
  TO_DATE(u.registered_at_utc) AS registered_date,
  u.referred_by_user_id IS NOT NULL AS is_referral,
  pc.promo_code AS invite_promo_code
FROM {{ ref('stg_users') }} u
LEFT JOIN {{ ref('stg_promo_codes') }} pc
  ON u.invite_promo_code_id = pc.promo_code_id