CREATE DATABASE tableau_project;
USE tableau_project;
SELECT * FROM pizza_sale;

SET sql_safe_updates = 0;

UPDATE pizza_sale
SET order_date = STR_TO_DATE(order_date, '%d/%m/%y');

ALTER TABLE pizza_sale
MODIFY order_date DATE;

ALTER TABLE pizza_sale
MODIFY order_time TIME;

SELECT SUM(total_price) AS Total_revenue FROM pizza_sale;

SELECT DISTINCT SUM(total_price) / COUNT(DISTINCT order_id) AS Average_order_value FROM pizza_sale;

SELECT SUM(quantity) AS Total_pizzas_sold FROM pizza_sale;

SELECT COUNT(DISTINCT order_id) AS TOTAL_ORDERS FROM pizza_sale;

SELECT SUM(quantity) / COUNT(DISTINCT order_id) AS Average_pizzas_per_order FROM pizza_sale;

-- Hourly trend for total pizzas sold

SELECT HOUR(order_time) AS Order_hour, SUM(quantity) AS Total_pizas_sold FROM pizza_sale
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);

-- Weekly trend for total orders

SELECT WEEK(order_date) AS Order_week, YEAR(order_date) , COUNT(DISTINCT order_id) AS Total_pizzas_orders FROM pizza_sale
GROUP BY WEEK (order_date),YEAR(order_date)
ORDER BY WEEK (order_date),YEAR(order_date);

-- Percentage of sales by pizza category
 
SELECT pizza_category, SUM(total_price) AS Total_sales, SUM(total_price)*100 / (SELECT SUM(total_price) FROM pizza_sale
WHERE MONTH(order_date) = 1) AS Percentage_of_total_sales  FROM pizza_sale
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

-- Percentage of sales by pizza size

SELECT pizza_size, cast(SUM(total_price) AS DECIMAL(10,2)) AS Total_sales, 
CAST(SUM(total_price)*100 / (SELECT SUM(total_price) FROM pizza_sale
WHERE QUARTER(order_date) = 1) AS DECIMAL (10,2)) AS Percentage_of_total_sales  FROM pizza_sale
WHERE QUARTER(order_date) = 1
GROUP BY pizza_size
ORDER BY Percentage_of_total_sales DESC;


