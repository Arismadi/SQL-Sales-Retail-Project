# SQL Retail Sales Project 
## Project Overview 
#### **Project's Titles** : `Retail Sales Perfomance Analysis Project`
#### **software** : `PostgreSQL`
#### **Database** : `myproject`
#### **Schema** : `retailsales`
#### **Tables** : `retail`
This project aims to demonstrate SQL skills and techniques in data analysis specifically to explore, clean, and analyze sales perfomance. The project consisted of setting up a retail sales database, performing exploratory data analysis (EDA), and answering business questions through specific SQL queries.

## Project Objective 
1) Set Up Database : Prepare a database for this project from previously available data from Kaggle (Dataset Access : https://www.kaggle.com/datasets/noopurbhatt/retail-sales-dataset)
2) Data Cleaning : identify and delete null,missing values or duplicate data from database
3) Create View : Create view to do analyst without change the raw data
4) Exploratory Data Analysis : carry out data exploration to better understand the dataset
5) Business Question Analysis : Make a query to answer the business question


## Project Structure 
## 1) Database Set Up : 
+ **Database Creation** : The first step I take to start this project is create the database entitled **`myproject`**
+ **Schemas Creation** : After make a database, the next step is make a schema entitled **`retailsales`**
+ **Tables Creation** : The table used in this project is entitled **`retail`** which consists of several columns, such as transaction_id, transaction_date, customer_id, customer_gender, customer_age_group, customer_segment, product_id, product_name, category, brand, quantity, unit_price, discount_pct, sales_amount, payment_method, sales_channel, region.

```sql
CREATE TABLE retailsales.retail (
	transaction_id VARCHAR(20), 
	transaction_date TEXT, 
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
```

## 2) Data Cleaning 

This prosess aim to : 
+ find total rows from dataset
+ check null values and handling it
+ check blank (empty string)
+ check range numeric column
+ check duplicated value
+ check inkonsistency categorical column

#### 1. Find total rows from dataset 
```sql
SELECT
  COUNT(*) AS total_rows
FROM retailsales.retail;
```
#### 2. Check null values and try to handling it 
```sql
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
```

#### 3. Check Blank (Empty String) 
```sql
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
```
#### 4. Check range numeric column
```sql
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
```

#### 5. Check Duplicated Value 
```sql
SELECT 
	COUNT(*) AS total_duplicates_rows, 
	transaction_id,
	transaction_date,
	customer_id
FROM retailsales.retail
GROUP BY 2,3,4
HAVING COUNT(*) >1 ;
```

#### 6. Check Inkonsistency Categorical Column 
```sql
SELECT DISTINCT(customer_gender) FROM retailsales.retail ORDER BY 1;
SELECT DISTINCT(customer_age_group) FROM retailsales.retail ORDER BY 1;
SELECT DISTINCT(customer_segment) FROM retailsales.retail ORDER BY 1;
SELECT DISTINCT(category) FROM retailsales.retail ORDER BY 1;
SELECT DISTINCT(brand) FROM retailsales.retail ORDER BY 1;
SELECT DISTINCT(payment_method) FROM retailsales.retail ORDER BY 1;
SELECT DISTINCT(sales_channel) FROM retailsales.retail ORDER BY 1;
SELECT DISTINCT(region) FROM retailsales.retail ORDER BY 1;
```
### ``Dataset profiling results:``
The dataset contains 12,000 rows, with no null values, empty strings (blanks), duplicate values, or data inconsistencies found. The next step is to create a view.

## 3) Create View 
Analytical views are created to perform data cleaning, transformation, and business enrichment on retail data before it is used in Power BI, without altering the original raw dataset. This view help produce datasets that are more ready for analysis and simplify the creation of KPIs and dashboard visualizations. This analytical view is used as:
+ a data transformation layer
+ a business logic layer
+ an analytical-ready dataset

making the dashboarding process more efficient, consistent, and easy to maintain.

```sql
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
```

## 4) Write Query to Answer Business Questions & Exploratory Data Analysis
SQL queries are used to perform exploratory data analysis (EDA) and to answer various business questions relevant to retail business performance. The analysis is conducted to explore sales patterns, customer behavior, product performance, the effectiveness of discounts, and the contribution of regions and sales channels to business revenue.

This analysis aims to:
+ identify sales trend
+ identify top-performing products and categories
+ understand customer behavior and spending patterns
+ evaluate the impact of discounts on sales
+ compare the performance of regions and sales channels

Some of the analyses conducted include:
+ monthly sales trend analysis
+ top product & category analysis
+ customer segment analysis
+ regional performance analysis
+ sales channel comparison
+ discount effectiveness analysis
+ basket size & spending behavior analysis

The results of the query analysis are then used as the basis for creating KPIs, dashboard visualizations, and business insights in Power BI.

### 1. Executive Overview Analysis 
``purpose`` : to view overall business perfomance

#### a) Total KPI Summary 
```sql
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
```
#### b) Monthly Sales Trend 
```sql
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
```

#### c) Top Category
```sql
SELECT 
	category, 
	SUM(net_sales) AS total_sales
FROM retailsales.vw_retail_sales
GROUP BY category 
ORDER BY total_sales DESC
LIMIT 5;
```

