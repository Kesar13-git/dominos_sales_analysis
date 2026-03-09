Select * from pizza_sales;
 
 Select SUM(total_price) As Total_Revenue from pizza_sales;

 Select SUM(total_price) / Count(Distinct(order_id)) AS Avg_Order_value from pizza_sales;

 Select SUM(quantity) AS Total_pizza_sold from pizza_sales;

 Select Count(Distinct Order_id) as Total_orders from pizza_sales;

  Select cast(cast(SUM(quantity) AS Decimal(10,2)) / cast(Count(distinct order_id) As Decimal(10,2)) As Decimal(10,2)) AS Avg_pizza_per_order from pizza_sales;   //cast is used to convert int values into decimal(10,2) means we will bw having 10 decimal points value after point and 2 means we will consider 2 values//

  Select Datename(dw,order_date) as order_day, count(distinct order_id) As Total_orders  
  from pizza_sales 
  group by Datename(dw,order_date)
  order by count(distinct order_id) ;  //dw is date of week //

  Select Datename(month,order_date) as order_day, count(distinct order_id) As Total_orders 
  from pizza_sales 
  group by Datename(month,order_date)
  order by Total_orders desc ;

Select pizza_category, sum(total_price) AS total_sales , sum(total_price)*100 / (Select sum(total_price ) from pizza_sales where Month(Order_date) = 1 ) AS Pct
from pizza_sales  
where Month(Order_date) = 1   
Group by pizza_category;

Select pizza_size, CAST(sum(total_price) AS Decimal(10,2)) AS total_sales , CAST(sum(total_price)*100 / (Select sum(total_price ) from pizza_sales where DATEPART (quarter, order_date) = 1  ) AS Decimal (10,2)) AS Pct
from pizza_sales 
where DATEPART (quarter, order_date) = 1
Group by pizza_size
Order by PCT desc 

SELECT TOP 5 pizza_name , cast(SUM(total_price) AS DECIMAL (10,2)) AS Total_Revenue from pizza_sales 
GROUP BY pizza_name 
Order by Total_Revenue desc  

SELECT TOP 5 pizza_name , cast(SUM(total_price) AS DECIMAL (10,2)) AS Total_Revenue from pizza_sales 
GROUP BY pizza_name 
Order by Total_Revenue;    // For Bottom 5 best sellers 

SELECT TOP 5 pizza_name , cast(quantity) AS DECIMAL (10,2)) AS Total_Quantity from pizza_sales 
GROUP BY pizza_name 
Order by Total_Quantity desc ;

SELECT TOP 5 pizza_name , COUNT(DISTINCT order_id) AS Total_Orders from pizza_sales 
GROUP BY pizza_name 
Order by Total_Orders desc;  