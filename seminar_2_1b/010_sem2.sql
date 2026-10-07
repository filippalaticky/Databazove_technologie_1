SELECT s1.*
FROM flourmills_sales s1
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales s2
    WHERE s2.product_name = s1.product_name
    GROUP BY s2.product_name
    HAVING COUNT(DISTINCT EXTRACT(MONTH FROM s2.sales_date)) > 1
);