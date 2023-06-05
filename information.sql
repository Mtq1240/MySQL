-- 创建数据库
CREATE DATABASE information;
GO

-- 使用 MyDatabase 数据库
USE information;
GO

-- 创建表1
CREATE TABLE Table1 (
  ID INT PRIMARY KEY,
  Name VARCHAR(50),
  Age INT
);

-- 创建表2
CREATE TABLE Table2 (
  ID INT PRIMARY KEY,
  Table1ID INT,
  Description VARCHAR(100),
  FOREIGN KEY (Table1ID) REFERENCES Table1(ID)
);

-- 创建表3
CREATE TABLE Table3 (
  ID INT PRIMARY KEY,
  Name VARCHAR(50),
  Age INT
);

-- 创建表4
CREATE TABLE Table4 (
  ID INT PRIMARY KEY,
  Table3ID INT,
  Description VARCHAR(100),
  FOREIGN KEY (Table3ID) REFERENCES Table3(ID)
);

-- 创建表5
CREATE TABLE Table5 (
  ID INT PRIMARY KEY,
  Name VARCHAR(50),
  Age INT
);

-- 插入数据到表1
INSERT INTO Table1 (ID, Name, Age)
VALUES (1, 'Tom', 20),
       (2, 'Jerry', 22),
       (3, 'Alice', 25),
       (4, 'Bob', 30),
       (5, 'David', 28),
       (6, 'Cathy', 27),
       (7, 'Emily', 23),
       (8, 'Frank', 26),
       (9, 'Grace', 29),
       (10, 'Henry', 24);



-- 插入数据到表2
INSERT INTO Table2 (ID, Table1ID, Description)
VALUES (1, 1, 'Description 1'),
       (2, 2, 'Description 2'),
       (3, 3, 'Description 3'),
       (4, 4, 'Description 4'),
       (5, 5, 'Description 5'),
       (6, 6, 'Description 6'),
       (7, 7, 'Description 7'),
       (8, 8, 'Description 8'),
       (9, 9, 'Description 9'),
       (10, 10, 'Description 10');



-- 插入数据到表3
INSERT INTO Table3 (ID, Name, Age)
VALUES (1, 'Lucy', 30),
       (2, 'Mike', 28),
       (3, 'Nancy', 35),
       (4, 'Oliver', 33),
       (5, 'Peter', 31),
       (6, 'Queenie', 29),
       (7, 'Rachel', 26),
       (8, 'Sam', 34),
       (9, 'Tina', 32),
       (10, 'Ulysses', 27);



-- 插入数据到表4
INSERT INTO Table4 (ID, Table3ID, Description)
VALUES (1, 1, 'Description 1'),
       (2, 2, 'Description 2'),
       (3, 3, 'Description 3'),
       (4, 4, 'Description 4'),
       (5, 5, 'Description 5'),
       (6, 6, 'Description 6'),
       (7, 7, 'Description 7'),
       (8, 8, 'Description 8'),
       (9, 9, 'Description 9'),
       (10, 10, 'Description 10');



-- 插入数据到表5
INSERT INTO Table5 (ID, Name, Age)
VALUES (1, 'Vincent', 25),
       (2, 'Wendy', 23),
       (3, 'Xander', 30),
       (4, 'Yvonne', 28),
       (5, 'Zack', 26),
       (6, 'Amy', 29),
       (7, 'Ben', 27),
       (8, 'Cindy', 24),
       (9, 'David', 31),
       (10, 'Emily', 22);


-- 模式匹配查询
SELECT * FROM Table1 WHERE Name LIKE 'T%' -- 查询表1中 Name 以 T 开头的记录

-- Top 查询
SELECT TOP 5 * FROM Table2 -- 查询表2中前5条记录

-- In 查询：
SELECT * FROM Table3 WHERE Age IN (25, 27, 29) -- 查询表3中 Age 为 25、27 或 29 的记录

-- 降序查询：
SELECT * FROM Table4 ORDER BY ID DESC -- 查询表4中按 ID 降序排列的记录

-- Count 集合函数查询：
SELECT COUNT(*) FROM Table5 -- 查询表5中记录的总数

-- 分组统计查询：
SELECT Name, AVG(Age) AS AvgAge FROM Table1 GROUP BY Name -- 查询表1中按 Name 分组，统计每组的平均年龄

-- 连接条件的多表查询：
SELECT Table1.Name, Table2.Description FROM Table1
INNER JOIN Table2 ON Table1.ID = Table2.Table1ID -- 查询表1和表2中 ID 和 Table1ID 相等的记录，返回表1中的 Name 和表2中的 Description

-- 比较运算符的子查询：
SELECT * FROM Table3 WHERE Age > (SELECT AVG(Age) FROM Table3) -- 查询表3中 Age 大于平均年龄的记录

-- In 的子查询：
SELECT * FROM Table4 WHERE Table3ID IN (SELECT ID FROM Table3 WHERE Age > 30) -- 查询表4中 Table3ID 在表3中 Age 大于30的记录的 ID 中的记录
GO

-- 创建视图：
CREATE VIEW View1 AS SELECT Name, Age FROM Table1 -- 创建一个名为 View1 的视图，返回表1中的 Name 和 Age
GO

-- 使用视图
select * from View1;

-- 创建索引：
CREATE INDEX idx_Table1_Name ON Table1 (Name) -- 在表1的 Name 列上创建索引

-- 创建唯一性约束：
ALTER TABLE Table2 ADD CONSTRAINT uc_Table2_Description UNIQUE (Description) -- 在表2的 Description 列上创建唯一性约束

-- 检查约束：
ALTER TABLE Table3 ADD CONSTRAINT ck_Table3_Age CHECK (Age >= 18) -- 在表3的 Age 列上创建检查约束，保证 Age 大于等于18

-- 默认值约束：
ALTER TABLE Table4 ADD CONSTRAINT df_Table4_Description DEFAULT 'No Description' FOR Description 
-- 在表4的 Description 列上创建默认值约束，当插入一条记录时，如果没有指定 Description 的值，将使用 'No Description' 作为默认值

-- 外键约束：
ALTER TABLE Table4 ADD CONSTRAINT fk_Table4_Table3 FOREIGN KEY (Table3ID) REFERENCES Table3(ID) -- 在表4的 Table3ID 列上创建外键约束，参考表3的 ID 列
GO

-- 创建一个存储过程并使用：
CREATE PROCEDURE GetTable1ByID (@ID INT)
AS
BEGIN
  SELECT * FROM Table1 WHERE ID = @ID
END

-- 使用存储过程
EXEC GetTable1ByID 1 -- 查询 Table1 中 ID 为 1 的记录
  SELECT * FROM Table1 
GO

--在某个表上创建一个插入和更新的 DML 触发器：
CREATE TRIGGER trg_Table5_InsertUpdate
ON Table5
AFTER INSERT, UPDATE
AS
BEGIN
  UPDATE t
  SET t.Name = 'Updated Name'
  FROM Table5 t
  INNER JOIN inserted i ON t.ID = i.ID -- 更新 Name 为 'Updated Name'
END
