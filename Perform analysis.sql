-- Performance Analysis
-- Current[measure] - Target[measure]
-- current Sales - Average Sales
-- Current Year Sales - Previous Year Sales
-- Current Sales - Lowest Sales


-- SQL Task --
--   Analyze the yearly performance of products by comparing each product's sales to both it's average sales
---  performance and the previous year's sales.

WITH yearly_product_sales AS (
    -- Aggregate total sales per product per year
    SELECT 
        EXTRACT(YEAR FROM f.order_date) AS order_year,
        p.product_name,
        SUM(f.sales_amount) AS current_sales
    FROM fact_sales f
    LEFT JOIN dim_products p
        ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
    GROUP BY 
        EXTRACT(YEAR FROM f.order_date), 
        p.product_name
)

SELECT 
    order_year, 
    product_name, 
    current_sales,

    -- Compare current sales with product's average across all years
    ROUND(AVG(current_sales) OVER (PARTITION BY product_name), 0) AS avg_sales,
    ROUND(current_sales - AVG(current_sales) OVER (PARTITION BY product_name), 0) AS diff_avg,

    CASE	
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
        ELSE 'Avg'
    END AS avg_change,

    -- Year-over-Year comparison using previous year's sales
    LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS py_sales,
    current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_py,

    CASE	
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increasing'
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decreasing'
        ELSE 'No Change'
    END AS py_change

FROM yearly_product_sales
ORDER BY product_name, order_year;
