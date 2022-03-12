{{
config(
    materialized='table'
)
}}

SELECT
    event_id,
    session_id,
    user_id,
    page_url AS event_url,
    created_at AS created_at_utc,
    event_type,
    order_id
FROM
    {{ source('source', 'events') }}