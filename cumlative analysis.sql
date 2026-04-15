-- Cumulative Analysis
--1. [cumlative measure] by [date dimension]
--2. Running total sales by year
--3. Moving average of sales by month

-- Calculate the total sales per month and the running total of sales over time.

SELECT 
    order_date, 
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales
FROM
(
    SELECT 
        DATE_TRUNC('month', order_date)::DATE AS order_date,
        SUM(sales_amount) AS total_sales
    FROM fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATE_TRUNC('month', order_date)
) t;


-- CTE's 

WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', order_date)::DATE AS order_date,
        SUM(sales_amount) AS total_sales
    FROM fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATE_TRUNC('month', order_date)
)

SELECT 
    order_date,
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales
FROM monthly_sales;

-- YEAR's


WITH yearly_sales AS (
    SELECT 
        DATE_TRUNC('year', order_date)::DATE AS order_date,
        SUM(sales_amount) AS total_sales
    FROM fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATE_TRUNC('year', order_date)
)

SELECT 
    order_date,
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales
FROM yearly_sales;


-- Moving average 

WITH yearly_sales AS (
    SELECT 
        DATE_TRUNC('year', order_date)::DATE AS order_date,
        SUM(sales_amount) AS total_sales,
        AVG(sales_amount) AS avg_sales
    FROM fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATE_TRUNC('year', order_date)
)

SELECT 
    order_date,
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
    ROUND(AVG(avg_sales) OVER (ORDER BY order_date), 0) AS moving_average_sales
FROM yearly_sales;



-- combine all the queries of moving average -
-- monthly sales 

WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', order_date)::DATE AS month,
        SUM(sales_amount) AS total_sales
    FROM fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT * 
FROM monthly_sales
ORDER BY month;


-- Running Total

WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', order_date)::DATE AS month,
        SUM(sales_amount) AS total_sales
    FROM fact_sales
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT 
    month,
    total_sales,
    SUM(total_sales) OVER (ORDER BY month) AS running_total
FROM monthly_sales;


-- Moving Average (3 months)

WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', order_date)::DATE AS month,
        SUM(sales_amount) AS total_sales
    FROM fact_sales
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT 
    month,
    total_sales,
    AVG(total_sales) OVER (
        ORDER BY month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_3_months
FROM monthly_sales;


-- Previous Month (LAG)

WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', order_date)::DATE AS month,
        SUM(sales_amount) AS total_sales
    FROM fact_sales
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT 
    month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY month) AS prev_month_sales
FROM monthly_sales;



-- Growth %


WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', order_date)::DATE AS month,
        SUM(sales_amount) AS total_sales
    FROM fact_sales
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT 
    month,
    total_sales,
    ROUND(
        (total_sales - LAG(total_sales) OVER (ORDER BY month)) 
        * 100.0 
        / NULLIF(LAG(total_sales) OVER (ORDER BY month), 0),
    2) AS growth_pct
FROM monthly_sales;
