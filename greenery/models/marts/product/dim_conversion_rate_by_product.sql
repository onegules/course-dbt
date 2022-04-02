SELECT 
    c.product_name, (c.check_count::decimal / v.view_count::decimal)  AS conversion_rate
FROM 
    {{ ref('int_page_view_counts_by_product') }} AS v
LEFT JOIN 
    {{ ref('int_checkout_count_by_product') }} AS c
ON 
    v.product_name = c.product_name