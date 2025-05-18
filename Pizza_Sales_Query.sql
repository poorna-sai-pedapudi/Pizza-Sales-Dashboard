select * 
from pizza_sales;

-- Total Revenue
select sum(total_price) as Total_Revenue
from pizza_sales;

-- Average Order Value
select sum(total_price) / count(distinct order_id) as Average_Order_Value
from pizza_sales;

-- Total Pizza Sold
select sum(quantity) as Total_Pizzas_Sold
from pizza_sales;

-- Total Orders placed
select count(distinct order_id) as Total_Orders_Placed
from pizza_sales;

-- Average Pizzas per Order
select cast(sum(quantity) as decimal(10,2)) / 
cast(count(distinct order_id) as decimal(10,2)) as Average_Pizzas_per_Order
from pizza_sales;
-- decimal(10,2) means 156.5678905587 then only 156.56 will be answer

select cast(cast(sum(quantity) as decimal(10,2)) / 
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as Average_Pizzas_per_Order
from pizza_sales;

-- 1. Hourly Trend for total pizzas sold

select datepart(hour, order_time) as order_hour,
sum(quantity) as Total_Pizzas_sold
from pizza_sales
group by datepart(hour, order_time)
order by datepart(hour, order_time);

-- 2. Weekly Trend for total orders

select datepart(ISO_WEEK, order_date) as week_number,
year(order_date) as order_year, count(distinct order_id) as Total_Orders
from pizza_sales
group by datepart(iso_week, order_date), year(order_date)
order by datepart(iso_week, order_date), year(order_date);

-- 3. Percentage of Sales by Pizza Category

select pizza_category, sum(total_price) as Total_Sales,
sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as percent_of_total_sales
from pizza_sales
group by pizza_category;

-- For particular month
select pizza_category, sum(total_price) as Total_Sales,
sum(total_price) * 100 / 
(select sum(total_price) from pizza_sales where month(order_date) = 1) as percent_of_total_sales
from pizza_sales
where month(order_date) = 1 -- month of January
group by pizza_category;

-- where clause should be there are subquery as well. It should be added before group by clause.

-- 4. Percentage of Sales by Pizza Size
select pizza_size, sum(total_price) as Total_Sales,
sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as percent_of_total_sales
from pizza_sales
group by pizza_size
order by percent_of_total_sales desc;


select pizza_size, cast(sum(total_price) as decimal(10,2))as Total_Sales,
cast(sum(total_price) * 100 / 
(select sum(total_price) from pizza_sales) as decimal(10,2))as percent_of_total_sales 
from pizza_sales
group by pizza_size
order by percent_of_total_sales desc;

select pizza_size, cast(sum(total_price) as decimal(10,2))as Total_Sales,
cast(sum(total_price) * 100 / 
(select sum(total_price) from pizza_sales 
where datepart(quarter, order_date) = 1) as decimal(10,2))as percent_of_total_sales 
from pizza_sales
where datepart(quarter, order_date) = 1
group by pizza_size
order by percent_of_total_sales desc;

-- 5. Total Pizzas sold by Pizza Category

select pizza_category, sum(quantity) as Total_Pizzas
from pizza_sales
group by pizza_category
order by pizza_category;

-- 6. Top 5 Best Sellers by Revenue, Total Quantity, and Total Orders

select top 5 pizza_name, cast(sum(total_price) as decimal(10,2)) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue desc;

select top 5 pizza_name, sum(quantity) as Total_Pizzas
from pizza_sales
group by pizza_name
order by Total_Pizzas desc;

select top 5 pizza_name, count(distinct order_id) as Total_Orders
from pizza_sales
group by pizza_name
order by Total_Orders desc;


-- 7. Bottom 5 Best Sellers by Revenue, Total Quantity, and Total Orders

select top 5 pizza_name, cast(sum(total_price) as decimal(10,2)) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue asc;

select top 5 pizza_name, sum(quantity) as Total_Pizzas
from pizza_sales
group by pizza_name
order by Total_Pizzas;

select top 5 pizza_name, count(distinct order_id) as Total_Orders
from pizza_sales
group by pizza_name
order by Total_Orders;