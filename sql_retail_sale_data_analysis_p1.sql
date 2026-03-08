-- SQL Retail sales Analysis - P1
CREATE DATABASE sql_project_p1;

USE sql_project_p1;

-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales (
       transactions_id INT PRIMARY KEY,
       sale_date DATE, 	
       sale_time TIME,	
       customer_id INT,
       gender VARCHAR(10),	
       age INT,
       category	VARCHAR(15),
       quantiy INT,
       price_per_unit FLOAT,
       cogs	FLOAT,
       total_sale INT
       );

SELECT * FROM retail_sales;

SELECT COUNT(*) FROM retail_sales;

-- Data Cleaning & Data preprocessing

-- checking for how many null values we have in our dataset 
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
-- There is no null value in our dataset, so we can proccess our data for analysis.
 
-- If we have any null value in our dataset, we can handle it by using the following query

SELECT *
FROM retail_sales
WHERE transactions_id IS NULL
OR sale_date IS NULL
OR customer_id IS NULL
OR gender IS NULL
OR age IS NULL
OR category IS NULL
OR quantiy IS NULL
OR price_per_unit IS NULL
OR cogs IS NULL
OR total_sale IS NULL;


-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) AS total_sale FROM retail_sales;

-- How many unique customer we have?
SELECT  COUNT(DISTINCT(customer_id)) FROM retail_sales;

-- How many unique category we have?
SELECT Distinct(category) FROM retail_sales;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-09-08'
SELECT * FROM retail_sales
WHERE sale_date = '2022-09-08';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT transactions_id, category, sale_date,
SUM(quantiy) AS quantiy 
FROM retail_sales
WHERE category = 'clothing'
AND quantiy>=4
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
GROUP BY transactions_id, category, sale_date;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category, COUNT(total_sale) AS total_sale FROM retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT category, AVG(age) AS Avg_age FROM retail_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT transactions_id AS transactions,
total_sale
FROM retail_sales
WHERE total_sale>1000
ORDER BY total_sale DESC;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT COUNT(transactions_id) AS transactions_id,
gender, category
FROM retail_sales
GROUP BY gender, category
ORDER BY transactions_id DESC;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
WITH best_selling_summary AS (
SELECT MONTH(sale_date) AS month,
YEAR(sale_date) AS year,
AVG(total_sale) AS avg_sale,
RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS RANK_
FROM retail_sales
GROUP BY sale_date)
SELECT * FROM best_selling_summary
WHERE RANK_=1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id AS customers,
SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY customers
ORDER BY total_sale DESC
LIMIT 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT COUNT(DISTINCT(customer_id)) AS customer, category
FROM retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
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

-- END of Project --

   
    
