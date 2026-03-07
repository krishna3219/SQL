-- TASK - ONE TO ONE and MANY TO RELATIONSHIPS. -E-STORE DB

/* Create a one-to-many and many-to-many relationship in a shopping store context using four tables:
        customers
        orders
        products
        order_items
Include a price column in the products table and display the relationship between customers and their orders, along with the details of the products in each order.  */

/*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*/

-- Current DB check:
SELECT DB_NAME() AS Current_DB;

-- DATABASE CREATION
CREATE DATABASE ESTORE_K;
USE ESTORE_K;



-- TABLE CREATION AND DATA INSERTION.
    
    -- TABLE 1: customers
        CREATE TABLE customers (
            cust_id INT IDENTITY(1,1) PRIMARY KEY,
            cust_name VARCHAR (100) NOT NULL 
        );

        -- Data
        INSERT INTO customers (cust_name) VALUES ('Raju'),('Sham'),('Paul'),('Alex'),('Baburao');

        -- view
        SELECT * FROM customers;

    -- TABLE 2: orders
        CREATE TABLE orders(
            ord_id INT IDENTITY(1,1) PRIMARY KEY,
            ord_date DATE NOT NULL,
            cust_id INT NOT NULL,
            FOREIGN key (cust_id) REFERENCES customers(cust_id) ON DELETE CASCADE
        );

        --  Data
        INSERT INTO orders(ord_date,cust_id) VALUES 
        ('2026-01-01',1) ,  -- Raju first order
        ('2026-02-01',2) ,  -- Sham first order
        ('2026-03-01',3) ,  -- Paul first order
        ('2026-04-04',2);   -- Sham second order

        -- values
        SELECT * FROM orders;
        -- SELECT DAY(ord_date) FROM orders; /*Command to check day from given date */
    
    -- TABLE 3: products
        CREATE TABLE products(
            p_id INT IDENTITY(1,1) PRIMARY KEY,
            p_name VARCHAR(100) NOT NULL,
            price NUMERIC NOT NULL
        )

        -- Data
        INSERT INTO products(p_name,price) VALUES ('Laptop',55000.00),('Mouse',500),('Keyboard',800.00),('Cable',250.00),('Monitor',12000.00);

        -- View
        SELECT * FROM products;

    -- TABLE 4: order_items
        CREATE TABLE order_items(
            item_id INT IDENTITY(1,1) PRIMARY KEY,
            ord_id INT NOT NULL,
            p_id INT NOT NULL,
            quantity INT NOT NULL,
            FOREIGN KEY (ord_id) REFERENCES orders(ord_id),
            FOREIGN KEY (p_id) REFERENCES products(p_id)
        )

        -- Data
        INSERT INTO order_items(ord_id,p_id,quantity) VALUES 
        (1,1,1) ,   -- Raju ordered 1 Laptop
        (1,4,2) ,   -- Raju ordered 2 Cables
        (2,1,1) ,   -- Sham ordered 1 Laptop
        (3,2,1) ,   -- Paul ordered 1 Mouse
        (3,4,5) ,   -- Paul ordered 5 Cables
        (4,3,1);    -- Sham ordered 1 Keyboard

        -- Values
        SELECT * FROM order_items;


--  VIEW TABLE DATAS
    SELECT * FROM customers;
    SELECT * FROM orders;
    SELECT * FROM products;
    SELECT * FROM order_items;

-- QUERY 

    -- CONNECT ALL TABLES AND VIEW ALL THE DATA
        SELECT *
        FROM order_items oi
        JOIN products p ON oi.p_id = p.p_id
        JOIN orders o ON o.ord_id = oi.ord_id
        JOIN customers c ON o.cust_id = c.cust_id

    -- VIEW relevant data from all tables (list of customers who have placed orders - Inner join on customers)
        SELECT 
            c.cust_name, o.ord_id, o.ord_date, p.p_name, oi.quantity, p.price, P.price * oi.quantity AS total_price 
        FROM order_items oi
        JOIN products p ON oi.p_id = p.p_id
        JOIN orders o ON o.ord_id = oi.ord_id
        JOIN customers c ON o.cust_id = c.cust_id

    -- List of customers who have not placed orders. (Right Join on customers)
        SELECT 
            c.cust_name, o.ord_id, o.ord_date, p.p_name, oi.quantity, p.price, P.price * oi.quantity AS total_price 
        FROM order_items oi
        JOIN products p ON oi.p_id = p.p_id
        JOIN orders o ON o.ord_id = oi.ord_id
        RIGHT JOIN customers c ON o.cust_id = c.cust_id

    -- Group by customer name , Find order count , no of products , 
        SELECT 
            c.cust_name,
            COUNT( DISTINCT o.ord_id) AS no_of_Orders,
            SUM(oi.quantity) AS no_of_Products,
            SUM(p.price * oi.quantity) AS total_amount
        FROM order_items oi
        JOIN products p ON oi.p_id = p.p_id
        JOIN orders o ON o.ord_id = oi.ord_id
        RIGHT JOIN customers c ON o.cust_id = c.cust_id
        GROUP BY c.cust_name

    -- GROUP  by order date, find no of customers who shopped on each day ,no of products they purchased and total sale  made on each day.
        SELECT 
            o.ord_date,
            COUNT( DISTINCT o.cust_id) AS no_of_customers,
            SUM(oi.quantity) AS no_of_products,
            SUM(p.price * oi.quantity) AS total_sale
        FROM order_items oi
        JOIN products p ON oi.p_id = p.p_id
        JOIN orders o ON o.ord_id = oi.ord_id
        JOIN customers c ON o.cust_id = c.cust_id
        GROUP BY o.ord_date;

        
