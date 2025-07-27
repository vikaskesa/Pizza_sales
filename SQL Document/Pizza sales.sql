-- Did this Project in pgadmin 4

create table pizzasales(
pizza_id integer,
order_id integer,	
pizza_name_id text,	
quantity integer,
order_date Date,
order_time Time,	
unit_price NUMERIC(10, 2),	
total_price NUMERIC(10, 2),	
pizza_size text,	
pizza_category text,
pizza_ingredients text,	
pizza_name text
);
--Imported the data via import/Export option from the 
--tables

--KPIs
select * from pizzasales;

--Find the total Revenue:
select sum(total_price) as "Total Revenue"
from pizzasales;

--Average Order Value :
select sum(total_price)/count(distinct(order_id)) as "Average Order Value"
from pizzasales;

--Total pizzas sold
SELECT SUM(Quantity) AS "Total Quantity"
FROM pizzasales;

--Total Orders 
SELECT COUNT(DISTINCT(order_id)) AS "Total orders"
FROM pizzasales;

--Average pizzas per order
SELECT CAST(CAST(SUM(Quantity) AS DECIMAL(10,2)) /CAST(COUNT(DISTINCT(order_id)) AS DECIMAL(10,2)) AS DECIMAL(10,2)) as "Average pizzas per order"
FROM pizzasales;

--Charts
--Daily Trend of Total Orders
SELECT 
    TO_CHAR(order_date, 'FMDay') AS order_day,
    COUNT(DISTINCT order_id) AS "Total Orders"
FROM pizzasales
GROUP BY TO_CHAR(order_date, 'FMDay');

--Monthly trend of the orders

SELECT TO_CHAR(order_date, 'Month') AS month_name,COUNT(DISTINCT order_id) AS "Total Orders"
FROM pizzasales
GROUP BY TO_CHAR(order_date, 'Month')
ORDER BY "Total Orders" desc;

-- Percentage of sales by pizza category

SELECT pizza_category, SUM(total_price) * 100/(SELECT SUM(Total_price) as total_sales FROM pizzasales WHERE EXTRACT(MONTH FROM order_date)=1)as "Percent of sales"
FROM pizzasales
WHERE EXTRACT(MONTH FROM order_date)=1
GROUP BY pizza_category;

-- Percentage of sales by Pizza size
SELECT pizza_size, CAST((SUM(total_price) * 100/(SELECT SUM(Total_price) as total_sales FROM pizzasales)) AS DECIMAL(10,2))as "Percent of sales"
FROM pizzasales
GROUP BY pizza_size
ORDER BY "Percent of sales" DESC;

--Top 5 Best sellers by revenue, total Quantity,Total Orders
--Top 5 Best sellers by revenue,
SELECT pizza_name,sum(total_price) as "Total Revenue"
FROM pizzasales
GROUP BY pizza_name 
ORDER BY "Total Revenue" desc
LIMIT 5;
--Bottom 5 Best sellers by revenue, total Quantity,Total Orders
--Bottom 5 Best sellers by revenue
SELECT pizza_name,sum(total_price) as "Total Revenue"
FROM pizzasales
GROUP BY pizza_name 
ORDER BY "Total Revenue" 
LIMIT 5;

--Bottom 5 best Sellers wrt Quantity
SELECT pizza_name,sum(Quantity) as "Total Quantity"
FROM pizzasales
GROUP BY pizza_name 
ORDER BY "Total Quantity"
LIMIT 5;
--TOP 5 Best sellers by Quantity
SELECT pizza_name,sum(Quantity) as "Total Quantity"
FROM pizzasales
GROUP BY pizza_name 
ORDER BY "Total Quantity" DESC
LIMIT 5;
--Top 5 Best sellers by total orders
SELECT pizza_name,COUNT(order_id) as "Total Orders"
FROM pizzasales
GROUP BY pizza_name 
ORDER BY "Total Orders" DESC
LIMIT 5;

--Bottom 5 Best sellers by total orders
SELECT pizza_name,COUNT(order_id) as "Total Orders"
FROM pizzasales
GROUP BY pizza_name 
ORDER BY "Total Orders" 
LIMIT 5;






