-- CREATE VIEW 
CREATE VIEW retailsales.vw_retail_sales AS (

WITH clean_data AS ( 
	SELECT 
		transaction_id, 
		CAST(transaction_date AS DATE) AS transaction_date, 
		customer_id, 
		customer_gender, 
		customer_age_group, 
		customer_segment, 
		product_id, 
		product_name, 
		category,
		brand, 
		quantity, 
		unit_price, 
		discount_pct, 
		sales_amount, 
		payment_method, 
		sales_channel, 
		region
	FROM retailsales.retail
)
		
SELECT 
	transaction_id, 
	transaction_date,
	-- Time Analysis
	EXTRACT(YEAR FROM transaction_date) AS year_transaction,
	EXTRACT(MONTH FROM transaction_date) AS month_transaction,
	TRIM(TO_CHAR(transaction_date, 'Month')) AS month_name,
	TRIM(TO_CHAR(transaction_date, 'Day')) AS day_name,
	EXTRACT(DOW FROM transaction_date) AS day_number,
	EXTRACT(QUARTER FROM transaction_date) AS quarter_transaction, 
	CASE 
		WHEN EXTRACT(DOW FROM transaction_date) IN (0,6) 
			THEN 'Weekend'
		ELSE 'Weekdays'
	END AS day_type, 
	--Customer
	customer_id, 
	customer_gender, 
	customer_age_group, 
	CASE 
		WHEN TRIM(customer_age_group) IN ('18-24','25-34')
			THEN 'Young Adult'
		WHEN TRIM(customer_age_group) = '35-44'
			THEN 'Adult'
		ELSE 'Senior'
	END AS customer_age_segment, 
	customer_segment, 
	--product
	product_id, 
	product_name, 
	category, 
	brand, 
	--sales
	quantity, 
	unit_price, 
	discount_pct, 
	(discount_pct/100) AS discount_rate,
	CASE 
		WHEN discount_pct = 0 THEN 'No Discount'
		WHEN discount_pct <= 10 THEN 'Low Discount'
		WHEN Discount_pct <= 20 THEN 'Medium Discount'
		ELSE 'High Discount'
	END AS discount_category, 
	
	--Gross sales Before Discount
	(quantity * unit_price) AS gross_sales,
	
	-- Discount Amount
	((quantity * unit_price) - sales_amount) AS discount_amount, 
	-- Net sales (After discount)
	sales_amount AS net_sales,
	-- Average Net selling 
	CASE 
		WHEN quantity = 0 THEN 0 
		ELSE sales_amount/quantity 
	END AS avg_net_selling_price, 
	-- Sales Size Segmentation
	CASE 
		WHEN sales_amount <100 THEN 'Small'
		WHEN sales_amount < 500 THEN 'Medium'
		ELSE 'Large'
	END AS sales_size,
	-- Basket Size
	CASE 
		WHEN quantity <= 2 THEN 'Small Basket'
		WHEN quantity <= 4 THEN 'Medium Basket'
		ELSE 'Large Basket'
	END AS basket_size, 
	-- Transaction 
	payment_method, 
	sales_channel, 
	region
FROM clean_data
);

SELECT * FROM retailsales.vw_retail_sales;