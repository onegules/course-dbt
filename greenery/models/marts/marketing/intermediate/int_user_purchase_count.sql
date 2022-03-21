with user_order_counts AS (
SELECT 
  user_guid,
  COUNT(order_guid)
FROM
  dbt_ovidiu_n.stg_orders
GROUP BY
  user_guid
)