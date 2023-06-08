-- 创建数据库
CREATE DATABASE TestDB;

--使用当前数据库
USE TestDB;

-- 创建五张表
CREATE TABLE table1 ( 
	id INT PRIMARY KEY,  
	name VARCHAR(50),    
	age INT,   
	address VARCHAR(100)
);

CREATE TABLE table2 (    
	id INT PRIMARY KEY,  
	user_id INT,  
	product_name VARCHAR(50),   
	price DECIMAL(10, 2), 
	FOREIGN KEY (user_id) REFERENCES table1(id)
);

CREATE TABLE table3 (   
	id INT PRIMARY KEY,    
	category VARCHAR(50),  
	quantity INT,   
	price DECIMAL(10, 2)
);

CREATE TABLE table5 (  
	id INT PRIMARY KEY,   
	date DATETIME,    
	customer_id INT,  
	total_price DECIMAL(10, 2),  
	FOREIGN KEY (customer_id) REFERENCES table1(id)
);

CREATE TABLE table4 (  
	id INT PRIMARY KEY,  
	order_id INT, 
	product_id INT,  
	quantity INT, 
	price DECIMAL(10, 2),   
	FOREIGN KEY (order_id) REFERENCES table5(id), 
	FOREIGN KEY (product_id) REFERENCES table2(id)
);



-- 插入数据 
INSERT INTO table1 VALUES 
(1, 'Alice', 25, '123 Main St'),   
(2, 'Bob', 30, '456 Maple Ave'),   
(3, 'Charlie', 35, '789 Oak Blvd'),  
(4, 'David', 40, 'ABC Street'),    
(5, 'Eve', 45, 'XYZ Road'),   
(6, 'Frank', 50, 'PQR Lane'),  
(7, 'Grace', 55, 'MNO Street'),  
(8, 'Henry', 60, 'DEF Ave'), 
(9, 'Ivy', 65, 'GHI Blvd'),   
(10, 'John', 70, 'JKL Road');

INSERT INTO table2 VALUES    
(1, 1, 'Laptop', 1000.00), 
(2, 1, 'Phone', 500.00),   
(3, 2, 'Tablet', 800.00),   
(4, 2, 'Headphone', 200.00), 
(5, 3, 'Smart Watch', 300.00),   
(6, 3, 'Camera', 700.00),   
(7, 4, 'TV', 1500.00),    
(8, 4, 'Speaker', 400.00),  
(9, 5, 'Gaming Console', 1200.00),   
(10, 5, 'Monitor', 600.00);

INSERT INTO table3 VALUES  
(1, 'Electronics', 50, 1000.00),   
(2, 'Clothing', 100, 500.00),   
(3, 'Home Appliances', 25, 1500.00),   
(4, 'Books', 200, 200.00),  
(5, 'Beauty', 75, 300.00),    
(6, 'Toys', 150, 250.00),  
(7, 'Jewelry', 50, 10000.00),   
(8, 'Sports', 100, 400.00),  
(9, 'Furniture', 50, 2000.00),
(10, 'Food', 500, 5.00);

INSERT INTO table5 VALUES   
(1, '2021-01-01 10:00:00', 1, 1500.00),   
(2, '2021-01-02 11:00:00', 2, 1000.00),   
(3, '2021-01-03 12:00:00', 3, 500.00),   
(4, '2021-01-04 09:00:00', 4, 2000.00),  
(5, '2021-01-05 13:00:00', 5, 1800.00),  
(6, '2021-01-06 14:00:00', 6, 900.00),    
(7, '2021-01-07 15:00:00', 7, 1200.00), 
(8, '2021-01-08 16:00:00', 8, 800.00),  
(9, '2021-01-09 17:00:00', 9, 3000.00), 
(10, '2021-01-10 18:00:00', 10, 1500.00);

INSERT INTO table4 VALUES  
(1, 1, 1, 2, 2000.00),  
(2, 2, 2, 1, 500.00),   
(3, 3, 3, 3, 2400.00),  
(4, 4, 4, 4, 800.00),   
(5, 5, 5, 2, 600.00),  
(6, 6, 6, 1, 700.00),   
(7, 7, 7, 3, 4500.00),  
(8, 8, 8, 2, 800.00),   
(9, 9, 9, 1, 2000.00),  
(10, 10, 10, 3, 1800.00);

-- 模式匹配查询
SELECT * FROM table1 WHERE name LIKE 'A%';

-- Top查询
SELECT TOP 3 * FROM table2 ORDER BY price DESC;

-- IN查询
SELECT * FROM table3 WHERE category IN ('Clothing', 'Sports');

-- 降序查询
SELECT * FROM table4 ORDER BY price DESC;

-- COUNT集合函数查询
SELECT COUNT(*) FROM table5 WHERE total_price > 1000;

-- 分组统计查询
SELECT category, SUM(quantity) AS total_quantity, AVG(price) AS avg_price FROM table3 GROUP BY category;

-- 连接条件的多表查询
SELECT table5.date, table1.name, table2.product_name, table4.quantity, table4.price
FROM table5 JOIN table1 ON table5.customer_id = table1.id JOIN table4 ON table5.id = table4.order_id JOIN table2 ON table4.product_id = table2.id
ORDER BY table5.date;

-- 比较运算符的子查询
SELECT * FROM table4 WHERE price > (SELECT AVG(price) FROM table2);

-- IN的子查询
SELECT * FROM table2 WHERE id IN (SELECT product_id FROM table4 WHERE quantity > 2);
go

-- 创建视图
CREATE VIEW view1 AS SELECT table1.name,
table2.product_name, 
table4.quantity, 
table4.price FROM table1 JOIN table5 
ON table1.id = table5.customer_id JOIN table4 
ON table5.id = table4.order_id JOIN table2 
ON table4.product_id = table2.id;
go

-- 创建索引
CREATE INDEX idx_name ON table1(name);

-- 唯一性约束
ALTER TABLE table3 ADD CONSTRAINT uc_category UNIQUE(category);

-- 检查约束
ALTER TABLE table1 ADD CONSTRAINT chk_age CHECK(age >= 18);

-- 默认值约束
ALTER TABLE table1 ADD CONSTRAINT df_address DEFAULT 'Unknown' FOR address;

-- 外键约束
ALTER TABLE table4 ADD CONSTRAINT fk_order_id FOREIGN KEY (order_id) REFERENCES table5(id);
go

-- 创建存储过程，返回指定名字的用户信息
CREATE PROCEDURE GetUserByName
    @name VARCHAR(50)
AS
BEGIN
    SELECT * FROM table1 WHERE name = @name;
END


-- 触发器
-- 下面是一个在 table1 表中创建的插入和更新触发器，检查年龄是否大于等于 18 岁
go
CREATE TRIGGER CheckAge
ON table1
AFTER INSERT, UPDATE
AS
BEGIN
IF EXISTS (SELECT 1 FROM INSERTED WHERE age < 18)
BEGIN
RAISERROR ('The age must be greater than or equal to 18.', 16, 1);
ROLLBACK TRANSACTION;
END
END;
