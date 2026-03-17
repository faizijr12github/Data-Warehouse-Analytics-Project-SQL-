/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouseAnalytics' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, this script creates a schema called gold
	
WARNING:
    Running this script will drop the entire 'DataWarehouseAnalytics' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'DataWarehouseAnalytics' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouseAnalytics')
BEGIN
    ALTER DATABASE DataWarehouseAnalytics SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouseAnalytics;
END;
GO

-- Create the 'DataWarehouseAnalytics' database
CREATE DATABASE DataWarehouseAnalytics;
GO

USE DataWarehouseAnalytics;
GO

-- Create Schemas

CREATE SCHEMA gold;
GO

CREATE TABLE gold.dim_customers(
	customer_key int,
	customer_id int,
	customer_number nvarchar(50),
	first_name nvarchar(50),
	last_name nvarchar(50),
	country nvarchar(50),
	marital_status nvarchar(50),
	gender nvarchar(50),
	birthdate date,
	create_date date
);
GO

CREATE TABLE gold.dim_products(
	product_key int ,
	product_id int ,
	product_number nvarchar(50) ,
	product_name nvarchar(50) ,
	category_id nvarchar(50) ,
	category nvarchar(50) ,
	subcategory nvarchar(50) ,
	maintenance nvarchar(50) ,
	cost int,
	product_line nvarchar(50),
	start_date date 
);
GO

CREATE TABLE gold.fact_sales(
	order_number nvarchar(50),
	product_key int,
	customer_key int,
	order_date date,
	shipping_date date,
	due_date date,
	sales_amount int,
	quantity tinyint,
	price int 
);
GO

TRUNCATE TABLE gold.dim_customers;
GO

BULK INSERT gold.dim_customers
FROM 'C:\Users\faiza\Downloads\cd6ca6c9bd83423ba5eabf06ab3d50f2\sql-data-analytics-project\datasets\flat-files\dim_customers.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

TRUNCATE TABLE gold.dim_products;
GO

BULK INSERT gold.dim_products
FROM 'C:\Users\faiza\Downloads\cd6ca6c9bd83423ba5eabf06ab3d50f2\sql-data-analytics-project\datasets\flat-files\dim_products.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

TRUNCATE TABLE gold.fact_sales;
GO

BULK INSERT gold.fact_sales
FROM 'C:\Users\faiza\Downloads\cd6ca6c9bd83423ba5eabf06ab3d50f2\sql-data-analytics-project\datasets\flat-files\fact_sales.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO


--

select
distinct(category)
from gold.dim_products
--
select sales_amount from gold.fact_sales
--
select top 5 * from gold.dim_customers
--
select birthdate from gold.dim_customers
--
select avg(DATEDIFF(year,birthdate,GETDATE())) Avg_Age from gold.dim_customers
-- Database Explortion
select * from INFORMATION_SCHEMA.TABLES
-- columns Exploration
select * from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'dim_customers'
-- Explore all countries our customer come from
select distinct(country) from gold.dim_customers
-- Explore all the categories
select top 5 * from gold.dim_products

select
distinct(category),
subcategory,
product_name
from gold.dim_products
order by 1,2,3
-- Find the date of first and last order
select
min(order_date) Min_Order_Date,
max(order_date) Max_Order_Date
from
gold.fact_sales
-- How many years of sales done?
select
DATEDIFF(year,min(order_date),max(order_date)) Years_of_Sale
from
gold.fact_sales
-- Find the youngest and the oldest customer
select
min(DATEDIFF(year,birthdate,getdate())) as youngestCustomerAge,
max(DATEDIFF(year,birthdate,getdate())) as oldestCustomerAge
from gold.dim_customers
-- Find the total sales
select
sum(sales_amount) TotalSales
from
gold.fact_sales
-- Find how many items are sold?
select
sum(quantity) itemsSold
from
gold.fact_sales
-- Find avg selling price
select
avg(price) AvgSelingPrice
from
gold.fact_sales
-- Find total no of orders
select
count(order_number) OrderCount
from
gold.fact_sales
-- Find total no of products
select
count(distinct(product_key)) ProductCount
from
gold.dim_products
-- Find total no of customers
select
count(distinct(customer_key)) CustomerCount
from
gold.dim_customers
-- Find total no of customers placed an order
select
count(distinct(customer_key)) CustomerCountPlacedOrder
from
gold.fact_sales
-- Create KPI report
select
'Total Sales' as KPI, sum(sales_amount) Value from gold.fact_sales
union all
select
'Quantity Sold' as KPI, sum(quantity) Value from gold.fact_sales
union all
select
'Avg Selling Price' as KPI, avg(price) Value from gold.fact_sales
union all
select
'Order Count' as KPI, count(order_number) Value from gold.fact_sales
union all
select
'Product Count' as KPI, count(distinct(product_key)) Value from gold.dim_products
union all
select 
'Customer Count' as KPI, count(distinct(customer_key)) Value from gold.dim_customers
union all
select 
'Customers placed Orders' as KPI, count(distinct(customer_key)) Value from gold.fact_sales

