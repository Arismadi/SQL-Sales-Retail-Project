-- DATA PROFILLING

--1.CHECK Total Row 
SELECT 
	COUNT(*) AS total_rows
FROM retailsales.retail;


-- 2. CHECK NULL 
SELECT
	COUNT(*) - COUNT(transaction_id) AS total_null_transaction_id, 
	COUNT(*) - COUNT(transaction_date) AS total_null_transaction_date, 
	COUNT(*) - COUNT(customer_id) AS total_null_customer_id, 
	COUNT(*) - COUNT(customer_gender) AS total_null_customer_gender, 
	COUNT(*) - COUNT(customer_age_group) AS total_null_customer_age_group, 
	COUNT(*) - COUNT(customer_segment) AS total_null_customer_segment, 
	COUNT(*) - COUNT(product_id) AS total_null_product_id, 
	COUNT(*) - COUNT(product_name) AS total_null_product_name, 
	COUNT(*) - COUNT(category) AS total_null_category,
	COUNT(*) - COUNT(brand) AS total_null_brand, 
	COUNT(*) - COUNT(quantity) AS total_null_quantity, 
	COUNT(*) - COUNT(unit_price) AS total_null_unit_price, 
	COUNT(*) - COUNT(discount_pct) AS total_null_discount_price,
	COUNT(*) - COUNT(sales_amount) AS total_null_sales_amount, 
	COUNT(*) - COUNT(payment_method) AS total_null_payment_method, 
	COUNT(*) - COUNT(sales_channel) AS total_null_sales_channel, 
	COUNT(*) - COUNT(region) AS total_null_region
FROM retailsales.retail;

-- 3. Check Blank(Empyt String)
SELECT 
	COUNT(*) FILTER(WHERE TRIM(transaction_id)='') AS blank_transaction_id, 
	COUNT(*) FILTER(WHERE TRIM(transaction_date)='') AS blank_transaction_date, 
	COUNT(*) FILTER(WHERE TRIM(customer_id)='') AS customer_id,
	COUNT(*) FILTER(WHERE TRIM(customer_gender)='') AS blank_customer_gender, 
	COUNT(*) FILTER(WHERE TRIM(customer_age_group)='') AS blank_customer_age_group,
	COUNT(*) FILTER(WHERE TRIM(customer_segment)='') AS blank_customer_segment,
	COUNT(*) FILTER(WHERE TRIM(product_id)='') AS blank_product_id, 
	COUNT(*) FILTER(WHERE TRIM(product_name)='') AS blank_product_name, 
	COUNT(*) FILTER(WHERE TRIM(category)='') AS blank_category, 
	COUNT(*) FILTER(WHERE TRIM(brand)='') AS blank_brand,
	COUNT(*) FILTER(WHERE TRIM(payment_method)='') AS blank_payment_method,
	COUNT(*) FILTER(WHERE TRIM(sales_channel)='') AS blank_sales_channel, 
	COUNT(*) FILTER(WHERE TRIM(region)='' ) AS blank_region
FROM retailsales.retail;
	
-- 4. Check Range Numeric COlumn 
SELECT 
	MIN(unit_price) AS min_price, 
	MAX(unit_price) AS max_price,
	MIN(discount_pct) AS min_discount_pct, 
	MAX(discount_pct) AS max_discount_pct,
	MIN(quantity) AS min_quantity, 
	MAX(quantity) AS max_quantity,
	MIN(sales_amount) AS min_sales_amount, 
	MAX(sales_amount) AS max_sales_amount
FROM retailsales.retail;


--5 Check duplicate Value 
SELECT 
	COUNT(*) AS total_duplicates_rows, 
	transaction_id,
	transaction_date,
	customer_id
FROM retailsales.retail
GROUP BY 2,3,4
HAVING COUNT(*) >1 ;
	
-- 6 Check Customer_ID has different customer_gender and customer_age_group
SELECT 
	customer_id, 
	customer_gender, 
	customer_age_group, 
	COUNT(*) AS total_different_customer_id
FROM retailsales.retail
GROUP BY 1,2,3
HAVING COUNT(*) > 1;

SELECT * 
FROM retailsales.retail
WHERE customer_id ='C001224';

-- 7. Check Inkonsistency Categorical Column
SELECT DISTINCT(customer_gender) FROM retailsales.retail ORDER BY 1;
SELECT DISTINCT(customer_age_group) FROM retailsales.retail ORDER BY 1;
SELECT DISTINCT(customer_segment) FROM retailsales.retail ORDER BY 1;
SELECT DISTINCT(category) FROM retailsales.retail ORDER BY 1;
SELECT DISTINCT(brand) FROM retailsales.retail ORDER BY 1;
SELECT DISTINCT(payment_method) FROM retailsales.retail ORDER BY 1;
SELECT DISTINCT(sales_channel) FROM retailsales.retail ORDER BY 1;
SELECT DISTINCT(region) FROM retailsales.retail ORDER BY 1;