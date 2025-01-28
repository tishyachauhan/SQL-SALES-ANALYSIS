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


# Sales Analysis SQL Queries - Questions & Insights

## 1. **What is the total sales amount in the dataset?**
- **Query**: 
    - `SELECT SUM(sales_amount) AS total_sales FROM sales_data;`
- **Insight**: 
    - This query gives an overall view of the total sales from all transactions.

## 2. **What are the total sales by region?**
- **Query**: 
    - `SELECT region, SUM(sales_amount) AS total_sales FROM sales_data GROUP BY region;`
- **Insight**: 
    - Helps understand which region contributes the most to overall sales and can guide decisions on regional marketing strategies.

## 3. **What are the total sales by product category?**
- **Query**: 
    - `SELECT category, SUM(sales_amount) AS total_sales FROM sales_data GROUP BY category;`
- **Insight**: 
    - Provides insight into the sales performance of each product category, helping to focus on high-performing categories.

## 4. **What is the daily sales amount?**
- **Query**: 
    - `SELECT DATE(sales_date) AS date, SUM(sales_amount) AS total_sales FROM sales_data GROUP BY DATE(sales_date);`
- **Insight**: 
    - Shows daily fluctuations in sales, which can help in analyzing trends or identifying specific dates with spikes or drops.

## 5. **What are the total sales by salesperson?**
- **Query**: 
    - `SELECT salesperson, SUM(sales_amount) AS total_sales FROM sales_data GROUP BY salesperson;`
- **Insight**: 
    - Tracks individual salesperson performance, helping in understanding which salesperson contributes the most to total sales.

## 6. **Which are the top 5 best-selling products?**
- **Query**: 
    - `SELECT product_name, SUM(sales_amount) AS total_sales FROM sales_data GROUP BY product_name ORDER BY total_sales DESC LIMIT 5;`
- **Insight**: 
    - Identifies the best-selling products, enabling focused inventory and promotional efforts on high-performing items.

## 7. **What is the sales trend over time (monthly)?**
- **Query**: 
    - `SELECT EXTRACT(MONTH FROM sales_date) AS month, SUM(sales_amount) AS total_sales FROM sales_data GROUP BY EXTRACT(MONTH FROM sales_date) ORDER BY month;`
- **Insight**: 
    - Analyzes monthly sales trends, revealing seasonality and overall growth or decline in sales.

## 8. **What is the average sales value by region?**
- **Query**: 
    - `SELECT region, AVG(sales_amount) AS avg_sales FROM sales_data GROUP BY region;`
- **Insight**: 
    - Helps to identify the average value of sales in different regions, giving a perspective on purchasing behavior across areas.

