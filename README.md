# 🛒 SQL Retail Sales Data Analysis

## 📌 Project Overview

**Project Title:** Retail Sales Data Analysis
**Level:** Beginner
**Tools Used:** SQL (MySQL)

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
SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS customer_id,
SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS gender,
SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS age,
SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) AS category,
SUM(CASE WHEN quantiy IS NULL THEN 1 ELSE 0 END) AS quantiy,
SUM(CASE WHEN price_per_unit IS NULL THEN 1 ELSE 0 END) AS price_per_unit,
SUM(CASE WHEN cogs IS NULL THEN 1 ELSE 0 END) AS cogs,
SUM(CASE WHEN total_sale IS NULL THEN 1 ELSE 0 END) AS total_sale
FROM retail_sales;
```

Result:
✔ No missing values were found.

---

# 🔎 Exploratory Data Analysis

Initial analysis was performed to understand the dataset.

Examples:

### Total number of sales
How many sales we have

```sql
SELECT COUNT(*) AS total_sales
FROM retail_sales;
```

### Number of unique customers
How many unique customer we have
```sql
SELECT COUNT(DISTINCT customer_id)
FROM retail_sales;
```

### Product categories available
How many unique category we have
```sql
SELECT DISTINCT(category)
FROM retail_sales;
```

---

# 📊 Business Questions & SQL Analysis

The following business questions were solved using SQL queries.

### 1️⃣ Sales on a Specific Date

Write a SQL query to retrieve all columns for sales made on '2022-09-08'

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
AND quantiy>=4
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
GROUP BY transactions_id, category, sale_date;
```

---

### 3️⃣ Total Sales by Category

Write a SQL query to calculate the total sales (total_sale) for each category.

```sql
SELECT category,
COUNT(total_sale) AS total_sale
FROM retail_sales
GROUP BY category;
```

---

### 4️⃣ Average Age of Beauty Customers

Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

```sql
SELECT category,
AVG(age) AS Avg_age FROM retail_sales
WHERE category = 'Beauty';
```

---

### 5️⃣ Transactions Greater Than 1000

Write a SQL query to find all transactions where the total_sale is greater than 1000.

```sql
SELECT transactions_id,
total_sale
FROM retail_sales
WHERE total_sale > 1000
ORDER BY total_sale DESC;
```

---

### 6️⃣ Transactions by Gender and Category

Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

```sql
SELECT COUNT(transactions_id) AS transactions_id,
gender, category
FROM retail_sales
GROUP BY gender, category
ORDER BY transactions_id DESC;
```

---

### 7️⃣ Best Selling Month Each Year

Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

Uses **window functions and ranking**.

```sql
WITH best_selling_summary AS (
SELECT MONTH(sale_date) AS month,
YEAR(sale_date) AS year,
AVG(total_sale) AS avg_sale,
RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS RANK_
FROM retail_sales
GROUP BY sale_date)
SELECT * FROM best_selling_summary
WHERE RANK_=1;
```

---

### 8️⃣ Top 5 Customers by Total Sales

 Write a SQL query to find the top 5 customers based on the highest total sales 
 
```sql
SELECT customer_id AS customers,
SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY customers
ORDER BY total_sale DESC
LIMIT 5;
```

---

### 9️⃣ Unique Customers per Category

Write a SQL query to find the number of unique customers who purchased items from each category.
 
```sql
SELECT COUNT(DISTINCT(customer_id)) AS customer,
category
FROM retail_sales
GROUP BY category;
```

---

### 🔟 Sales by Time Shift

Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

```sql
WITH hourly_shift AS (
SELECT * ,
CASE
    WHEN HOUR(sale_time) <= 12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
END AS shift
FROM retail_sales)
SELECT shift, COUNT(*) AS total_order
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
