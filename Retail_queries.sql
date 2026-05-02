CREATE DATABASE sql_project_p1;
USE sql_project_p1;

CREATE TABLE retail_sales_analysis (
    transactions_id INT ,
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

SELECT 
    COUNT(*)
FROM retail_sales_analysis

-- data cleaning
SELECT * FROM retail_sales_analysis
WHERE 	
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR
    sale_time IS NULL
    OR
    customer_id IS NULL
    OR
    gender IS NULL
    OR
    age IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    price_per_unit IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL
    
 -- Data Exploration 
 -- HOW many slaes we have
 SELECT COUNT(*) AS total_sale FROM retail_sales_analysis
 -- how many unique customer we have 
 SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail_sales_analysis
 -- how many unique category we have
 SELECT COUNT(DISTINCT category) AS total_sale FROM retail_sales_analysis
 -- to see those unique category
 SELECT DISTINCT category FROM retail_sales_analysis
 
 -- Data Analysis & Business key  problem & answere
 -- My Analysis & Findings
 -- Q1.Write a SQL query to retrieve all columns for sales made on '2022-11-05'
 SELECT * FROM retail_sales_analysis
 WHERE sale_date='2022-11-05'
 
 -- Q2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT 
  *
FROM retail_sales_analysis
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4
    
 -- Q3.Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales_analysis
GROUP BY 1
 
 -- Q4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales_analysis
WHERE category = 'Beauty'
 
 -- Q5.Write a SQL query to find all transactions where the total_sale is greater than 1000.
 SELECT * FROM retail_sales_analysis
WHERE total_sale > 1000
 
 -- Q6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
 SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales_analysis
GROUP 
    BY 
    category,
    gender
ORDER BY 1
 
 -- Q7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
    year,
    month,
    avg_sale
FROM 
(    
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


 -- Q8.**Write a SQL query to find the top 5 customers based on the highest total sales **
 SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales_analysis
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

 -- Q9.Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales_analysis
GROUP BY category

 -- Q10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales_analysis
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift