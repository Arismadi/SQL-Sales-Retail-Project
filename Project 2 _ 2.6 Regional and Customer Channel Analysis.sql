-- Regional and Channel Analysis 
/* Purpose : to Understand Region and Sales */ 

-- 1. Regional Perfomance 
SELECT 
	region, 
	COUNT(DISTINCT transaction_id) AS total_orders, 
	ROUND(AVG(net_sales),2) AS avg_sales, 
	SUM(net_sales) AS total_sales
FROM retailsales.vw_retail_sales 
GROUP BY region 
ORDER BY total_sales DESC;

-- 2. Sales Channel Analysis 
SELECT 
	sales_channel, 
	COUNT(DISTINCT transaction_id) AS total_orders, 
	ROUND(AVG(net_sales),2) AS avg_sales,
	SUM(net_sales) AS total_sales
FROM retailsales.vw_retail_sales 
GROUP BY sales_channel 
ORDER BY total_sales DESC;

-- 3. Payment Method Analysis 
SELECT 
	payment_method, 
	COUNT(DISTINCT transaction_id) AS total_orders, 
	ROUND(AVG(net_sales),2) AS avg_sales, 
	SUM(net_sales) AS total_sales
FROM retailsales.vw_retail_sales
GROUP BY payment_method
ORDER BY total_sales DESC;