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
- **Database Creation**: Create a database named `pl_retail_db`.  
- **Table Creation**: Create a table named `retail_sales_analysis` to store the sales data.  

**Table Columns:**
- `transaction_id` (Primary Key)  
- `sale_date` (Date)  
- `sale_time` (Time)  
- `customer_id` (Integer)  
- `gender` (Varchar)  
- `age` (Integer)  
- `category` (Varchar)  
- `quantity` (Integer)  
- `price_per_unit` (Decimal)  
- `cogs` (Decimal)  
- `total_sale` (Decimal)  

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

