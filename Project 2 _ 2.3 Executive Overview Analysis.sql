-- Executive Overview Analysis 
/* Purpose : To View Overall Business Perfomance */ 

-- 1. Total KPI Summary 
SELECT 
	SUM(net_sales) AS total_sales, 
	COUNT(DISTINCT transaction_id) AS total_orders, 
	SUM(quantity) AS total_quantity, 
	ROUND(
		SUM(net_sales) / 
		COUNT(DISTINCT transaction_id), 
		2
	) AS avg_order_value
FROM retailsales.vw_retail_sales;

-- 2. Monthly Sales Trend 
SELECT 
	year_transaction, 
	month_transaction, 
	month_name, 
	SUM(net_sales) AS total_sales
FROM retailsales.vw_retail_sales
GROUP BY 1,2,3
ORDER BY 
	year_transaction, 
	month_transaction;

-- 3. TOP CATEGORY 
SELECT 
	category, 
	SUM(net_sales) AS total_sales
FROM retailsales.vw_retail_sales
GROUP BY category 
ORDER BY total_sales DESC
LIMIT 5;