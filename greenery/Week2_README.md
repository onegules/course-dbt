Part 1. Models

Q. What is our user repeat rate?

A.

```with user_order_counts AS (
SELECT 
  user_guid,
  COUNT(order_guid) AS purchase_count
FROM
  dbt_ovidiu_n.stg_orders
GROUP BY
  user_guid
)

SELECT (COUNT(user_guid) filter(WHERE purchase_count > 1) / COUNT(user_guid)::real) * 100
FROM user_order_counts```

Result: 79.83870967741935

Q. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

A. 

Typically if someone has purchased once, they won't purchase again. With more
data, we could confirm this pattern. Users that haven't made a purchase
for a long time.

Q. Explain the marts models you added. Why did you organize the models in the way you did?

A. Models added:

`core/dim_products` - All information from the stg_products. Important information about greenery's products.
`core/dim_users` - All information for users, including when account was created, first name, last name, and place of residence.
`core/fct_orders` - All information regarding orders including cost, user who made the order and where the order is going (delivery address).
`core/intermediate/int_users_addresses` - Intermediate step combining all user information (name, contact info, etc) and address (state, country, zipcode, etc).
`marketing/fct_user_orders` - All information regarding users orders including promotional discounts if they were applied.
`marketing/intermediate/int_orders_discounts` -
`product/fct_page_views` - Information regarding website events including orders if one was made.
`product/int_page_views` - Intermediate transformation (joins) for fct_page_views


Q. Use the dbt docs to visualize your model DAGs to ensure the model layers make sense

A. 

![image](https://user-images.githubusercontent.com/46457104/159216316-c177150d-5157-484b-bfd0-47b717f6e3a5.png)


Part 2. Tests

Q. What assumptions are you making about each model? (i.e. why are you adding each test?)

A. Quite a few assumptions were made regarding whether or not certain columns were null (see below for problems encountered with this). I also made assumptions about uniqueness based on what I considered to be the primary key in each model. For example, for dim_users, we expect `user_guid` to be unique as it's a user based table.

Q. Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

A. I did. I was surprised to find no estimated delivery, and no delivery status for some orders. I expected these to be not null, but there were instances where they were implying that there are some customers that don't know the status of their order. To pass these tests, I would simply take out that assumption. I've left it in for now, because I think it's useful to know when these values are not in the database.

That said, it's possible that this assumption is incorrect and something like estimated delivery doesn't exist because a shipping service hasn't been set. It may be that we need to check that a shipping service is set in the database, and then check if estimated delivery/delivery status is set.

Q. Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

A. The assumptions need to be reassessed in some cases. For instance, my initial assumption about estimated delivery time is likely incorrect, and as mentioned above, there likely needs to be a shipping service set (there can be instances where no shipping service is set, thus implying the order is not ready to be sent and so no estimate can be made). Once we understand how this data is getting into the database and under what conditions, we can align our tests with those needs and make sure our tests pass.
