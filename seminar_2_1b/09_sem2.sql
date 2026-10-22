SELECT s1.product_name,
       s1.region,
       s1.total_amount,
       (SELECT MIN(s2.total_amount)
        FROM flourmills_sales s2
        WHERE s2.region = s1.region) AS region_min_amount
FROM flourmills_sales s1
ORDER BY s1.sales_id;