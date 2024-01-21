use PizzaDB

                         select * from pizza_sales

                            --KPI REQUIREMENTS

--Total Revenue
select sum(total_price) as [Total Revenue] from pizza_sales

--Average Order Value
Select (SUM(total_price) / COUNT(Distinct order_id)) as [Avg_order_Value] from pizza_sales

--Total pizzas Sold
select count(quantity) as [Total_Pizzas_sold] from pizza_sales

--Total orders
select count(distinct order_id) as [Total Orders] from pizza_sales

--Average Pizzas Per Order
select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id) as decimal(10,2))
as decimal(10,2)) 
as [APPO] from pizza_sales


                              --CHART REQUIREMENTS

--Daily Trends For Total Orders
select datename(dw,order_date) as [order_day], count(distinct order_id) as [total Orders]
from pizza_sales
group by datename(dw,order_date)

--Monthly Trends For Orders
select datename(month,order_date) as [Month],count(distinct order_id) as [total order]
from pizza_sales
group by datename(month,order_date)

--% of sales by pizza category
select pizza_category,cast(sum(total_price) as decimal(10,2)) as total_revenue,
cast(sum(total_price)*100/(select sum(total_price) from pizza_sales)
as decimal(10,2)) as PCT
from pizza_sales
group by pizza_category

--% of sales by pizza size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size

--total pizza sold by pizza category
select pizza_category,sum(quantity) as total_Quantity
from pizza_sales
group by pizza_category
order by sum(quantity) desc

--Top 5 Pizzas By Revenue
select top 5 pizza_name,sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue desc

--Bottom 5 Pizzas by revenue
select top 5 pizza_name,sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue asc

--Top 5 pizzas by quantity
select top 5 pizza_name,sum(quantity) as total_Pizzas_sold
from pizza_sales
group by pizza_name
order by total_Pizzas_sold desc

--Bottom 5 pizzas by quantity
select top 5 pizza_name,sum(quantity) as total_Pizzas_sold
from pizza_sales
group by pizza_name
order by total_Pizzas_sold asc

--Top 5 pizzas by Total orders
select top 5 pizza_name, count(distinct order_id) as [Total_orders]
from pizza_sales
group by pizza_name
order by [Total_orders] desc

--Bottom 5 pizzas by Total orders
select top 5 pizza_name, count(distinct order_id) as [Total_orders]
from pizza_sales
group by pizza_name
order by [Total_orders] asc