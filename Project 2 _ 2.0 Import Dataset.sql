CREATE TABLE retailsales.retail (
	transaction_id VARCHAR(20), 
	transction_date TEXT, 
	customer_id VARCHAR(20), 
	customer_gender VARCHAR(20), 
	customer_age_group VARCHAR(20), 
	customer_segment VARCHAR(20), 
	product_id VARCHAR(20), 
	product_name VARCHAR(100), 
	category VARCHAR(50), 
	brand VARCHAR(20), 
	quantity NUMERIC, 
	unit_price NUMERIC, 
	discount_pct NUMERIC,
	sales_amount NUMERIC, 
	payment_method VARCHAR (50), 
	sales_channel VARCHAR(50), 
	region VARCHAR(20)
);

SELECT COUNT(*) FROM retailsales.retail AS total_rows ;

-- Make table and import data Success

SELECT * FROM retailsales.retail;

SELECT COUNT(DISTINCT(sales_channel)) FROM retailsales.retail;

ALTER TABLE retailsales.retail 
RENAME COLUMN transction_date TO transaction_date;