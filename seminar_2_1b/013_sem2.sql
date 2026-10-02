SELECT s1.*
FROM flourmills_sales s1
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales s2
    WHERE s2.region = s1.region
      AND EXTRACT(YEAR FROM s2.sales_date) = 2024
);