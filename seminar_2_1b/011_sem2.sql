SELECT s1.product_category, s1.product_name, s1.total_amount
FROM flourmills_sales s1
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales s2
    WHERE s2.product_category = s1.product_category
      AND s2.total_amount > 200000
);