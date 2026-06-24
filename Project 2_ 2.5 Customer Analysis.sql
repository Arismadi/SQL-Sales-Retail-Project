-- 3. Customer Analysis 
/* Purpose : to get understanding customer behavior*/ 

-- A. Gender Analysis 
SELECT 
	customer_gender, 
	COUNT(DISTINCT(customer_id)) AS total_customers, 
	SUM(net_sales) AS total_sales, 
	ROUND(AVG(net_sales),2) AS avg_spending
FROM retailsales.vw_retail_sales 
GROUP BY customer_gender
ORDER BY total_sales DESC;

-- B. Age Segment Analysis 
SELECT 
	customer_age_segment, 
	COUNT(DISTINCT customer_id) AS total_customers,
	SUM(net_sales) AS total_sales, 
	ROUND(AVG(net_sales),2) AS avg_spending
FROM retailsales.vw_retail_sales
GROUP BY customer_age_segment
ORDER BY total_sales DESC;

-- C. Customer Segment Analysis
SELECT 
	customer_segment, 
	COUNT(DISTINCT customer_id) AS total_customers, 
	SUM(net_sales) AS total_sales, 
	ROUND(AVG(net_sales),2) AS avg_spending
FROM retailsales.vw_retail_sales
GROUP BY customer_segment 
ORDER BY total_sales DESC;

-- D. Spending Behavior
SELECT 
	sales_size, 
	COUNT(*) AS total_transaction, 
	SUM(net_sales) AS total_sales
FROM retailsales.vw_retail_sales
GROUP BY sales_size
ORDER BY total_sales DESC;