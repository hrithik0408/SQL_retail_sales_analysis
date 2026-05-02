# Retail Sales Analysis SQL Project

## Project Overview
# 📊 Retail Sales Analysis

**Level:** Beginner  
**Database:** `pl_retail_db`

This project demonstrates SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. It involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.  

It is ideal for beginners starting their journey in data analysis and looking to build a solid foundation in SQL.

---

## 🎯 Objectives

1. **Database Setup**: Create and populate a retail sales database with the provided sales data.  
2. **Data Cleaning**: Identify and handle records with missing or null values.  
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory analysis to understand the dataset.  
4. **Business Analysis**: Use SQL queries to answer specific business questions and derive insights.

---

## 🗂 Project Structure

### 1. Database Setup
```sql
CREATE DATABASE sql_project_p1;
USE sql_project_p1;

CREATE TABLE retail_sales_analysis (
    transactions_id INT,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT NULL,
    category VARCHAR(50) NULL,
    quantity INT NULL,
    price_per_unit FLOAT NULL,
    cogs FLOAT NULL,
    total_sale FLOAT NULL
);
'''

**Table Columns:**
- `transaction_id` (Primary Key)  
- `sale_date` (Date)  
- `sale_time` (Time)  
- `customer_id` (Integer)  
- `gender` (Varchar)  
- `age` (Integer)  
- `category` (Varchar)  
- `quantity` (Integer)  
- `price_per_unit` (FLOAT)  
- `cogs` (FLOAT)  
- `total_sale` (FLOAT)  

---

## 📌 Example Queries

### 1. Average Monthly Sales per Year
```sql
SELECT 
    year,
    month,
    avg_sale
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER(
            PARTITION BY EXTRACT(YEAR FROM sale_date) 
            ORDER BY AVG(total_sale) DESC
        ) AS rnk
    FROM retail_sales_analysis
    GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
) AS t1
WHERE rnk = 1;
'''

### 2. Data Cleaning
-- Check for NULL values
'''sql
SELECT * FROM retail_sales_analysis
WHERE   
    transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;
'''
### 3. Data Exploration
-- Total records
SELECT COUNT(*) AS total_sale FROM retail_sales_analysis;

-- Unique customers
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM retail_sales_analysis;

-- Unique categories
SELECT COUNT(DISTINCT category) AS total_categories FROM retail_sales_analysis;

-- List categories
SELECT DISTINCT category FROM retail_sales_analysis;


## 🔎 Data Analysis & Business Queries

### Q1. Sales on a specific date
```sql
SELECT * 
FROM retail_sales_analysis
WHERE sale_date = '2022-11-05';
'''
### Q2. Clothing sales >4 units in Nov-2022
'''sql
SELECT *
FROM retail_sales_analysis
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantity >= 4;
'''

### Q3. Total sales per category
'''sql
SELECT 
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales_analysis
GROUP BY category;
'''

## 📑 Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.  
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.  
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.  
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.  

## 📑 Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.  
- **Trend Analysis**: Insights into sales trends across different months and shifts.  
- **Customer Insights**: Reports on top customers and unique customer counts per category.  

---

## ✅ Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries.  
The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.  

---

## 🚀 How to Use

1. **Clone the Repository**  
   ```bash
   git clone https://github.com/yourusername/SQL_retail_sales_analysis.git



