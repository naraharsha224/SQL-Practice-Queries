-- Write a query to fetch the count of new customers and repeated customers by the order date.

-- Table schema as below

create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),
                                  (2,200,cast('2022-01-01' as date),2500),
                                  (3,300,cast('2022-01-01' as date),2100),
                                  (4,100,cast('2022-01-02' as date),2000),
                                  (5,400,cast('2022-01-02' as date),2200),
                                  (6,500,cast('2022-01-02' as date),2700),
                                  (7,100,cast('2022-01-03' as date),3000),
                                  (8,400,cast('2022-01-03' as date),1000),
                                  (9,600,cast('2022-01-03' as date),3000);
                                  
-- Solution 1
WITH first_visit AS (
SELECT customer_id, MIN(order_date) AS first_visit_date
FROM customer_orders
GROUP BY customer_id)

SELECT co.order_date,
       SUM(CASE WHEN fv.first_visit_date = co.order_date THEN 1 ELSE 0 END) AS first_visit_flag,
	   SUM(CASE WHEN fv.first_visit_date != co.order_date THEN 1 ELSE 0 END) AS repeat_visit_flag
FROM customer_orders co
JOIN first_visit fv ON fv.customer_id = co.customer_id
GROUP BY co.order_date

-- Solution 2

WITH first_visit AS (
SELECT customer_id, order_date,
       MIN(order_date) OVER(PARTITION BY customer_id) AS first_visit_date
FROM customer_orders)

SELECT order_date,
       SUM(CASE WHEN order_date = first_visit_date THEN 1 ELSE 0 END) AS new_cust_count,
	   SUM(CASE WHEN order_date!= first_visit_date THEN 1 ELSE 0 END) AS repeat_cust_count
FROM first_visit
GROUP BY order_date
