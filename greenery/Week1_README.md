Q. How many users do we have?
A. 

``` 
SELECT 
    COUNT(DISTINCT(user_guid)) 
FROM 
    dbt_ovidiu_n.stg_users; 
```

Result: 130.

Q. On average, how many orders do we receive per hour?

A.

```
WITH order_count AS (
SELECT 
  COUNT(order_guid) AS order_count,  
  date_trunc('hour', created_at_utc) AS hour
FROM 
  dbt_ovidiu_n.stg_orders
GROUP BY
  date_trunc('hour', created_at_utc)
)

SELECT
  AVG(order_count)
FROM
  order_count;
```
Result: 7.5208333333333333

Q. On average, how long does an order take from being placed to being delivered?

A.

```
SELECT 
  AVG(delivered_at_utc - created_at_utc)
FROM
  dbt_ovidiu_n.stg_orders;
```
3 days -21:24:11.803279

Q. How many users have only made one purchase? Two purchases? Three+ purchases?

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

A. 

Single Purchase:

```
with user_order_counts AS (
SELECT 
  user_guid,
  COUNT(order_guid)
FROM
  dbt_ovidiu_n.stg_orders
GROUP BY
  user_guid
)

SELECT
  COUNT(user_guid)
FROM user_order_counts
WHERE cast(count as int) = 1;
```

Result: 25

Two Purchases:

```
with user_order_counts AS (
SELECT 
  user_guid,
  COUNT(order_guid)
FROM
  dbt_ovidiu_n.stg_orders
GROUP BY
  user_guid
)

SELECT
  COUNT(user_guid)
FROM user_order_counts
WHERE cast(count as int) = 2;
```

Result: 28

Three or more purchases:

```
with user_order_counts AS (
SELECT 
  user_guid,
  COUNT(order_guid)
FROM
  dbt_ovidiu_n.stg_orders
GROUP BY
  user_guid
)

SELECT
  COUNT(user_guid)
FROM user_order_counts
WHERE cast(count as int) >= 3;
```

Result: 71


Q. On average, how many unique sessions do we have per hour?

A. 

```
WITH unique_session_count_per_hour AS (
SELECT
  COUNT(DISTINCT(session_guid)) AS unique_count
  
FROM
  dbt_ovidiu_n.stg_events

GROUP BY
  date_trunc('hour', created_at_utc)
)

SELECT AVG(unique_count) FROM unique_session_count_per_hour
```

Result: 16.3275862068965517