select * from fact_sales;
-- Analysing trend over time 
-- Year 
select Extract(year from order_date) as order_year, sum(sales_amount) as total_sales,
count (distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from fact_sales
where order_date is not null
group by Extract(year from order_date)
order by order_year;


-- Month
select Extract(Month from order_date) as order_month, sum(sales_amount) as total_sales,
count (distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from fact_sales
where order_date is not null
group by Extract(Month from order_date)
order by order_month;



-- Year + Month
select Extract(year from order_date) as order_year,Extract(Month from order_date) as order_month
, sum(sales_amount) as total_sales,
count (distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from fact_sales
where order_date is not null
group by Extract(year from order_date) ,Extract(Month from order_date)
order by order_year, order_month ;


-- Date_trunc

select DATE_TRUNC('month', order_date)::DATE AS month_date
, sum(sales_amount) as total_sales,
count (distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from fact_sales
where order_date is not null
group by DATE_TRUNC('month', order_date)
order by month_date ;


