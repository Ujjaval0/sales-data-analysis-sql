/*  Part to whole - Proportional Analysis
    ([measure]/total[measure]) * 100 by [dimension]
	(sales/total sales) * 100 by category
	(Quantity/total_quantity) * 100 by country
    think like a pie chart 
*/

/* Which categories contribute the most to overall sales?
*/

-- To display aggregations at multiple levels in the results, use winodw functions

WITH category_sales AS (
    -- Aggregate total sales per category
    SELECT 
        category, 
        SUM(sales_amount) AS total_sales
    FROM fact_sales f
    LEFT JOIN dim_products p
        ON p.product_key = f.product_key
    GROUP BY category
)

SELECT 
    category, 
    total_sales,
	
    -- Calculate overall total using window function (same value for all rows)
    SUM(total_sales) OVER() AS overall_sales,

    -- Calculate each category's contribution (%) to total sales
    CONCAT(ROUND((total_sales / SUM(total_sales) OVER()) * 100, 2),'%') AS percentage_of_total

FROM category_sales
ORDER BY total_sales DESC;