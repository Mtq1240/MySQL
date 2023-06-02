-- 创建用户信息数据库
CREATE DATABASE Userinfo;

-- 切换到 Userinfo 数据库
USE Userinfo;

-- 创建表1  users
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    email VARCHAR(50)
);

-- 创建表2  adderss
CREATE TABLE adderss (
    id INT PRIMARY KEY,
    users_id INT,
    address VARCHAR(100),
    FOREIGN KEY (users_id) REFERENCES users(id)
);

-- 创建表3  salary
CREATE TABLE salary (
    id INT PRIMARY KEY,
    users_id INT,
    salary INT,
    FOREIGN KEY (users_id) REFERENCES users(id)
);
 
-- 创建表4  type_price
CREATE TABLE type_price (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    type VARCHAR(50),
    price INT
);

-- 创建表5  number
CREATE TABLE number (
    id INT PRIMARY KEY,
    type_price_id INT,
    quantity INT,
    FOREIGN KEY (type_price_id) REFERENCES type_price(id)
);


-- 给每个表插入数据
-- users
INSERT INTO users (id , name , age , email) VALUES 
		(1, '马正蓉', 20, 'mzr@test.com'),
		(2, '李昊云', 25, 'lhy@test.com'),
		(3, '赵世岚', 30, 'zsl@test.com'),
		(4, '章湛蓓', 35, 'zzb@test.com'),
		(5, '商宇翔', 40, 'zyx@test.com'),
		(6, '马芷烟', 45, 'mzy@test.com'),
		(7, '曹芃希', 50, 'cfx@test.com'),
		(8, '张怀鸿', 55, 'zhh@test.com'),
		(9, '马渊婉', 60, 'myw@test.com'),
		(10, '卢书平', 65, 'lsp@test.com');

-- adderss
INSERT INTO adderss ( id , users_id , address ) VALUES
		(1, 1, '合肥市新泉南园文化城'),
		(2, 2, '重庆市半山水一号路'),
		(3, 3, '江苏省湘湖中路'),
		(4, 4, '北京市北街'),
		(5, 5, '江苏省苏溪东路'),
		(6, 6, '江苏省吴江文化城'),
		(7, 7, '广西壮族自治区嵩山路'),
		(8, 8, '江苏省昌平中路'),
		(9, 9, '新疆维吾尔自治区临夏路'),
		(10, 10, '江苏省泰州市');

-- salary
INSERT INTO salary ( id , users_id , salary ) VALUES
		(1, 1, 2000),
		(2, 2, 3000),
		(3, 3, 4000),
		(4, 4, 5000),
		(5, 5, 6000),
		(6, 6, 7000),
		(7, 7, 8000),
		(8, 8, 9000),
		(9, 9, 10000),
		(10, 10, 11000);

-- type_price
INSERT INTO type_price ( id , name ,type , price ) VALUES
		(1, 'iPhone', '移动手机', 1000),
		(2, '三星', '移动手机', 900),
		(3, '惠普', '笔记本', 1200),
		(4, '戴尔', '笔记本', 1100),
		(5, '索尼', '电视', 1500),
		(6, '乐金', '电视', 1400),
		(7, '佳能', '照相机', 800),
		(8, '尼康', '照相机', 900),
		(9, '苹果', '平板电脑', 1100),
		(10, '微软', '平板电脑', 1000);

-- number
INSERT INTO number ( id , type_price_id , quantity ) VALUES 
		(1, 1, 2),
		(2, 2, 3),
		(3, 3, 4),
		(4, 4, 5),
		(5, 5, 6),
		(6, 6, 7),
		(7, 7, 8),
		(8, 8, 9),
		(9, 9, 10),
		(10, 10, 11);

-- 使用模式匹配查询
SELECT * FROM users WHERE name LIKE '马%';

-- 使用 top 查询
SELECT TOP 3 * FROM adderss;

-- 使用 in 查询
SELECT * FROM type_price WHERE type IN ('移动手机', '笔记本');

-- 降序查询
SELECT * FROM salary ORDER BY salary DESC;

-- 使用 count 集合函数查询
SELECT COUNT(*) sum FROM users;

-- 分组统计查询
SELECT users_id, COUNT(*) id_sum  FROM adderss GROUP BY users_id;

-- 使用连接条件的多表查询
SELECT users.name, adderss.address FROM users INNER JOIN adderss ON users.id = adderss.users_id;

-- 比较运算符的子查询
SELECT * FROM users WHERE age > (SELECT AVG(age) FROM users);

-- 使用 in 的子查询
SELECT name FROM users WHERE id IN (SELECT users_id FROM adderss WHERE address LIKE '江苏省%');
GO

-- 创建视图
CREATE VIEW view1 AS SELECT id, name FROM users WHERE age > 30;
GO

-- 视图的使用
SELECT * FROM users;
GO

-- 创建索引
CREATE INDEX idx_table3_salary ON salary (salary);

-- 创建唯一性约束
ALTER TABLE users ADD CONSTRAINT uc_users_email UNIQUE (email);

-- 检查约束
ALTER TABLE type_price ADD CONSTRAINT ck_type_price_price CHECK (price > 0);

-- 默认值约束
ALTER TABLE number ADD CONSTRAINT df_number_quantity DEFAULT 0 FOR quantity;

-- 创建外键约束
ALTER TABLE salary ADD CONSTRAINT fk_salary_users FOREIGN KEY (users_id) REFERENCES users(id);
go

-- 创建存储过程
CREATE PROCEDURE sp_users_insert (
    @id INT,
    @name VARCHAR(50),
    @age INT,
    @email VARCHAR(50)
) AS
BEGIN
    INSERT INTO users VALUES (@id, @name, @age, @email);
END;

-- 使用存储过程
EXEC sp_users_insert 11, '陈杰', 70, 'cj@test.com';
GO

-- 创建触发器
CREATE TRIGGER tr_number_insert_update
ON number
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE type_price
    SET price = price + i.quantity * 100
    FROM type_price
    INNER JOIN inserted i ON type_price.id = i.type_price_id;
END;

-- 触发器演示
-- type_price 表中插入一条记录
INSERT INTO type_price(id, name,type, price)
VALUES (11, '演示', '演示',100);

-- number 表中插入一条记录
INSERT INTO number(id, type_price_id, quantity)
VALUES(11, 11, 12);

-- 验证
SELECT * FROM type_price;

-- 错误演示
UPDATE type_price
SET price = -3
WHERE id = 11;
