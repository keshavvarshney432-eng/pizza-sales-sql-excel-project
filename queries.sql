-- =========================================
-- PIZZA SALES ANALYSIS USING SQL (MYSQL)
-- =========================================


-- A. KPIs
-- -----------------------------------------

-- 1. Total Revenue
-- Calculates total revenue generated
SELECT SUM(total_price) AS Total_Revenue 
FROM pizza_sales;


-- 2. Average Order Value
-- Average revenue per order
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS AOV 
FROM pizza_sales;


-- 3. Total Pizzas Sold
-- Total quantity of pizzas sold
SELECT SUM(quantity) AS pizza_sold 
FROM pizza_sales;


-- 4. Total Orders
-- Total number of unique orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales;


-- 5. Average Pizzas Per Order
-- Average pizzas ordered per order
SELECT ROUND(SUM(quantity) / COUNT(DISTINCT order_id), 2) 
AS Avg_Pizzas_per_order
FROM pizza_sales;



-- B. Daily Trend for Total Orders
-- Orders count per day of week
SELECT DAYNAME(order_date) AS order_day, 
COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DAYNAME(order_date);



-- C. Hourly Trend for Orders
-- Orders per hour
SELECT HOUR(order_time) as order_hours, 
COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);



-- D. % of Sales by Pizza Category
-- Contribution of each category in revenue
SELECT pizza_category, 
ROUND(SUM(total_price), 2) as total_revenue,
ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales), 2) AS PCT
FROM pizza_sales
GROUP BY pizza_category;



-- E. % of Sales by Pizza Size
-- Contribution by size
SELECT pizza_size, 
ROUND(SUM(total_price), 2) as total_revenue,
ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales), 2) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;



-- F. Total Pizzas Sold by Category (February)
SELECT pizza_category, 
SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;



-- G. Top 5 Best Sellers
SELECT pizza_name, 
SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;



-- H. Bottom 5 Best Sellers
SELECT pizza_name, 
SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
LIMIT 5;
