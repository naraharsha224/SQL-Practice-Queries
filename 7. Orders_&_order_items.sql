

-- Table schema as below

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(255)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO orders (order_id, customer_id, order_date, status)
VALUES (1, 1, '2022-01-01', 'shipped'),
       (2, 2, '2022-01-02', 'processing'),
       (3, 3, '2022-01-03', 'delivered');

INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES (1, 1, 2, 10),
       (1, 2, 3, 20),
       (2, 3, 1, 30),
       (2, 4, 5, 15),
       (3, 5, 2, 25);

INSERT INTO orders (order_id, customer_id, order_date, status)
VALUES (4, 4, '2022-01-04', 'cancelled'),
       (5, 5, '2022-01-05', 'shipped'),
       (6, 6, '2022-01-06', 'delivered');

INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES (4, 6, 1, 40),
       (4, 7, 2, 52),
       (5, 8, 3, 45),
       (5, 9, 4, 71),
       (6, 10, 5, 69),
       (6, 11, 6, 65);
       
       
/*       
write a query that returns the following information for each order:

order_id,
customer_id,
order_date,
status,
total_quantity (sum of all quantities of items in the order),
total_price (sum of all prices of items in the order),
average_item_price (average price of items in the order),
most_expensive_item_price (highest price of items in the order),
least_expensive_item_price (lowest price of items in the order)
*/


-- Solution

SELECT 
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,
    SUM(oi.quantity) as total_quantity,
    SUM(oi.price) as total_price,
    AVG(oi.price) as average_item_price,
    MAX(oi.price) as most_expensive_item_price,
    MIN(oi.price) as least_expensive_item_price
FROM orders o
JOIN order_items oi on o.order_id = oi.order_id
GROUP BY o.order_id, o.customer_id, o.order_date, o.status


-- steps followed
1. The SUM(oi.quantity) as total_quantity will give sum of all quantity of items in the order.
2. The SUM(oi.price) as total_price will give sum of all prices of items in the order.
3. The AVG(oi.price) as average_item_price will give average price of items in the order.
4. The MAX(oi.price) as most_expensive_item_price will give highest price of items in the order.
5. The MIN(oi.price) as least_expensive_item_price will give lowest price of items in the order.
