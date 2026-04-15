# SQL Sales Analytics

This project contains a series of PostgreSQL SQL scripts written to perform 
end-to-end analysis on a sales dataset consisting of transactions, customers, 
and products. The goal was to move beyond basic queries and apply advanced SQL 
techniques to extract meaningful business insights.

---

## What This Project Covers

### Customer Analysis
Customers were segmented into three behavioral groups — VIP, Regular, and New — 
based on their purchase history and total spending. Age groups were also created 
to understand which demographics are most active. Key metrics calculated include 
average order value and average monthly spend per customer.

### Product Analysis
Products were evaluated by their total revenue contribution and classified as 
High-Performers, Mid-Range, or Low-Performers. Additional KPIs like average order 
revenue, average monthly revenue, and product lifespan were computed to understand 
how long a product stays relevant in the market.

### Trends Over Time
Sales were analyzed across different time dimensions — yearly, monthly, and 
year-month combined — to identify patterns and seasonality in revenue, customer 
count, and quantity sold.

### Cumulative and Moving Average Analysis
Running totals were calculated to track how sales accumulated over time. A 3-month 
moving average was applied to smooth short-term fluctuations and reveal underlying 
trends. Month-over-month growth percentage was also computed to measure momentum.

### Year-over-Year Performance
Each product's annual sales were compared against its own historical average and 
its previous year's sales. This helped identify which products are consistently 
growing, declining, or staying flat.

### Proportional Analysis
Category-level sales were measured as a percentage of total revenue to understand 
which product categories drive the most business value.

### Data Segmentation
Products were grouped into cost ranges to understand pricing distribution. 
Customers were grouped by spending behavior to support targeted decision-making.

---

## Key SQL Concepts Applied

- Common Table Expressions (CTEs)
- Window Functions — SUM() OVER, AVG() OVER, LAG()
- Date Functions — DATE_TRUNC, EXTRACT, AGE
- CASE-based segmentation
- Views (CREATE VIEW)
- Aggregations and KPI calculations
