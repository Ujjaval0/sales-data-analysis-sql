/* Data Segmentation 
   Group the data based on a specific range. - helps to understand the correlation between two measures.
   [Measure] by [Measure]
   total products by sales range
   Total customers by age
*/
-- Segement products into cost ranges and coun how many products fall into each segment

with product_segments AS(
select product_key, product_name, cost,
case 
	when cost < 100 then 'Below 100'
	when cost between 100 and 500 then '100-500'
	when cost between 500 and 1000 then '500-1000'
	else 'Above 1000'
end cost_range
from dim_products 
)

select cost_range, 
count(product_key) as total_products
from product_segments
group by cost_range
order by total_products DESC



/* Group customers into three segments based on their spending behavior:
- VIP : at least 12 months of history and spending more than $5000
- Regular : at least 12 months of history but spending $5000 or less.
- New : lifespan less than 12 months.
and find the total number of customers by each group
*/
WITH customer_spending AS (
    SELECT
        c.customer_key,
        SUM(f.sales_amount) AS total_spending,
        MIN(order_date) AS first_order,
        MAX(order_date) AS last_order,
        DATE_PART('month', AGE(MAX(order_date), MIN(order_date))) 
        + 12 * DATE_PART('year', AGE(MAX(order_date), MIN(order_date))) AS lifespan

    FROM fact_sales f
    LEFT JOIN dim_customers c
        ON f.customer_key = c.customer_key
    GROUP BY c.customer_key
)
SELECT 
    customer_segment,
    COUNT(customer_key) AS total_customers
FROM (
    SELECT 
        customer_key,
        CASE 
            WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
            WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
    FROM customer_spending
) AS segmented_customers
GROUP BY customer_segment
ORDER BY total_customers DESC;