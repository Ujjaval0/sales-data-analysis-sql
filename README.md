# Sales Data Analysis — SQL

A structured collection of PostgreSQL SQL scripts for analyzing sales data across
multiple dimensions — from customer behavior to product performance and time-based trends.

---

## 📁 Scripts Overview

| File | Purpose |
|------|---------|
| `customer_report.sql` | Customer-level report with segmentation (VIP / Regular / New), age groups, AOV, and monthly spend |
| `product_report.sql` | Product-level report with revenue segmentation, lifespan, AOR, and monthly revenue KPIs |
| `trends_analysis.sql` | Sales trends broken down by year, month, and year+month using EXTRACT and DATE_TRUNC |
| `cumlative_analysis.sql` | Running totals, moving averages (3-month), month-over-month growth %, and LAG comparisons |
| `Perform_analysis.sql` | Year-over-year product performance vs. average sales using window functions |
| `proportional_analysis.sql` | Part-to-whole analysis — category-wise contribution (%) to overall sales |
| `data_segmentation.sql` | Customer and product grouping by cost ranges and spending behavior |

---

## 🧠 Concepts Covered

- **CTEs** (Common Table Expressions)
- **Window Functions** — `SUM() OVER`, `AVG() OVER`, `LAG()`
- **Date Functions** — `DATE_TRUNC`, `EXTRACT`, `AGE`
- **CASE-based Segmentation**
- **Views** (`CREATE VIEW`)
- **Aggregations & KPIs**
- **Proportional / Part-to-Whole Analysis**
- **Cumulative & Moving Average Analysis**

---

## 🗄️ Database

- **Engine:** PostgreSQL  
- **Tables Used:**
  - `fact_sales` — transactional sales records
  - `dim_customers` — customer dimension
  - `dim_products` — product dimension

