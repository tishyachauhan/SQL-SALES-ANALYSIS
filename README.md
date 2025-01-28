# **_Retail Sales Analysis SQL Project_**

This project involves analyzing sales transaction data using SQL. 
The dataset includes transaction details such as date, time, amount, customer demographics, and product category. The objective is to extract valuable insights, including sales trends, customer behavior by age and gender, and product performance. Key SQL queries are used to calculate total sales, average purchase amounts, top-selling products, and monthly sales performance. The project helps in identifying trends and patterns that can guide business decisions and strategy.

![Image](https://github.com/user-attachments/assets/76a326cf-9bec-43d6-95b8-fdb3e608a0bf)

## Data Source
The dataset used in this project was downloaded from blob:https://github.com/8fbeb763-b40f-4cb4-9559-6039e2a66e6e.

INSIGHTS
Sales Trends: Analyzing the sales data by date and time can help identify patterns such as peak sales periods.
Gender-based Analysis: Gender distribution of customers and their purchasing behavior.
Age Demographics: Breakdown of sales based on customer age groups.
Product Performance: Insights into which product categories and individual products are performing well.
Month and Day of the Week Analysis: Seasonal trends and sales volume by day of the week and month.
# Retail Sales Analysis SQL Project

This project involves the analysis of retail sales data using SQL queries. The dataset contains detailed transaction information, including sales amount, customer demographics, product categories, and sale timestamps. The main goal is to extract valuable insights related to sales performance, customer behavior, time-based trends, profitability, and inventory management.

---

## Queries and Insights

### 1. **Sales Analysis**

#### Total Sales Per Day, Week, and Month
- **Objective**: To calculate the total sales in different time periods.
- **Queries**:
  ```sql
  -- Total sales amount
  SELECT SUM(total_sale) AS TOTAL_SALES FROM sales;

  -- Sales per month
  ALTER TABLE sales ADD COLUMN month VARCHAR(12);
  UPDATE sales SET month = MONTHNAME(sale_date);
  SELECT month, SUM(total_sale) AS SALE_PER_MONTH FROM sales GROUP BY month ORDER BY SUM(total_sale);

  -- Sales per day
  ALTER TABLE sales ADD COLUMN day VARCHAR(10);
  UPDATE sales SET day = DAYNAME(sale_date);
  SELECT day, SUM(total_sale) AS SALE_PER_DAY FROM sales GROUP BY day ORDER BY day;

  -- Sales per week
  SELECT WEEK(sale_date), SUM(total_sale) AS SALE_PER_WEEK FROM sales GROUP BY WEEK(sale_date) ORDER BY WEEK(sale_date);
  
Top Best-Selling Categories
Objective: To find out which categories are generating the most sales.
Query
  SELECT category, SUM(total_sale) FROM sales GROUP BY category ORDER BY SUM(total_sale) DESC;
Average Sales Per Transaction
Objective: To determine the average sales per transaction.
Query  
  SELECT AVG(total_sale) AS AVERAGE_SALE FROM sales;

