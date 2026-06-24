-- Additionally Analysis 
-- 1. Weekdays vs Weekend Analysis 
SELECT 
	day_type, 
	SUM(net_sales) AS total_sales, 
	COUNT(*) AS total_transaction, 
	ROUND(AVG(net_sales),2) AS average_sales
FROM retailsales.vw_retail_sales
GROUP BY day_type
ORDER BY total_sales DESC;

-- 2. Best Perfoming Brand 
SELECT 
	brand, 
	SUM(net_sales) AS total_sales
FROM retailsales.vw_retail_sales
GROUP BY brand
ORDER BY total_sales DESC;

-- 3.Region + Category Analysis 
SELECT 
	region, 
	category, 
	SUM(net_sales) AS total_sales
FROM retailsales.vw_retail_sales
GROUP BY 
	region, 
	category 
ORDER BY total_sales DESC;