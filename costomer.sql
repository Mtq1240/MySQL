-- 创建数据库
CREATE DATABASE mydatabase;

--创建表
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    address VARCHAR(50)
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE order_items (
    id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE categories (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE product_categories (
    id INT PRIMARY KEY,
    product_id INT,
    category_id INT,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- 插入数据
INSERT INTO customers (id, name, email, address) VALUES
(1, 'John Smith', 'john@example.com', '123 Main St'),
(2, 'Jane Doe', 'jane@example.com', '456 Oak Ave'),
(3, 'Bob Johnson', 'bob@example.com', '789 Elm St'),
(4, 'Mary Jones', 'mary@example.com', '101 Maple Rd'),
(5, 'Tom Brown', 'tom@example.com', '222 Pine St');

INSERT INTO orders (id, customer_id, order_date, total) VALUES
(1, 1, '2021-01-01', 100.00),
(2, 2, '2021-01-02', 75.50),
(3, 3, '2021-01-03', 200.00),
(4, 4, '2021-01-04', 50.00),
(5, 5, '2021-01-05', 300.00);

INSERT INTO products (id, name, price) VALUES
(1, 'Product A', 10.00),
(2, 'Product B', 20.00),
(3, 'Product C', 30.00),
(4, 'Product D', 40.00),
(5, 'Product E', 50.00),
(6, 'Product F', 60.00),
(7, 'Product G', 70.00),
(8, 'Product H', 80.00),
(9, 'Product I', 90.00),
(10, 'Product J', 100.00);

INSERT INTO order_items (id, order_id, product_id, quantity) VALUES
(1, 1, 1, 2),
(2, 1, 2, 3),
(3, 2, 3, 1),
(4, 2, 4, 4),
(5, 3, 5, 2),
(6, 3, 6, 1),
(7, 4, 7, 3),
(8, 4, 8, 2),
(9, 5, 9, 5),
(10, 5, 10, 2);

INSERT INTO categories (id, name) VALUES
(1, 'Category A'),
(2, 'Category B'),
(3, 'Category C'),
(4, 'Category D'),
(5, 'Category E');

INSERT INTO product_categories (id, product_id, category_id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 2, 3),
(5, 3, 2),
(6, 3, 4),
(7, 4, 3),
(8, 4, 5),
(9, 5, 1),
(10, 5, 4);

-- 模式匹配查询
SELECT * FROM customers WHERE name LIKE '%John%';

-- 使用 TOP 查询
SELECT TOP 3 * FROM customers;

-- IN 查询
SELECT * FROM products WHERE id IN (1, 3, 5);

-- 降序查询
SELECT * FROM orders ORDER BY total DESC;

-- 使用 COUNT 集合函数查询
SELECT COUNT(*) FROM customers;

-- 分组统计查询
SELECT customer_id, SUM(total) FROM orders GROUP BY customer_id;

-- 使用连接条件的多表查询
SELECT orders.id, customers.name, products.name, order_items.quantity, order_items.quantity * products.price AS total_price
FROM orders
JOIN customers ON orders.customer_id = customers.id
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON order_items.product_id = products.id;

-- 比较运算符的子查询
SELECT * FROM customers WHERE id > (SELECT AVG(id) FROM customers);

-- 使用 IN 的子查询
SELECT * FROM products WHERE id IN (SELECT product_id FROM order_items WHERE order_id = 1);
GO

-- 创建视图并使用
CREATE VIEW order_details AS
SELECT orders.id, customers.name AS customer_name, products.name AS product_name, order_items.quantity, order_items.quantity * products.price AS total_price
FROM orders
JOIN customers ON orders.customer_id = customers.id
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON order_items.product_id = products.id;
GO
-- 使用
SELECT * FROM order_details;
GO

-- 在某个表中创建一个插入和更新的DML触发器
CREATE TRIGGER tr_customer_insert_update
ON customers
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS(SELECT 1 FROM inserted WHERE email IS NULL)
    BEGIN
        RAISERROR('Email cannot be NULL', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;

-- 触发错误演示
INSERT INTO customers (id, name, email, address) VALUES (6, 'Tim Lee', NULL, '555 Oak St'); 
