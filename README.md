# Data Warehouse Analytics Project — SQL Server

> *From raw flat files to a structured star schema — enabling efficient querying, KPI generation, and business intelligence reporting.*

---

## Overview

This project demonstrates the end-to-end creation of a **Data Warehouse using SQL Server** — transforming raw CSV flat files into a structured analytical schema and performing advanced SQL queries to generate meaningful business insights.

The project follows a **star schema approach** with clearly separated dimension and fact tables, enabling efficient reporting and scalable analytics.

---

## Database Setup

| Property | Value |
|---|---|
| **Database Name** | `DataWarehouseAnalytics` |
| **Analytics Schema** | `gold` — final curated layer for reporting |

>  **Important:** Running the setup script will **drop and recreate the database**, resulting in permanent data loss. Always ensure proper backups before execution.

---

## Data Model

The warehouse follows a classic **Star Schema** design:

```
                    ┌────────────────┐
                    │  dim_customers │
                    │  (Customer     │
                    │   Details)     │
                    └───────┬────────┘
                            │
┌───────────────┐    ┌──────▼───────┐    ┌───────────────┐
│  dim_products │    │  fact_sales  │    │  (extensible  │
│  (Product     ├────►  (Sales      │    │   for future  │
│   Details)    │    │  Transactions)    │   dimensions) │
└───────────────┘    └──────────────┘    └───────────────┘
```

### Fact Table

| Table | Description |
|---|---|
| `fact_sales` | Core transactional sales data — the central table of the schema |

### Dimension Tables

| Table | Description |
|---|---|
| `dim_customers` | Customer profile and demographic details |
| `dim_products` | Product catalog and category information |

---

## ETL Process

| Stage | Detail |
|---|---|
| **Extract** | Raw data imported from CSV flat files |
| **Transform** | Structured and cleaned into dimension and fact tables |
| **Load** | Loaded into the `gold` schema via `BULK INSERT` |

---

## Key Features

-  **Automated database creation and reset** — repeatable setup script
-  **Bulk data loading** from CSV flat files using `BULK INSERT`
-  **Star schema implementation** — dimension + fact table design
-  **Data exploration** using `INFORMATION_SCHEMA` queries
-  **KPI generation** using SQL aggregations
-  **Advanced analytics** using joins, subqueries, and window functions

---

## Key Analysis Performed

### General Business Insights
- Total Sales, Total Orders, Total Customers, Total Products
- Quantity Sold and Average Selling Price

### Customer Analysis
- Customer distribution by **Country** and **Gender**
- **Top & Lowest Revenue** generating customers

### Product Analysis
- Products segmented by **Category**
- **Average Cost** per category
- **Top 5 Best & Worst** performing products by revenue

### Sales Analysis
- Revenue breakdown by **Category** and **Customer**
- Sales distribution by **Country**
- **Time Range Analysis** of sales activity

---

## KPIs Generated

| KPI | Description |
|---|---|
|  **Total Sales** | Sum of all revenue generated |
|  **Quantity Sold** | Total units sold across all products |
|  **Average Selling Price** | Mean revenue per unit sold |
|  **Order Count** | Total number of distinct orders |
|  **Product Count** | Number of unique products in the catalog |
|  **Customer Count** | Total registered customers |
|  **Active Customers** | Customers who placed at least one order |

---

## Advanced SQL Concepts Used

```sql
-- Joins
INNER JOIN dim_customers ON fact_sales.customer_id = dim_customers.customer_id

-- Window Functions
DENSE_RANK() OVER (ORDER BY total_revenue DESC)

-- Date Functions
DATEDIFF(DAY, order_date, GETDATE())

-- Aggregates
SUM(), AVG(), COUNT()

-- Schema Exploration
SELECT * FROM INFORMATION_SCHEMA.TABLES
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
```

| Concept | Usage |
|---|---|
| **Joins** | Linking fact and dimension tables |
| **Aggregate Functions** | `SUM`, `AVG`, `COUNT` for KPI calculation |
| **Window Functions** | `DENSE_RANK` for top/bottom product rankings |
| **Date Functions** | `DATEDIFF` for time range analysis |
| **Subqueries** | Nested logic for filtered aggregations |
| **`GROUP BY` / `ORDER BY`** | Segmentation and result ordering |
| **`INFORMATION_SCHEMA`** | Data exploration and schema auditing |

---

##  Tools & Technologies

| Tool | Purpose |
|---|---|
| **SQL Server** | Database engine and warehouse host |
| **T-SQL** | Query language for all transformations and analysis |
| **CSV Flat Files** | Raw data source for the ETL pipeline |
| **Data Warehousing Concepts** | Star schema, ETL, layered architecture (`gold`) |

---

##  Use Cases

This project is ideal for:

-  Learning **Data Warehousing fundamentals** from scratch
-  Practicing **SQL for analytics** beyond basic CRUD
-  Building a **foundation for Power BI** or other BI visualization tools
-  Understanding **ETL pipeline design** with flat file sources

---

##  Outcome

-  Converted raw flat files into a **fully structured data warehouse**
-  Enabled **efficient querying and KPI generation** via a clean star schema
-  Built a **strong, scalable foundation** for business intelligence reporting

---

## Project Structure

```
 data-warehouse-analytics-sql
 ┣  01_database_setup.sql             # Database and schema creation script
 ┣  02_bulk_insert.sql                # ETL — bulk load from CSV files
 ┣  03_exploration_queries.sql        # Data exploration and schema audit
 ┣  04_kpi_analysis.sql               # KPI generation queries
 ┣  05_advanced_analytics.sql         # Joins, window functions, subqueries
 ┣  data/                             # Source CSV flat files
 ┗  README.md                         # Project documentation
```

---

## Connect

If you found this project useful or have suggestions, feel free to open an **Issue** or submit a **Pull Request**.
