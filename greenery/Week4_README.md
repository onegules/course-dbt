### Part 1: DBT Snapshots

Q. Did you see the data change via the snapshot?

A.

Yes. Here is the result of the update:

```
SELECT 
  order_id,
  tracking_id,
  shipping_service,
  status, 
  dbt_scd_id,
  dbt_updated_at,
  dbt_valid_from,
  dbt_valid_to
FROM 
  snapshots.orders_snapshot
WHERE
  order_id in ('914b8929-e04a-40f8-86ee-357f2be3a2a2', '05202733-0e17-4726-97c2-0520c024ab85',

'939767ac-357a-4bec-91f8-a7b25edd46c9')
```

Result:

![image](https://user-images.githubusercontent.com/46457104/161402393-0e04f6f2-46e3-4c85-9e1f-68b6e70abd7d.png)

### Part 2: Modeling Challenge

Q. How are users moving through the product funnel? Which steps in the funnel have the largest drop off points?

A.

The most common way users are moving through the product funnel is by way of viewing a product, adding it to cart, and checking out.
The drop off points are as follows:

Table calculated from:

```
SELECT 
  *
FROM 
  product_funnel;
```

Result:

![image](https://user-images.githubusercontent.com/46457104/161402262-a80a4366-f27f-4efb-bbb7-be33c28dffde.png)

The columns are defined as follows:

total_sessions - A count of the total sessions that had either a 
        page_view, checkout, add_to_cart or package_shipped event. Note that a 
        package shipped event only occurs when a checkout event has occurred.
        
purchase_event - A count of the sessions with both add_to_cart and checkout events.

checkout_event - A count of the sessions with checkout events.

Taken from `greenery/models/product/schema_product.yml`.

From this we can see:

- The dropoff from a page view to a purchase event is 19.2% (`1 - (total_sessions / purchase_event)`).
- The dropoff from a purchase event to a checkout event is 22.7% (`1 - (purchase_event / checkout_event)`).

So, the largest dropoff point is from adding to cart to checking out the product.


As an extra, here's the DAG for this week:

![image](https://user-images.githubusercontent.com/46457104/161402488-16d156b2-a7ba-4462-8bdc-b79dc1e8b853.png)

DAGs are fun.

### Part 3: Reflection Questions.

#### 3A. DBT Next steps.

My organization is not currently using DBT. We're a startup whose main product is machine learning models and their predictions. We already have a decision maker on-board (the problem is always having the time to actually implement these new ideas!). I work as a data scientist and most of the process - as every data scientist will tell you - is transforming data. We have a custom built pipeline, written in python, that we run almost every time we pull data from our database. Further, this process, or a very similar one, is used for data in production. The use case for DBT would be simply to transform this data before it gets into the hands of our data science team thus speeding them up. For a relatively small team, any time improvements is a big deal and would make everyone more efficient, so it has been a simple sell. We hope to start implementing DBT in the coming months.

#### 3B. Setting up for production

Setting up a production DBT project would first mean using an orchestration tool. I prefer dagster since most of our team primarily codes in python and it would be the most familiar for everyone. Next, scheduling depends on how often this data is ingested and is useful to look at and inspect. For instance, if - in the case of greenery - we were ingesting order data daily, then it might make sense to have the models be created every morning before people start coming in to work. However, if we're a smaller company and our orders, products and user count are not changing much daily (say, >10 orders a day - chosen arbitrarily), it might make sense to create models more infrequently such as on a weekly basis or once every few days. That said, in either case testing on data going into the data warehouse should be tested daily at minimum for any irregularities.

Setting up snapshots for orders is also important. This would allow us to check that orders are properly being updated. Even though our tests can already include stuff like if one row is null, another should be filled, or vice versa, using snapshots would ensure the code updating these pieces is working properly and could alert us if anything is going wrong quickly. Also, setting up proper snapshots could give more information regarding expected delivery times and making sure our products are arriving in a timely manner, lowering the rate of complaints. How often to run our snapshots also depend on how much and how often we're ingesting data, however they should be run at minimum daily. We are interested in knowing any and all changes to our orders so keeping this table updated is important.

Finally, our dashboard can be improved. While understanding the product funnel and how our users interact with the site is important, what about information about what products our users are buying? What are the most commonly bought items? At what price? Is there an influx of purchases if there's a promotion? Are our users using promotions when they're available? These questions are not necessarily difficult to answer but knowing historical purchase trends will help inform business decisions.
