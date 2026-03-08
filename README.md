# 🛒 SQL Retail Sales Data Analysis

## 📌 Project Overview

**Project Title:** Retail Sales Data Analysis
**Level:** Beginner
**Tools Used:** SQL (MySQL / PostgreSQL)

This project demonstrates how SQL can be used to **clean, explore, and analyze retail sales data**. The objective of this project is to practice SQL skills commonly used by **Data Analysts** to extract meaningful insights from transactional data.

The project covers the full workflow of a typical data analysis task, including:

* Database creation
* Data cleaning and validation
* Exploratory data analysis (EDA)
* Solving real business questions using SQL

This project is part of my **Data Analyst learning journey and portfolio**.

---

# 🎯 Project Objectives

The main goals of this project are:

* Create and manage a retail sales database using SQL
* Perform **data cleaning and preprocessing**
* Explore the dataset to understand customer and sales patterns
* Solve **business-related analytical questions**
* Practice SQL techniques used in real-world data analysis

---

# 🗂 Dataset Structure

The dataset contains retail sales transactions with the following columns:

| Column Name       | Description               |
| ----------------- | ------------------------- |
| `transactions_id` | Unique transaction ID     |
| `sale_date`       | Date of the sale          |
| `sale_time`       | Time of the sale          |
| `customer_id`     | Unique customer ID        |
| `gender`          | Gender of the customer    |
| `age`             | Customer age              |
| `category`        | Product category          |
| `quantity`        | Number of items purchased |
| `price_per_unit`  | Price of a single item    |
| `cogs`            | Cost of goods sold        |
| `total_sale`      | Total transaction value   |

---

# ⚙️ Database Setup

The project begins by creating a database and a table to store retail sales data.

```sql
CREATE DATABASE sql_project_p1;

USE sql_project_p1;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(15),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale INT
);
```

---

# 🧹 Data Cleaning

Before analysis, the dataset was checked for **missing or null values**.

Tasks performed:

* Verified if any column contained NULL values
* Ensured data integrity
* Confirmed that the dataset was clean and ready for analysis

Example query used:

```sql
SELECT 
SUM(CASE WHEN transactions_id IS NULL THEN 1 ELSE 0 END) AS transactions_id,
SUM(CASE WHEN sale_date IS NULL THEN 1 ELSE 0 END) AS sale_date,
SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS customer_id
FROM retail_sales;
```

Result:
✔ No missing values were found.

---

# 🔎 Exploratory Data Analysis

Initial analysis was performed to understand the dataset.

Examples:

### Total number of sales

```sql
SELECT COUNT(*) AS total_sales
FROM retail_sales;
```

### Number of unique customers

```sql
SELECT COUNT(DISTINCT customer_id)
FROM retail_sales;
```

### Product categories available

```sql
SELECT DISTINCT category
FROM retail_sales;
```

---

# 📊 Business Questions & SQL Analysis

The following business questions were solved using SQL queries.

### 1️⃣ Sales on a Specific Date

Retrieve all transactions made on a specific date.

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-09-08';
```

---

### 2️⃣ Clothing Sales with High Quantity

Find clothing sales with quantity greater than 4 in November 2022.

```sql
SELECT transactions_id, category, sale_date,
SUM(quantiy) AS quantiy
FROM retail_sales
WHERE category = 'clothing'
AND quantiy >= 4
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
GROUP BY transactions_id, category, sale_date;
```

---

### 3️⃣ Total Sales by Category

```sql
SELECT category,
COUNT(total_sale) AS total_sale
FROM retail_sales
GROUP BY category;
```

---

### 4️⃣ Average Age of Beauty Customers

```sql
SELECT AVG(age) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

---

### 5️⃣ Transactions Greater Than 1000

```sql
SELECT transactions_id,
total_sale
FROM retail_sales
WHERE total_sale > 1000
ORDER BY total_sale DESC;
```

---

### 6️⃣ Transactions by Gender and Category

```sql
SELECT COUNT(transactions_id) AS transactions,
gender,
category
FROM retail_sales
GROUP BY gender, category;
```

---

### 7️⃣ Best Selling Month Each Year

Uses **window functions and ranking**.

```sql
WITH best_selling_summary AS (
SELECT MONTH(sale_date) AS month,
YEAR(sale_date) AS year,
AVG(total_sale) AS avg_sale,
RANK() OVER (
PARTITION BY YEAR(sale_date)
ORDER BY AVG(total_sale) DESC
) AS rank_
FROM retail_sales
GROUP BY sale_date
)
SELECT *
FROM best_selling_summary
WHERE rank_ = 1;
```

---

### 8️⃣ Top 5 Customers by Total Sales

```sql
SELECT customer_id,
SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;
```

---

### 9️⃣ Unique Customers per Category

```sql
SELECT COUNT(DISTINCT customer_id) AS customers,
category
FROM retail_sales
GROUP BY category;
```

---

### 🔟 Sales by Time Shift

Orders were grouped into **Morning, Afternoon, and Evening** shifts.

```sql
WITH hourly_shift AS (
SELECT *,
CASE
WHEN HOUR(sale_time) <= 12 THEN 'Morning'
WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END AS shift
FROM retail_sales
)
SELECT shift,
COUNT(*) AS total_orders
FROM hourly_shift
GROUP BY shift;
```

---

# 📈 Key Insights

Some important insights from the analysis:

* Multiple product categories contribute to overall sales.
* Certain transactions exceed **1000 in total sales**, indicating high-value purchases.
* Sales vary across **different months and time shifts**.
* Identifying **top customers** helps businesses target high-value buyers.

---

# 🚀 Skills Demonstrated

This project highlights the following **Data Analyst skills**:

* SQL Database Creation
* Data Cleaning & Validation
* Exploratory Data Analysis (EDA)
* Aggregation Functions
* Joins and Filtering
* Window Functions
* Business Problem Solving using SQL

---

# 👨‍💻 Author

**Vedant Jamdade**
B.Tech Student | Aspiring Data Analyst

This project is part of my **Data Analytics portfolio** showcasing SQL skills used for data exploration and business analysis.

---

⭐ If you found this project useful, feel free to **star the repository**.
