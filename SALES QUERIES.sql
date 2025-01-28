-- Retail sales project
SELECT * FROM retailsales.sales;

-- SALES ANALYSIS

	-- What is the total sales amount per day, week, and month?
		# sales in total 
		SELECT SUM(total_sale) AS TOTAL_SALES FROM sales ;  
		
		# sales per month
		-- creating new column of month 
		SET SQL_SAFE_UPDATES = 0;
		ALTER TABLE sales 
		ADD COLUMN month varchar(12);
		UPDATE sales 
		SET  month = MONTHNAME(sale_date);
		SELECT month , SUM(total_sale) AS SALE_PER_MONTH FROM sales GROUP BY month ORDER BY SUM(total_sale);
        
        # sales per DAY 
        ALTER TABLE sales 
        ADD COLUMN day VARCHAR(10);
        UPDATE sales
        SET day = DAYNAME(sale_date);
        SELECT day,SUM(total_sale) AS SALE_PER_DAY FROM sales GROUP BY day ORDER BY day;
        
        # sales per week
        SELECT WEEK(sale_date),SUM(total_sale) AS SALE_PER_WEEK FROM sales GROUP BY WEEK(sale_date) ORDER BY WEEK(sale_date)
        ;
    
	-- What are the top best-selling categories?
		SELECT category , SUM(total_sale) FROM sales GROUP BY category ORDER BY SUM(total_sale) DESC ;
        
	-- What is the average sales amount per transaction?
		SELECT AVG(total_sale) AS AVERAGE_SALE FROM sales;
        
	-- What is the percentage contribution of each category to the total sales?
		USE retailsales;
		SELECT category, (SELECT SUM(total_sale) GROUP BY category)/(SELECT SUM(total_sale) FROM sales)*100 AS PERCENT_CONTRIBUTION FROM sales GROUP BY category;
		
-- CUSTOMER INSIGHTS
	
	-- What is the gender-wise distribution of customers?
	-- What age group contributes the most to the total sales?
	-- 	How many unique customers made purchases during a specific period?
    -- What is the average spending per customer?
	-- Which customers have the highest lifetime value (total sales)?
    
		# GENDER WISE DISTRIBUTION
			SELECT gender,SUM(total_sale)/(SELECT SUM(total_sale) FROM sales)*100 AS percentage_contribution FROM sales GROUP BY  gender;
		# AGE GROUP CONTRIBUTION 
			SELECT CASE
				WHEN age BETWEEN 0 AND 20 THEN '0-20'
                WHEN age BETWEEN 20 AND 30 THEN '20-30'
                WHEN AGE BETWEEN 30 AND 45 THEN '30-45'
                WHEN age BETWEEN 45 AND 60 THEN '45-60'
                WHEN age> 60 THEN '60 ABOVE'
			END AS AGE_RANGE , SUM(total_sale)/(SELECT SUM(total_sale) FROM sales)*100 AS percent_contribution_in_sale FROM sales 
            GROUP BY AGE_RANGE ORDER BY AGE_RANGE;
            
		# UNIQUE CUSTOMERS
        SELECT COUNT(DISTINCT(customer_id)) AS UNIQUE_CUSTOMERS,COUNT(*) AS TOTAL_PURCHASES  FROM sales;
        
        # AVERAGE SPENDING PER CUSTOMER
			SELECT DISTINCT(customer_id) AS CUSTOMER_ID , SUM(total_sale)/(SELECT COUNT(DISTINCT(customer_id)) FROM sales) AS AVERAGE_SPENDING FROM sales GROUP BY customer_id ORDER BY AVERAGE_SPENDING DESC;
		# TOP 5 CUSTOMERS WITH HIGHEST LIFTIME VALUE 
			SELECT customer_id, SUM(total_sale) AS PURCHASE FROM SALES  GROUP BY customer_id ORDER BY SUM(total_sale) DESC LIMIT 5 ;
            
