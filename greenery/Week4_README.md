Q. Did you see the data change via the snapshot?

A.

Yes. Here is the result of the update:

```

```

Result:


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

The columns are defined as follows:

total_sessions - A count of the total sessions that had either a 
        page_view, checkout, add_to_cart or package_shipped event. Note that a 
        package shipped event only occurs when a checkout event has occurred.
        
purchase_event - A count of the sessions with both add_to_cart and checkout events.

checkout_event - A count of the sessions with checkout events.

Taken from `greenery/models/product/schema_product.yml`.

From this we can see that the dropoff from a page view to a purchase event is 19.2% (1 - (total_sessions / purchase_event)).
The dropoff from a purchase event to a checkout event is 22.7% (1 - (purchase_event / checkout_event)).

So, the largest dropoff point is from adding to cart to checking out the product.


As an extra, here's the DAG for this week:

