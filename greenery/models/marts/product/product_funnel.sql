SELECT
   COUNT(session_guid) AS total_sessions,
   COUNT(CASE WHEN (add_to_cart >=1) OR (checkout >= 1) THEN 1 ELSE NULL END) AS purchase_event,
   COUNT(CASE WHEN checkout>=1 THEN 1 ELSE NULL END) AS checkout_event
FROM
    {{ ref('int_sessions_by_event_type') }}