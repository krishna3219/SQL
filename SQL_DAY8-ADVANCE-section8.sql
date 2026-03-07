-- SECTION 8

-- 1:MANY DATA
    
CREATE DATABASE store_db;
USE store_db;

-- customers TABLE 
CREATE TABLE customers(
    customer_id INT IDENTITY(100,1) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- orders TABLE
CREATE TABLE orders(
    order_id INT IDENTITY(500,1) PRIMARY KEY,
    order_date  DATE NOT NULL,
    total_amount DECIMAL(10,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


-- validation.
    EXEC sp_help customers;
    EXEC sp_help orders;

-- INSERTION of DATA.
INSERT INTO customers (customer_name,email)
VALUES
('Raju','raju@example.com'),
('Shyam','shyam@example.com'),
('Baburao','baburao@example.com');

    INSERT INTO customers(customer_name,email)
    VALUES
    ('Paul','paul@example.com');


INSERT INTO orders (order_date, customer_id, total_amount)
VALUES 
('2024-01-01', 100, 250.00),  
('2024-01-15', 101, 300.00),  
('2024-02-01', 100, 150.00),
('2024-03-01', 102, 450.00),
('2024-04-04', 101, 550.00);  

    INSERT INTO orders(order_date, total_amount)
    VALUES
    ('2025-10-18',3500.00);

-- VIEW THE DATA
SELECT * FROM customers;
SELECT * FROM orders;


-- NOW TRY deleting any specifc customer : IT will throw error. 
DELETE FROM customers
WHERE customer_id = 101;


/* xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/

-- Joins
    -- CROSS JOIN
    SELECT * FROM customers
    CROSS JOIN orders;

    -- INNER JOIN
    SELECT * FROM customers
    INNER JOIN orders
    ON customers.customer_id = orders.customer_id;

        -- INNER JOIN WITH GROUP BY
        SELECT c.customer_name , COUNT(o.order_id) AS order_count, SUM(o.total_amount) AS total_order_amount FROM 
        customers c INNER JOIN orders o
        ON
        c.customer_id = o.customer_id
        GROUP BY c.customer_name;
    
    --LEFT JOIN
    SELECT * FROM customers
    LEFT JOIN orders
    ON customers.customer_id = orders.customer_id;

        -- LEFT JOIN WITH GROUP BY
        SELECT c.customer_name , COUNT(o.order_id) AS order_count, SUM(o.total_amount) AS total_order_amount FROM 
        customers c LEFT JOIN orders o
        ON
        c.customer_id = o.customer_id
        GROUP BY c.customer_name;

    -- RIGHT JOIN
    SELECT * FROM customers
    RIGHT JOIN orders
    ON customers.customer_id = orders.customer_id;

        -- RIGHT JOIN WITH GROUP BY
        SELECT c.customer_name , COUNT(o.order_id) AS order_count, SUM(o.total_amount) AS total_order_amount FROM 
        customers c RIGHT JOIN orders o
        ON
        c.customer_id = o.customer_id
        GROUP BY c.customer_name;

    -- FULL OUTER JOIN
    SELECT * FROM customers
    FULL OUTER JOIN orders
    ON customers.customer_id = orders.customer_id;

        -- FULL OUTER JOIN WITH GROUP BY
        SELECT c.customer_name , COUNT(o.order_id) AS order_count, SUM(o.total_amount) AS total_order_amount FROM 
        customers c FULL OUTER JOIN orders o
        ON
        c.customer_id = o.customer_id
        GROUP BY c.customer_name;

/*xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/

-- OUTER APPLY
    /* USE CASE:
        For each customer , show their most recent order (if they have one). If they have no orders, still show the customer.*/
        SELECT TOP 1 * FROM orders  WHERE customer_id = 101 ORDER BY order_date DESC -- NOT EFFECIENT METHOD as each time we need to give customer id one by one. SO we used OUTER APPLY.

        SELECT 
            c.customer_id, c.customer_name,
            o.order_id, o.order_date, o.total_amount
        FROM customers AS c
        OUTER APPLY(
            SELECT TOP 1 *
            FROM orders AS o
            WHERE o.customer_id = c.customer_id
            ORDER BY o.order_date DESC
        )AS o;

-- CROSS APPLY.
        SELECT 
            c.customer_id, c.customer_name,
            o.order_id, o.order_date, o.total_amount
        FROM customers AS c
        CROSS APPLY(
            SELECT TOP 1 *
            FROM orders AS o
            WHERE o.customer_id = c.customer_id
            ORDER BY o.order_date DESC
        )AS o;

/*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*/

-- SELF JOIN
    -- Table Creation.
    CREATE TABLE CompanyHierarchy(
        EmployeeID INT PRIMARY KEY,
        Name VARCHAR(100),
        ManagerID INT
    );

    -- INSERT Values.
    INSERT INTO CompanyHierarchy(EmployeeID, Name, ManagerID)
    VALUES
    (1,'Sonia Verma',NULL), -- THE CEO
    (2,'Rohan Gupta',1),    -- Reports to Sonia
    (3,'Amit Sharma',2),    -- Reports to Rohan
    (4,'Priya Singh',1),    -- Reports to Sonia
    (5,'Kabir Shah',2);     -- Reports to Rohan

    -- VIEW Data
    SELECT * FROM CompanyHierarchy;

    -- SELF JOIN
    SELECT 
        e.name AS Employee_Name,
        m.name AS Manager_Name
    FROM CompanyHierarchy AS e
    LEFT JOIN CompanyHierarchy AS m
    ON e.ManagerID = m.EmployeeID;

/*xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/





        






