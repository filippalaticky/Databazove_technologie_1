SELECT DISTINCT s1.region
FROM flourmills_sales s1
WHERE NOT EXISTS (
    SELECT 1
    FROM flourmills_sales s2
    WHERE s2.region = s1.region
      AND s2.product_category = 'Flour'
);