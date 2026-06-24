-- 2. Product Analysis 
/* Purpose : To Understand product and discount Perfomance */ 

-- A. TOP Product by Revenue 
SELECT 
	product_name, 
	category, 
	SUM(net_sales) AS total_sales
FROM retailsales.vw_retail_sales 
GROUP BY 
	product_name, 
	category
ORDER BY total_sales DESC 
LIMIT 10;

-- B. Top Product By Quantity Sales 
SELECT 	
	product_name, 
	category, 
	SUM(quantity) AS total_quantity
FROM retailsales.vw_retail_Sales
GROUP BY 
	product_name, 
	category
ORDER BY total_quantity DESC 
LIMIT 10;

-- C.Discount Impact Analysis 
SELECT 
	discount_category, 
	COUNT(*) AS total_transaction,
	SUM(net_sales) AS total_sales, 
	ROUND(AVG(net_sales),2) AS avg_sales
FROM retailsales.vw_retail_sales
GROUP BY discount_category
ORDER BY total_sales DESC;

-- D. Basket Analysis
SELECT 
	basket_size, 
	COUNT(*) AS total_transaction, 
	SUM(net_sales) AS total_sales, 
	ROUND(AVG(net_sales),2) AS avg_sales 
FROM retailsales.vw_retail_sales 
GROUP BY basket_size
ORDER BY total_sales DESC;


-- E. TOP product Category 
SELECT 
	category, 
	SUM(net_sales) AS total_sales,
	COUNT(*) AS total_orders, 
	ROUND(AVG(net_sales),2) AS avg_sales
FROM retailsales.vw_retail_sales
GROUP BY 1
ORDER BY total_sales DESC
LIMIT 5;

	