create database pizza_db;
use pizza_db;
CREATE TABLE pizza_sales (
    pizza_id INt,
    order_id INT,
    pizza_name_id VARCHAR(50),
    quantity INT,
    order_date DATE,
    order_time TIME,
    unit_price DECIMAL(5,2),
    total_price DECIMAL(5,2),
    pizza_size VARCHAR(5),
    pizza_category VARCHAR(50),
    pizza_ingredients TEXT,
    pizza_name VARCHAR(100)
);

load data infile 'C:/ProgramData/MySQL/MySQL Server 9.0/Uploads/pizza_sales.csv' into table pizza_sales
fields terminated by ','
optionally enclosed by'"'
lines terminated by '\r\n'
ignore 1 rows;

select * from pizza_sales;




-- Q1) Find out the total revenue.
SELECT 
    SUM(total_price) AS revenue
FROM
    pizza_sales;
    
    
    

-- Q2) find out the total orders.
SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM
    pizza_sales;
    
    
    

-- Q3) Average ordr value
SELECT 
    (SELECT 
            SUM(total_price)
        FROM
            pizza_sales) / (SELECT 
            COUNT(DISTINCT order_id)
        FROM
            pizza_sales) AS avg_order_value;
    
    
    

-- Q4) average pizzas per order
select 
     (select sum(quantity) from pizza_sales)/(select count(distinct order_id) from pizza_sales) as avg_pizzas_per_order;
     
     
     

-- Q5) Most ordered Pizza.
SELECT 
    pizza_name, COUNT(pizza_name) total
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY total DESC
LIMIT 1;




-- Q6) Total Number of pizza orders on each day of the weel.
select dayname(order_date) as day, count(*) as no_of_pizzas_ordered from pizza_sales group by day
 order by 
 case 
          WHEN Day = 'Monday' THEN 1
          WHEN Day = 'Tuesday' THEN 2
          WHEN Day = 'Wednesday' THEN 3
          WHEN Day = 'Thursday' THEN 4
          WHEN Day = 'Friday' THEN 5
          WHEN Day = 'Saturday' THEN 6
          when day = 'sunday' then 7
          end asc;
          
          
          
          

-- Q7) Monthly trend of Total orders.
SELECT 
    MONTHNAME(order_date) AS month,
    COUNT(DISTINCT (order_id)) AS total_orders
FROM
    pizza_sales
GROUP BY month;




-- Q8) Percentage of sales by pizza size.
SELECT 
    pizza_size,
    SUM(total_price) * 100 / (SELECT 
            SUM(total_price)
        FROM
            pizza_sales) AS percent
FROM
    pizza_sales
GROUP BY pizza_size;





-- Q9) Percentage of sales by Pizza category.
SELECT 
    pizza_category,
    SUM(total_price) * 100 / (SELECT 
            SUM(total_price)
        FROM
            pizza_sales) AS percent
FROM
    pizza_sales
GROUP BY pizza_category;




-- Q10.a) Top 5 pizzas by revenue
SELECT 
    pizza_name, SUM(total_price) AS revenue
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY revenue DESC
LIMIT 5;

-- b)bottom 5 pizzas by revenue
SELECT 
    pizza_name, SUM(total_price) AS revenue
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY revenue asc
LIMIT 5;





-- Q11.a)top 5 pizzas by quantity
SELECT 
    pizza_name, SUM(quantity) AS total_quantity
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity desc
LIMIT 5;

-- b)bottom 5 pizzas by quantity
SELECT 
    pizza_name, SUM(quantity) AS total_quantity
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity asc
LIMIT 5;




-- Q12 Top 5 Pizzas by Total orders.
SELECT 
    pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC 
limit 5;

-- b) Bottom 5 Pizzas by Total orders
SELECT 
    pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY total_orders asc
LIMIT 5;


          
