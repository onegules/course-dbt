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
