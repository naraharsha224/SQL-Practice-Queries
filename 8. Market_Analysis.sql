/*
Write a SQL query to find for each seller, whether the brand of the second item (by date) they sold is their favourite or not.
 If a seller sold less than two items, report the answer for that seller as no.
*/

-- Table Schema as below

create table users1 (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));

 create table orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 create table items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );
 
 insert into users1 values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

 insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

 insert into orders values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
 ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);
 
 
 -- Solution
  WITH rnk_orders 
      AS( SELECT *,
                 RANK() OVER(PARTITION BY seller_id ORDER BY order_date ASC) AS rn
          FROM orders)

 SELECT u.user_id AS seller_id,
        CASE 
		  WHEN i.item_brand=u.favorite_brand THEN 'Yes' 
		  ELSE 'No' 
		  END AS second_item_fav_brand
 FROM users1 u 
 LEFT JOIN rnk_orders ro ON ro.seller_id=u.user_id AND rn=2
 LEFT JOIN items i ON i.item_id=ro.item_id
 
 
 -- Steps followed
1. The RANK() function assigns a rank to each order based on the seller's ID and the order date. The orders are partitioned by the seller_id and ordered by the order_date in ascending order.

2. The "users1" table is joined with the "rnk_orders" table using a left join, which will return all rows from the first table and matching rows from the other table. The join is based on the seller_id column from both tables and the rank column from the rnk_orders table which is equal to 2 (rn=2)

3. The "rnk_orders" table is then joined with the "items" table on the "item_id" column from both tables.

4. Next, we use a CASE statement to determine if the item's brand is the same as the seller's favorite brand. If it is, the query returns "Yes", otherwise it returns "No".

5. Finally, the query returns a table with columns seller_id and second_item_fav_brand.
