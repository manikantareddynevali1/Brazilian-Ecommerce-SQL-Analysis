# Brazilian-Ecommerce-SQL-Analysis

# 🛒 Brazilian E-Commerce SQL Analysis

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-336791?style=flat-square&logo=postgresql&logoColor=white)
![Database](https://img.shields.io/badge/Database-Relational-orange?style=flat-square)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-yellow?style=flat-square)
![Made With](https://img.shields.io/badge/Made%20With-%E2%9D%A4%EF%B8%8F%20and%20SQL-red?style=flat-square)

An end-to-end **SQL data analysis project** built on the real-world **Brazilian E-Commerce Public Dataset (Olist)**, using **PostgreSQL** to extract meaningful business insights across sales, customers, sellers, logistics, payments, and reviews.

---

## 📋 Project Overview

This project demonstrates practical, production-style SQL skills applied to a large, multi-table, real-world e-commerce dataset. The goal was to simulate the kind of analytical work a **Data Analyst** or **Software Engineer** would perform when answering business questions directly from a relational database — without relying on external BI tools or scripting languages.

The project covers the complete analytical workflow:

- 🗄️ Designing and understanding a normalized relational schema
- 🔗 Writing complex multi-table joins across 9 interconnected tables
- 📊 Aggregating and summarizing data for business reporting
- 🧮 Building CTEs, subqueries, and window functions for advanced analytics
- ⚡ Creating views and indexes to simulate real-world query optimization
- 💡 Translating raw data into **20+ actionable business insights**

> **Note:** This repository currently contains **only the PostgreSQL SQL analysis**. Visualization layers (Power BI, Python EDA) are planned as future enhancements — see [Future Improvements](#-future-improvements).

---

## 📊 Dataset Information

**Source:** [Brazilian E-Commerce Public Dataset by Olist — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

**Description:**
The dataset contains real, anonymized commercial data from **Olist**, the largest department store marketplace in Brazil. It includes information on ~100,000 orders placed between 2016 and 2018 across multiple marketplaces, covering order status, pricing, payment, freight performance, customer location, product attributes, and post-purchase customer reviews.

**Number of Tables:** 9 core relational tables

### Table Descriptions

| Table Name | Description |
|---|---|
| `customers` | Customer ID and location (city, state, zip code) |
| `orders` | Order status and key timestamps (purchase, approval, delivery) |
| `order_items` | Line-item level detail — products, sellers, price, freight |
| `order_payments` | Payment type, installments, and payment value per order |
| `order_reviews` | Customer review scores and comments per order |
| `products` | Product category, dimensions, and weight |
| `sellers` | Seller ID and location |
| `geolocation` | Zip code prefix mapped to latitude/longitude |
| `product_category_name_translation` | English translation of Portuguese category names |

### Primary & Foreign Keys

| Table | Primary Key | Foreign Key(s) |
|---|---|---|
| `customers` | `customer_id` | — |
| `orders` | `order_id` | `customer_id` → `customers` |
| `order_items` | `order_id`, `order_item_id` | `order_id` → `orders`, `product_id` → `products`, `seller_id` → `sellers` |
| `order_payments` | `order_id`, `payment_sequential` | `order_id` → `orders` |
| `order_reviews` | `review_id` | `order_id` → `orders` |
| `products` | `product_id` | `product_category_name` → `product_category_name_translation` |
| `sellers` | `seller_id` | — |
| `geolocation` | `geolocation_zip_code_prefix` | — |
| `product_category_name_translation` | `product_category_name` | — |

---

## 🗂️ Database Schema

> 📌 **Placeholder:** Insert the ER Diagram image below.

```
/screenshots/er-diagram.png
```

![ER Diagram](./screenshots/er-diagram.png)

---

## 🧠 SQL Concepts Covered

This project applies a broad range of SQL techniques, from foundational querying to advanced analytical constructs:

| Category | Concepts |
|---|---|
| **Core Querying** | `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING` |
| **Aggregation** | `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()` |
| **Joins** | `INNER JOIN`, `LEFT JOIN` |
| **Conditional Logic** | `CASE WHEN`, `COALESCE` |
| **Advanced Querying** | Subqueries, Common Table Expressions (CTEs) |
| **Analytics** | Window Functions (`RANK()`, `ROW_NUMBER()`, `LAG()`, running totals) |
| **Performance & Reusability** | Views, Indexes |
| **Date & Time** | `DATE_PART`, `EXTRACT`, `AGE`, date truncation for time-series analysis |

---

## 📁 Folder Structure

```
brazilian-ecommerce-sql-analysis/
│
├── data/                          # Raw CSV files (Olist dataset)
│   ├── olist_customers_dataset.csv
│   ├── olist_orders_dataset.csv
│   ├── olist_order_items_dataset.csv
│   ├── olist_order_payments_dataset.csv
│   ├── olist_order_reviews_dataset.csv
│   ├── olist_products_dataset.csv
│   ├── olist_sellers_dataset.csv
│   ├── olist_geolocation_dataset.csv
│   └── product_category_name_translation.csv
│
├── sql/
│   ├── 01_schema_creation.sql      # Table definitions, constraints, keys
│   ├── 02_data_import.sql          # COPY commands for CSV import
│   ├── 03_business_questions.sql   # All analytical queries
│   ├── 04_views.sql                # Reusable views
│   └── 05_indexes.sql              # Indexing for performance
│
├── screenshots/
│   ├── er-diagram.png
│   ├── tables-overview.png
│   └── query-outputs/
│
├── README.md
└── LICENSE
```

---

## ❓ Business Questions Solved

| # | Business Question |
|---|---|
| 1 | What is the total number of orders placed each year? |
| 2 | What is the month-over-month revenue trend? |
| 3 | Who are the top 10 customers by total spend? |
| 4 | Which product categories generate the highest revenue? |
| 5 | What is the average delivery time across all orders? |
| 6 | Which orders were delivered late compared to the estimated date? |
| 7 | What is the average review score by product category? |
| 8 | Which sellers have the highest total sales? |
| 9 | What is the distribution of payment types used by customers? |
| 10 | What percentage of orders are paid in installments? |
| 11 | Which states have the highest number of customers? |
| 12 | What is the average freight value by region? |
| 13 | Which product categories have the highest return/cancellation rate? |
| 14 | What is the correlation between delivery delay and review score? |
| 15 | Who are the top 5 sellers by average customer rating? |
| 16 | What is the average order value (AOV) per state? |
| 17 | Which month recorded the highest number of order cancellations? |
| 18 | What is the running total of monthly revenue (using window functions)? |
| 19 | How does order volume vary by day of the week? |
| 20 | What is the customer repeat purchase rate? |

---

## 💡 Key Insights

- 📈 **Order volume grew significantly year-over-year**, with the sharpest growth observed between 2017 and 2018.
- 🏆 A small subset of product categories (bed & bath, health & beauty, sports & leisure) contribute a disproportionately large share of total revenue.
- 🚚 **Delivery delays are strongly correlated with lower review scores** — late orders receive noticeably lower average ratings.
- 💳 The majority of customers prefer **credit card payments**, often opting to pay in installments rather than a single payment.
- 🌎 **São Paulo (SP)** accounts for the largest share of both customers and sellers, reflecting its role as Brazil's commercial hub.
- ⭐ Top-performing sellers maintain both **high order volume and high review scores**, indicating consistent service quality drives repeat business.
- 📦 **Freight cost as a percentage of order value is significantly higher for customers in remote/northern states**, highlighting logistics challenges outside major hubs.
- 🔁 **Repeat purchase rate is relatively low**, suggesting an opportunity for customer retention strategies.
- 📅 Order volume peaks on **specific weekdays**, with a noticeable dip during weekends — useful for staffing and promotional planning.
- ⚠️ A measurable percentage of orders are **cancelled or undelivered**, concentrated around specific months, which may correlate with logistics or demand-surge issues.

---

## 🛠️ Tools Used

| Tool | Purpose |
|---|---|
| **PostgreSQL** | Relational database and SQL query engine |
| **pgAdmin** | Database management and query execution GUI |
| **SQL** | Data extraction, transformation, and analysis |
| **Git & GitHub** | Version control and project hosting |

---

## 🎯 Skills Demonstrated

- ✅ Advanced SQL Querying
- ✅ Relational Database Design
- ✅ Data Analysis & Business Intelligence
- ✅ Query Optimization (Indexing, Views)
- ✅ Business Analytics & Insight Generation
- ✅ Analytical Problem Solving

---

## 🖼️ Screenshots

> 📌 **Placeholders — replace with actual screenshots**

**PostgreSQL Database Tables**
```
./screenshots/tables-overview.png
```

**Sample Query Output**
```
./screenshots/query-outputs/sample-output-1.png
```

**ER Diagram**
```
./screenshots/er-diagram.png
```

---

## ▶️ How to Run the Project

### 1. Install PostgreSQL
Download and install PostgreSQL from the [official website](https://www.postgresql.org/download/). Optionally install **pgAdmin** for a GUI-based workflow.

### 2. Create the Database
```sql
CREATE DATABASE olist_ecommerce;
```

Then run the schema creation script to build all tables:
```bash
psql -U your_username -d olist_ecommerce -f sql/01_schema_creation.sql
```

### 3. Import CSV Files
Download the dataset from Kaggle and place the CSV files in the `/data` folder, then run:
```sql
COPY customers FROM '/absolute/path/to/data/olist_customers_dataset.csv'
DELIMITER ',' CSV HEADER;
```

Repeat for each table, or run the provided script:
```bash
psql -U your_username -d olist_ecommerce -f sql/02_data_import.sql
```

### 4. Execute SQL Queries
Run the business analysis queries:
```bash
psql -U your_username -d olist_ecommerce -f sql/03_business_questions.sql
```

Or open the `.sql` files directly in **pgAdmin's Query Tool** to explore and run them interactively.

---

## 🚀 Future Improvements

The following enhancements are planned for future versions of this project:

- 📊 **Power BI Interactive Dashboard** — for visual, stakeholder-friendly reporting
- 🐍 **Python Exploratory Data Analysis (EDA)** — using Pandas, Matplotlib, and Seaborn
- 📈 **Advanced Visualizations** — trend analysis, geo-mapping, and cohort charts
- 👥 **Customer Segmentation** — RFM analysis and clustering
- 🔮 **Predictive Analytics** — delivery delay prediction and churn modeling using ML

---

## 🤝 Connect With Me

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat-square&logo=linkedin)](https://linkedin.com/in/your-profile)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black?style=flat-square&logo=github)](https://github.com/your-username)

> Replace the links above with your actual LinkedIn and GitHub profile URLs.

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](./LICENSE) file for details.

---

<p align="center">⭐ If you found this project useful, consider giving it a star!</p>

