📊 Data Warehouse Analytics Project (SQL)
📖 Overview

This project demonstrates the creation of a Data Warehouse using SQL Server by transforming raw flat files into a structured schema and performing analytical queries to generate business insights.

The project follows a star schema approach with dimension and fact tables, enabling efficient reporting and analytics.

🏗️ Database Setup
🔹 Database Name

DataWarehouseAnalytics

🔹 Schema

gold → Final curated layer for analytics

📂 Data Model
⭐ Fact Table

fact_sales → Contains transactional sales data

📘 Dimension Tables

dim_customers → Customer details

dim_products → Product information

⚙️ Key Features

🗄️ Automated database creation and reset

📥 Bulk data loading from CSV (Flat Files)

🧱 Star schema design implementation

🔍 Data exploration using SQL queries

📊 KPI generation using SQL

📈 Advanced analytics using joins and window functions

🚀 ETL Process

Extract

Data imported from CSV flat files

Transform

Structured into dimension and fact tables

Load

Loaded into gold schema using BULK INSERT

📊 Key Analysis Performed
🔹 General Insights

Total Sales

Total Orders

Total Customers

Total Products

Quantity Sold

Average Selling Price

🔹 Customer Analysis

Customers by Country

Customers by Gender

Top & Lowest Revenue Customers

🔹 Product Analysis

Products by Category

Average Cost per Category

Top 5 Best & Worst Performing Products

🔹 Sales Analysis

Revenue by Category

Revenue by Customer

Sales Distribution by Country

Sales Time Range Analysis

📌 KPIs Generated

💰 Total Sales

📦 Quantity Sold

💵 Average Selling Price

🧾 Order Count

🛍️ Product Count

👥 Customer Count

✅ Customers Who Placed Orders

🧠 Advanced SQL Concepts Used

Joins (Inner Join)

Aggregate Functions (SUM, AVG, COUNT)

Window Functions (DENSE_RANK)

Date Functions (DATEDIFF)

Group By & Order By

Subqueries

Data Exploration via INFORMATION_SCHEMA

⚠️ Important Note

Running the script will drop and recreate the database, resulting in permanent data loss.
Ensure proper backups before execution.

🛠️ Tools & Technologies

SQL Server

T-SQL

Data Warehousing Concepts

CSV Flat Files

📂 Use Case

This project is ideal for:

Learning Data Warehousing fundamentals

Practicing SQL for analytics

Building a foundation for Power BI / Data Visualization

💡 Outcome

Converted raw flat files into a structured data warehouse

Enabled efficient querying and analytics

Built a strong foundation for business intelligence reporting
