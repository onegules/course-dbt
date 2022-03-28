### Part 1:

Q. What is our overall conversion rate?

A. 

```SELECT SUM(checkout) / COUNT(session_guid)
FROM 
  dbt_ovidiu_n.int_sessions_by_event_type;
```

Result: 0.62456747404844290657

Q. What is our conversion rate by product?

A.

See picture.

![image](https://user-images.githubusercontent.com/46457104/160331470-a53e79e7-5610-445d-9e3b-6a44ec7be96d.png)


DBT DAG:

![image](https://user-images.githubusercontent.com/46457104/160331338-2afbd012-e9e2-463b-8629-b029f62df6c0.png)
