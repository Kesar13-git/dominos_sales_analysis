USE pizza_db;

SELECT * FROM dbo.pizza_sales;

--Which pizza categories generate high sales but low profit, and should pricing or cost be adjusted? 

SELECT TOP 5
    pizza_category,
    SUM(total_price) AS total_revenue,
    SUM(total_price - (quantity * unit_price*0.6)) AS total_profit,
    ROUND(
        SUM(total_price - (quantity * unit_price*0.6)) * 100.0 
        / SUM(total_price), 2
    ) AS profit_margin_percentage
FROM dbo.pizza_sales
GROUP BY pizza_category
ORDER BY profit_margin_percentage ASC;

 
--Which pizza sizes contribute most to revenue vs profit, and are any sizes underpriced? 

SELECT pizza_size , 
    SUM(total_price) AS total_revenue,
    SUM(total_price - (quantity * unit_price*0.6)) AS total_profit,
    ROUND(
        SUM(total_price - (quantity * unit_price*0.6)) * 100.0 
        / SUM(total_price), 2
    ) AS profit_margin_percentage,
      ROUND(
        SUM(total_price) * 1.0 / COUNT(DISTINCT order_id), 2
    ) AS avg_order_value 
FROM dbo.pizza_sales
GROUP BY pizza_size
ORDER BY profit_margin_percentage ASC;


-- Are top-selling pizzas also the most profitable, or are they reducing overall margins? 

SELECT TOP 5
    pizza_name,
    SUM(total_price) AS total_revenue,
    SUM(total_price - (quantity * unit_price * 0.6)) AS total_profit,
    ROUND(
        SUM(total_price - (quantity * unit_price * 0.6)) * 100.0 
        / SUM(total_price), 2
    ) AS profit_margin
FROM dbo.pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC;


-- Why are certain days busier, and how can the business increase sales on low-performing days? 

SELECT 
    DATENAME(WEEKDAY, order_date) as day_name,
    DATEPART(WEEKDAY, order_date) as day_number,
    COUNT(DISTINCT order_id) as total_orders,
    SUM(total_price) as total_revenue,
    ROUND(SUM(total_price)*1.0 / COUNT(DISTINCT order_id),2) as avg_order_value
FROM dbo.pizza_sales
GROUP BY DATENAME(WEEKDAY, order_date), DATEPART(WEEKDAY, order_date)
ORDER BY day_number;


-- Which time of day has highest and lowest sales? 
-- DATEPART(HOUR, order_time)

SELECT TOP 5
    DATEPART(HOUR, order_time) as hour_of_day,
    COUNT(DISTINCT order_id) as total_orders,
    SUM(total_price) as total_revenue,
    ROUND(SUM(total_price)*1.0 / COUNT(DISTINCT order_id) , 2) as avg_order_value
FROM dbo.pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY total_orders DESC;


SELECT TOP 5
    DATEPART(HOUR, order_time) as day_hour,
    COUNT(DISTINCT order_id) as total_orders,
    SUM(total_price) as total_revenue,
    ROUND(SUM(total_price)*1.0 / COUNT(DISTINCT order_id) , 2) as avg_order_value
FROM dbo.pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY total_orders ASC;