-- TIME-BASED TRENDS 

	-- Which time of day (e.g., morning, afternoon, evening) generates the most sales?
	-- Are there any seasonal trends in sales (e.g., higher sales in certain months)?
	-- What are the peak sale days of the week?
    
    # MOST SALES 
		SELECT CASE
			WHEN sale_time  BETWEEN '00:00:00' AND '11:59:00' THEN 'MORNING'
            WHEN sale_time  BETWEEN '12:00:00' AND '05:00:00' THEN 'AFTERNOON'
            WHEN sale_time  BETWEEN '05:00:00' AND '09:00:00' THEN 'EVENING'
            ELSE 'NIGHT'
            END AS TIME_OF_THE_DAY , SUM(total_sale) AS SALE FROM sales 
            GROUP BY TIME_OF_THE_DAY
            ORDER BY SUM(total_sale);
	# SEASONAL TRENDS 
		SELECT month , SUM(total_sale) AS TOP_SALE FROM sales GROUP BY month ORDER BY SUM(total_sale) DESC LIMIT 1;  # TOP SALE
        SELECT month , SUM(total_sale) AS LOWEST_SALE FROM sales GROUP BY month ORDER BY SUM(total_sale)  LIMIT 1;   # LEAST SALE 
	# PEAK SALE DAY OF THE WEEK 
		SELECT day AS PEAK_SALE_DAY FROM SALES GROUP BY day ORDER BY SUM(total_sale) LIMIT 1;
        
-- PROFIT ANALYSIS
	-- Which category or product has the highest profit margin?
	-- What is the overall profitability (total sales - total COGS)?
	-- What is the profit contribution of each category?
			
	# HIGHEST PROFIT PRODUCT
		SELECT category AS TOP_PRODUCT , SUM(total_sale) AS TOP_SALE FROM sales GROUP BY category ORDER BY SUM(total_sale) DESC LIMIT 1;
	# OVERALL PROFIT 
		SELECT SUM(total_sale) AS NET_PROFIT FROM sales;
	# PROFIT CONTRIBUTION OF EACH CATEGORY
		SELECT category , SUM(total_sale) FROM sales GROUP BY category ORDER BY SUM(total_sale) DESC ;
        
-- INVENTORY MANAGEMENT
	-- What is the average quantity sold per category?
	-- Which categories or products often sell out quickly?
	-- Are there any low-performing categories or products based on sales and profit?
    
    # AVERAGE QUANTITY PER CATEGORY
		SELECT category , SUM(quantiy) AS QUANTITY_SOLD FROM sales GROUP BY category ORDER BY SUM(quantiy) ;
	# LOW PERFORMING CATEGORY
		SELECT category , SUM(total_sale) AS SALE FROM sales GROUP BY category ORDER BY SUM(total_sale)  LIMIT 1 ;
-- CUSTOMER BEHAVIOUR
	-- How many repeat customers are there in the dataset?
	-- What is the gender-wise average spending per transaction?
	-- Are certain categories more popular among specific age groups?
	
    # TOP 10 REPEAT CUSTOMERS
		SELECT customer_id,COUNT(*) AS OCCURENCE FROM sales GROUP BY customer_id ORDER BY COUNT(*) DESC LIMIT 10;
	# GENDER WISE SPENDING
		SELECT gender , SUM(total_sale) AS SPENDING FROM sales GROUP BY gender ORDER BY SPENDING DESC;
	# CATEGORIES POPULAR AMONG AGE GROUPS
		SELECT CASE
			WHEN age BETWEEN 0 AND 20 THEN '0-20'
            WHEN age BETWEEN 21 AND 30 THEN '20-30'
            WHEN age BETWEEN 31 AND 45 THEN '30-45'
            WHEN age BETWEEN 46 AND 60 THEN '45-60'
            WHEN age>60 THEN 'ABOVE 60'
            END AS AGE_GROUPS , (SELECT CATEGORY FROM SALES WHERE AGE= AGE_GROUPS GROUP BY CATEGORY ORDER BY SUM(TOTAL_SALE) LIMIT 1) AS CATEGORY_MOST_POPULAR , SUM(total_sale) AS SALE FROM sales 
            GROUP BY AGE_GROUPS ORDER BY AGE_GROUPS;
	