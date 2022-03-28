### Part 1:

Q. What is our overall conversion rate?

A. 

```SELECT SUM(checkout) / COUNT(session_guid)
FROM 
  dbt_ovidiu_n.int_sessions_by_event_type;```

Result: 0.62456747404844290657

Q. What is our conversion rate by product?

A.

See picture.



DBT DAG: