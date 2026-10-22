SELECT DISTINCT s1.product_category
FROM flourmills_sales s1
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales s2
    WHERE s2.product_category = s1.product_category
    GROUP BY s2.product_category
    HAVING COUNT(DISTINCT s2.region) > 3
)
ORDER BY s1.product_category;