-- Find total customers by country
select
country,
count(customer_id) CustomerCount
from gold.dim_customers
group by country
order by CustomerCount desc
-- Find total customers by gender
select
gender,
count(customer_id) CustomerCount
from gold.dim_customers
group by gender
order by CustomerCount desc
-- Find total products by category
select
category,
count(product_id) ProductCount
from gold.dim_products
group by category
order by ProductCount desc
-- What is avg cost in each category
select
category,
avg(cost) AvgCost
from gold.dim_products
group by category
order by AvgCost desc
-- what is total revenue generated for each category
select
dp.category,
sum(fs.sales_amount) RevenueGenerated
from gold.dim_products dp
inner join gold.fact_sales fs
on dp.product_key = fs.product_key
group by dp.category
order by RevenueGenerated desc
-- find total revenue generated by each customer
select
dc.customer_key,
dc.first_name,
sum(fs.sales_amount) RevenueGenerated
from gold.dim_customers dc
inner join gold.fact_sales fs
on dc.customer_key = fs.customer_key
group by dc.customer_key, dc.first_name
order by RevenueGenerated desc
-- what is distribution of sold items accross countries
select
dc.country,
sum(fs.quantity) QuantitySold
from gold.dim_customers dc
inner join gold.fact_sales fs
on dc.customer_key = fs.customer_key
group by dc.country
order by QuantitySold desc

-- Which 5 products generate highest revenue
select
top 5
dp.product_key,
dp.product_name,
sum(fs.sales_amount) TotalSales
from gold.dim_products dp
inner join gold.fact_sales fs
on dp.product_key = fs.product_key
group by 
dp.product_key,
dp.product_name
order by TotalSales desc

-- What are the 5 most worst performing products in terms of sales
select
top 5
dp.product_key,
dp.product_name,
sum(fs.sales_amount) TotalSales
from gold.dim_products dp
inner join gold.fact_sales fs
on dp.product_key = fs.product_key
group by 
dp.product_key,
dp.product_name
order by TotalSales asc

-- Which 5 products generate highest revenue (window functions)
select * from 
(
select
dp.product_key,
dp.product_name,
sum(fs.sales_amount) TotalSales,
DENSE_RANK() over(order by sum(fs.sales_amount) desc) Ranking
from gold.dim_products dp
inner join gold.fact_sales fs
on dp.product_key = fs.product_key
group by 
dp.product_key,
dp.product_name
) t
where t.Ranking between 1 and 5
-- Top 10 customers with higest revenue
select
top 10
dc.customer_key,
dc.first_name,
sum(fs.sales_amount) TotalSales
from gold.dim_customers dc
inner join gold.fact_sales fs
on dc.customer_key = fs.customer_key
group by 
dc.customer_key,
dc.first_name
order by TotalSales desc
-- Top 3 customers with lowest revenue 
select
top 3
dc.customer_key,
dc.first_name,
sum(fs.sales_amount) TotalSales
from gold.dim_customers dc
inner join gold.fact_sales fs
on dc.customer_key = fs.customer_key
group by 
dc.customer_key,
dc.first_name
order by TotalSales asc