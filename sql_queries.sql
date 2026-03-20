select * from pizza_sales;

select sum(total_price) as total_revenue  --total revenue
from pizza_sales;

select sum(total_price)/count(distinct order_id) 
as avg_order_value
from pizza_sales;

select sum(quantity) as total_pizza_sold
from pizza_sales;

select count(distinct order_id) as total_orders_placed
from pizza_sales;


select CAST(CAST(sum(quantity) as DECIMAL(10,2)) / 
CAST(count(distinct order_id) as DECIMAL(10,2)) as decimal(10,2))
as avg_pizza_sold
from pizza_sales;


-- daily trend of order
select DATENAME(WEEKDAY,order_date) as DOW,
count(distinct Order_id)
from pizza_sales
group by DATENAME(WEEKDAY,order_date)
order by count(distinct Order_id) desc;
-- DATENAME() gives outputsrelated to date in the text format.

--monthly trend of orders
select DATENAME(month, order_date) as month_,
count(distinct order_id) as no_of_orders
from pizza_sales
group by DATENAME(month, order_date) 
order by no_of_orders desc;

-- percentage of sales by pizza category   (monthly)
select pizza_category, sum(total_price) *100 / 
(select sum(total_price) from pizza_sales 
where month(order_date)=1)as pct
from pizza_sales 
where month(order_date)=1 --january
group by pizza_category;


--percentage of sales by pizza size
select pizza_size, 
sum(total_price) *100 / (select sum(total_price) from pizza_sales)
from pizza_sales 
group by pizza_size;


--quarterly sales of pizza size
select pizza_size,CAST(sum(total_price) * 100/
(select sum(total_price) from pizza_sales
where DATEPART(quarter,order_date)=1) 
as decimal(10,2))
from pizza_sales
where DATEPART(quarter,order_date)=1 --1st quarter
group by pizza_size;
-- CAST( expression, (10,2)) gives decimal upto to places.


-- top 5 best sellers by revenue
select top 5 pizza_name,
sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by sum(total_price) desc;
--limit is not available in ssms
--top keyword is used along with number in select field list


-- bottom 5 sellers by revenue
select top 5 pizza_name,
sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by sum(total_price) asc;


-- top 5 best sellers w.r.t quantity
select top 5 pizza_name,
sum(quantity) as total_quantity
from pizza_sales
group by pizza_name
order by sum(quantity);






