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
Queries and Insights
1. Sales Analysis
Total Sales Per Day, Week, and Month
Objective: To calculate the total sales in different time periods.
Queries:
sql
Copy
Edit
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
Query:
sql
Copy
Edit
SELECT category, SUM(total_sale) FROM sales GROUP BY category ORDER BY SUM(total_sale) DESC;
Average Sales Per Transaction
Objective: To determine the average sales per transaction.
Query:
sql
Copy
Edit
SELECT AVG(total_sale) AS AVERAGE_SALE FROM sales;
Percentage Contribution of Each Category to Total Sales
Objective: To calculate the contribution percentage of each category.
Query:
sql
Copy
Edit
SELECT category, (SELECT SUM(total_sale) FROM sales WHERE category = sales.category) / (SELECT SUM(total_sale) FROM sales) * 100 AS PERCENT_CONTRIBUTION FROM sales GROUP BY category;
2. Customer Insights
Gender-Wise Distribution of Customers
Objective: To analyze the sales distribution by gender.
Query:
sql
Copy
Edit
SELECT gender, SUM(total_sale) / (SELECT SUM(total_sale) FROM sales) * 100 AS percentage_contribution FROM sales GROUP BY gender;
Age Group Contribution to Total Sales
Objective: To analyze which age group contributes the most to sales.
Query:
sql
Copy
Edit
SELECT CASE
  WHEN age BETWEEN 0 AND 20 THEN '0-20'
  WHEN age BETWEEN 20 AND 30 THEN '20-30'
  WHEN age BETWEEN 30 AND 45 THEN '30-45'
  WHEN age BETWEEN 45 AND 60 THEN '45-60'
  WHEN age > 60 THEN '60 ABOVE'
END AS AGE_RANGE, SUM(total_sale) / (SELECT SUM(total_sale) FROM sales) * 100 AS percent_contribution_in_sale FROM sales GROUP BY AGE_RANGE ORDER BY AGE_RANGE;
Unique Customers and Their Total Purchases
Objective: To find out how many unique customers made purchases.
Query:
sql
Copy
Edit
SELECT COUNT(DISTINCT customer_id) AS UNIQUE_CUSTOMERS, COUNT(*) AS TOTAL_PURCHASES FROM sales;
Average Spending Per Customer
Objective: To determine the average spending per customer.
Query:
sql
Copy
Edit
SELECT customer_id, SUM(total_sale) / (SELECT COUNT(DISTINCT customer_id) FROM sales) AS AVERAGE_SPENDING FROM sales GROUP BY customer_id ORDER BY AVERAGE_SPENDING DESC;
Top 5 Customers by Lifetime Value (Total Sales)
Objective: To identify the top customers by total sales.
Query:
sql
Copy
Edit
SELECT customer_id, SUM(total_sale) AS PURCHASE FROM sales GROUP BY customer_id ORDER BY SUM(total_sale) DESC LIMIT 5;
3. Time-Based Trends
Sales by Time of Day
Objective: To analyze which time of day generates the most sales.
Query:
sql
Copy
Edit
SELECT CASE
  WHEN sale_time BETWEEN '00:00:00' AND '11:59:00' THEN 'MORNING'
  WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'AFTERNOON'
  WHEN sale_time BETWEEN '17:00:00' AND '21:00:00' THEN 'EVENING'
  ELSE 'NIGHT'
END AS TIME_OF_DAY, SUM(total_sale) AS SALE FROM sales GROUP BY TIME_OF_DAY ORDER BY SUM(total_sale);
Seasonal Trends in Sales
Objective: To determine which months have the highest and lowest sales.
Queries:
sql
Copy
Edit
-- Highest sales month
SELECT month, SUM(total_sale) AS TOP_SALE FROM sales GROUP BY month ORDER BY SUM(total_sale) DESC LIMIT 1;

-- Lowest sales month
SELECT month, SUM(total_sale) AS LOWEST_SALE FROM sales GROUP BY month ORDER BY SUM(total_sale) LIMIT 1;
Peak Sale Days of the Week
Objective: To find the peak sales day of the week.
Query:
sql
Copy
Edit
SELECT day AS PEAK_SALE_DAY FROM sales GROUP BY day ORDER BY SUM(total_sale) DESC LIMIT 1;
4. Profit Analysis
Highest Profit Product/Category
Objective: To determine the product/category with the highest sales.
Query:
sql
Copy
Edit
SELECT category AS TOP_PRODUCT, SUM(total_sale) AS TOP_SALE FROM sales GROUP BY category ORDER BY SUM(total_sale) DESC LIMIT 1;
Overall Profit (Total Sales - COGS)
Objective: To calculate the overall profit.
Query:
sql
Copy
Edit
SELECT SUM(total_sale) AS NET_PROFIT FROM sales;
Profit Contribution of Each Category
Objective: To analyze the profit contribution by category.
Query:
sql
Copy
Edit
SELECT category, SUM(total_sale) FROM sales GROUP BY category ORDER BY SUM(total_sale) DESC;
5. Inventory Management
Average Quantity Sold per Category
Objective: To calculate the average quantity sold by category.
Query:
sql
Copy
Edit
SELECT category, SUM(quantity) AS QUANTITY_SOLD FROM sales GROUP BY category ORDER BY SUM(quantity);
Low-Performing Categories
Objective: To identify categories with the least sales.
Query:
sql
Copy
Edit
SELECT category, SUM(total_sale) AS SALE FROM sales GROUP BY category ORDER BY SUM(total_sale) LIMIT 1;
6. Customer Behavior
Repeat Customers
Objective: To analyze the repeat customers in the dataset.
Query:
sql
Copy
Edit
SELECT customer_id, COUNT(*) AS OCCURRENCE FROM sales GROUP BY customer_id ORDER BY COUNT(*) DESC LIMIT 10;
Gender-Wise Average Spending
Objective: To analyze gender-wise spending.
Query:
sql
Copy
Edit
SELECT gender, SUM(total_sale) AS SPENDING FROM sales GROUP BY gender ORDER BY SPENDING DESC;
Categories Popular Among Age Groups
Objective: To determine which categories are more popular among specific age groups.
Query:
sql
Copy
Edit
SELECT CASE
  WHEN age BETWEEN 0 AND 20 THEN '0-20'
  WHEN age BETWEEN 21 AND 30 THEN '20-30'
  WHEN age BETWEEN 31 AND 45 THEN '30-45'
  WHEN age BETWEEN 46 AND 60 THEN '45-60'
  WHEN age > 60 THEN 'ABOVE 60'
END AS AGE_GROUPS, (SELECT category FROM sales WHERE age = AGE_GROUPS GROUP BY category ORDER BY SUM(total_sale) LIMIT 1) AS CATEGORY_MOST_POPULAR, SUM(total_sale) AS SALE FROM sales GROUP BY AGE_GROUPS ORDER BY AGE_GROUPS;
Conclusion
This project explores the retail sales dataset from various angles, such as total sales, customer behavior, time-based trends, profit analysis, and inventory management. By analyzing the data through SQL queries, we can uncover valuable insights that can help businesses make data-driven decisions and optimize their operations.