###  2. Product and Discount Impact Analysis
``purpose `` : to understand product and discount perfomance 
#### a) Top Product by Revenue 
``Business Question`` : Which products generate the highest revenue contribution?
```sql
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
```
``insight`` : Bread from the Groceries category generated the highest revenue contribution among all products, followed closely by Lipstick from the Beauty category. This indicates that both daily essential products and personal care items showed strong customer deman and sales perfomances. 

#### b) Top Product by Quantity Sales 
``Business Question`` : Which products has the most quantity sold in dataset?
```sql
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
```
``Insight``: Dumbbells in the Sports category have the highest sales volume compared to other products. Lamps in the Home category are the second best selling products, followed by puzzles in the Toys category.
This indicates that consumers tend to purchase everyday items in larger quantities than other products.

#### c) Discount Impact Analysis
``Business Question`` : Which discount category generates the highest revenue and transaction volume from dataset?
```sql
SELECT 
	discount_category, 
	COUNT(*) AS total_transaction,
	SUM(net_sales) AS total_sales, 
	ROUND(AVG(net_sales),2) AS avg_sales
FROM retailsales.vw_retail_sales
GROUP BY discount_category
ORDER BY total_sales DESC;
```
``Insight`` : Product without discount generated the highest transaction volume, total revenue, and average sales value compared to other discount categories. Revenue and average sales consistenly decreased as discount levels increased. This indicating that higher discount did not necessarily lead to stronger sales perfomance. 

#### d) Basket Analysis 
``Business Question`` : Which basket size category contributes the highest transactions and revenue?
```sql
SELECT 
	basket_size, 
	COUNT(*) AS total_transaction, 
	SUM(net_sales) AS total_sales, 
	ROUND(AVG(net_sales),2) AS avg_sales 
FROM retailsales.vw_retail_sales 
GROUP BY basket_size
ORDER BY total_sales DESC;
```
``Insight`` : Small basket generated the highest transaction volume and total revenue, indicating that most customers tent to purchase a smaller number of items per transaction. However, this category recorded the lowest average sales value compared to other basket size. Meanwhile, Large Basket contributed the lowest transaction volume and total revenue but achieved the highest average sales value, sugggesting that customers purchasing more items tend to spend significantly more per transaction. 

#### e) Top Product Category 
``Business Question`` : Which category product that generated highest revenue andtotal orders?
```sql
SELECT 
	category, 
	SUM(net_sales) AS total_sales,
	COUNT(*) AS total_orders, 
	ROUND(AVG(net_sales),2) AS avg_sales
FROM retailsales.vw_retail_sales
GROUP BY 1
ORDER BY total_sales DESC
LIMIT 5;
```
``Insight`` : Beauty products generated the highest total revenue, while Sports recorded the highest number of orders among all product categories. In addition, Beauty and Books categories achieved the highest revenue and average sales value, indicating stronger customer spending more per transaction compared to other categories.

### 3. Customer Analysis 
``purpose`` : to get understanding about customer behavior
#### a) Gender Analysis 
```sql
SELECT 
	customer_gender, 
	COUNT(DISTINCT(customer_id)) AS total_customers, 
	SUM(net_sales) AS total_sales, 
	ROUND(AVG(net_sales),2) AS avg_spending
FROM retailsales.vw_retail_sales 
GROUP BY customer_gender
ORDER BY total_sales DESC;
```
#### b) Age Segment Analysis 
```sql
SELECT
	customer_age_segment,
	COUNT(DISTINCT customer_id) AS total_customers,
	SUM(net_sales) AS total_sales,
	ROUND(AVG(net_sales),2) AS avg_spending
FROM retailsales.vw_retail_sales
GROUP BY customer_age_segment
ORDER BY total_sales DESC;
```
##### c) Customer Segment Analysis 
```sql
SELECT 
	customer_segment, 
	COUNT(DISTINCT customer_id) AS total_customers, 
	SUM(net_sales) AS total_sales, 
	ROUND(AVG(net_sales),2) AS avg_spending
FROM retailsales.vw_retail_sales
GROUP BY customer_segment 
ORDER BY total_sales DESC;
```
#### d) Spending Behavior
```sql
SELECT 
	sales_size, 
	COUNT(*) AS transaction_id, 
	SUM(net_sales) AS total_sales
FROM retailsales.vw_retail_sales
GROUP BY sales_size
ORDER BY total_sales DESC;
```

### 4. Regional, Channel, and Payment Method
``purpose`` : to understanding Region and channel perfomance 
#### a) Regional Perfomance 
```sql
SELECT 
	region, 
	COUNT(DISTINCT transaction_id) AS total_orders, 
	ROUND(AVG(net_sales),2) AS avg_sales, 
	SUM(net_sales) AS total_sales
FROM retailsales.vw_retail_sales 
GROUP BY region 
ORDER BY total_sales DESC;
```
#### b) Sales Channel Analysis 
```sql
SELECT 
	sales_channel, 
	COUNT(DISTINCT transaction_id) AS total_orders, 
	ROUND(AVG(net_sales),2) AS avg_sales,
	SUM(net_sales) AS total_sales
FROM retailsales.vw_retail_sales 
GROUP BY sales_channel 
ORDER BY total_sales DESC;
```
#### c) Payment Method Analysis 
```sql
SELECT 
	payment_method, 
	COUNT(DISTINCT transaction_id) AS total_orders, 
	ROUND(AVG(net_sales),2) AS avg_sales, 
	SUM(net_sales) AS total_sales
FROM retailsales.vw_retail_sales
GROUP BY payment_method
ORDER BY total_sales DESC;
```


