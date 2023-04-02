
-- 先删除表 --
drop table employee;


                                        -- ---------- DQL查询数据 ---------- --
#       基本查询 :
#       1.查询多个字段 :  select 字段1,字段2,字段3 ... from 表名;
#                       select * from 表名;
#       2.设置别名 :      select 字段1 [ as 别名1 ],字段2 [ as 别名2 ]... from 表名;
#       3.去除重复记录 :   select distinct 字段列表 from 表名;


-- 数据准备 ---
create table emp
(
    id          int comment '编号',
    workno      varchar(10) comment '工号',
    name        varchar(10) comment '姓名',
    gender      char(1) comment '性别',
    age         tinyint unsigned comment '年龄',
    idcard      char(18) comment '身份证号',
    workaddress varchar(50) comment '工作地址',
    entrydate   date comment '入职时间'
) comment '员工表';

insert into emp(id, workno, name, gender, age, idcard, workaddress, entrydate)
VALUES (1, '1', '柳岩', '女', 20, '123456789012345678', '北京', '2000-01-01'),
       (2, '2', '张无忌', '男', 18, '123456789012345670', '北京', '2005-09-01'),
       (3, '3', '韦一笑', '女', 38, '123456789012345670', '上海', '2005-08-01'),
       (4, '4', '赵敏', '女', 18, '123456789012345670', '北京', '2009-12-01'),
       (5, '5', '小昭', '女', 16, '123456789012345678', '上海', '2007-07-01'),
       (6, '6', '杨逍', '男', 28, '12345678901234567X', '北京', '2006-01-01'),
       (7, '7', '范瑶', '男', 40, '123456789012345670', '北京', '2005-05-01'),
       (8, '8', '黛绮丝', '女', 38, '123456789012345670', '天津', '2015-05-01'),
       (9, '9', '范凉凉', '女', 45, '123456789012345678', '北京', '2010-04-01'),
       (10, '10', '陈友谅', '男', 53, '123456789012345670', '上海', '2011-01-01'),
       (11, '11', '张士诚', '男', 55, '123456789012345670', '江苏', '2015-05-01'),
       (12, '12', '常遇春', '男', 32, '123456789012345670', '北京', '2004-02-01'),
       (13, '13', '张三丰', '男', 88, '123456789012345678', '江苏', '2020-11-01'),
       (14, '14', '灭绝', '女', 65, '123456789012345670', '西安', '2019-05-01'),
       (15, '15', '胡青牛', '男', 70, '12345678901234567X', '西安', '2018-04-01'),
       (16, '16', '周芷若', '女', 18, null, '北京', '2012-06-01');

-- --------------------------------------- 查询需求 ------------------------------- --

-- ----------------------- 基本查询 -------------
-- 练习:
-- 1.查询指定字段 name , workno , age 返回
select name,workno,age from emp;

-- 2.查询所有字段返回 ---
select id, workno, name, gender, age, idcard, workaddress, entrydate from emp;

select * from emp;

-- 3.查询所有员工的工作地址 ,起别名 --
select workaddress  as '工作地址' from emp;
select workaddress '工作地址' from emp;

-- 4.查询公司员工的上班地址(不要重复)
select distinct workaddress  as '工作地址' from emp;


-- ----------------------- 条件查询 -------------
#         语法  :  select 字段列表 from 表名 where 条件列表;

# 1.查询年龄等与 88 的员工
select * from emp where age = 88;

#2.查询年龄小于 20 的员工信息
select * from emp where age < 20;

#3. 查询年龄小于等于 20 的员工员工信息
select * from emp where age <= 20;

#4. 查询没有身份证号的员工信息
select * from emp where idcard is null;

#5. 查询所有身份证号的员工信息
select * from emp where idcard is not null;

#6. 查询年龄不等于 88 的员工信息
select * from emp where age != 88;
select * from emp where age <> 88;

#7.查询年龄在 15岁(包含) 到 20岁(包含)之间的员工信息
select * from emp where age >=15 && age<=20;
select * from emp where age >=15 and age<=20;
select * from emp where age between 15 and age<=20;

#8. 查询性别为 女 且年龄小于 25岁的员工信息
select * from emp where gender='女' and age < 25;

#9. 查询年龄等于 18 或 20 或 40 的员工信息
select * from emp where age=18 or age=20 or age=40;
select * from emp where age in (18,20,40);

#10. 查询姓名为两个字的员工信息 like 模糊查询:'_','%'
select * from emp where name like '__';

#11. 查询身份证号最后一位是X的员工信息
select * from emp where idcard like '_________________X';
select * from emp where idcard like '%X';


-- ----------------------- 聚合函数 -------------
#       聚合函数: null值不参与聚合函数计算
#         语法  : select 聚合函数 (字段列表) from 表名;

#1. 统计该企业员工数量
select count(*) from emp;
select count(idcard) from emp;

#2. 统计该企业员工的平均年龄
select avg(age) from emp;

#3. 统计该企业员工的最大年龄
select max(age) from emp;

#4. 统计该企业员工的最小年龄
select min(age) from emp;

#5. 统计西安地区员工的年龄之和
select sum(age) from emp where workaddress='西安';


-- ----------------------- 分组查询 -------------
#     select 字段列表 from 表名 [where 条件] group by 分组字段名 [having 分组后过滤条件];
# 2. where与having区别
# 执行时机不同: where是分组之前进行过滤，不满足where条件，不参与分组;而having是分组之后对结果进行过滤。
# 判断条件不同: where不能对聚合函数进行判断，而having可以。

#1. 根据性别分组,统计男性员工 和 女性员工的数量
select gender,count(*) from emp group by gender ;

#2. 根据性别分组, 统计男性员工 和 女性员工的平均年龄
select gender,avg(age) from emp group by gender ;

#3. 查询年龄小于 45 的员工, 并根据工作地址分组,获取员工数量大于等于3的工作地址
select workaddress,count(*) address_count from emp where age < 45 group by workaddress having address_count >= 3;


-- ----------------------- 排序查询 -------------
#1. 语法 : select 字段列表 from 表名 order by 字段1 排序方式1,字段2 排序方式2;
#2. 排序方式: ASC: 升序(默认) ; DESC: 降序
#注意: 如果是多字段排序,当第一个字段值相同时,才会根据第二个字段进行排序.

#1. 根据年龄对公司员工进行升序排序
select * from emp order by age asc;
select * from emp order by age;

#2.根据入职时间,对公司员工进行降序排序
select * from emp order by entrydate desc;

#3.根据年龄对公司员工进行升序排序,年龄相同,再按照入职时间对公司员工进行降序排序.
select * from emp order by age asc , entrydate desc;

-- ----------------------- 分页查询 -------------
#1. 语法 : select 字段列表 from 表名 limit 起始索引,查询记录数;
#注意:    起始索引从0开始, 起始索引= (查询页码-1) * 每页显示记录数.
#        分页查询是数据库的方言,不同的数据库有不同的实现,MySQL中是LIMIT.
#        如果查询的是第一页数据,起始索引可以省略,直接简写成 limit 10.

#1. 查询第1页员工数据,每页展示10条记录.
select * from emp limit 0,10;
select * from emp limit 10;

#2. 查询第2页员工数据,每页显示10条记录.
select * from emp limit 10,10;

                                            --  案例练习 --
# 1．查询年龄为20,21,22,23岁的女性员工信息。
select * from emp where gender='女' and age in(20,21,22,23);

# 2．查询性别为男,并且年龄在20-40岁(含)以内的姓名为三个字的员工。
select * from emp where gender='男' and (age between 20 and 40) and name like '___';

# 3．统计员工表中,年龄小于60岁的，男性员工和女性员工的人数。
select gender, count(*) from emp where age < 60 group by gender;

# 4.查询所有年龄小于等于35岁员工的姓名和年龄，并对查询结果按年龄升序排序，如果年龄相同按入职时间降序排序。
select name , age from emp where age <= 35 order by age asc,entrydate desc  ;

# 5、查询性别为男，且年龄在20-40岁(含)以内的前5个员工信息，对查询的结果按年龄升序排序，年龄相同按入职时间升序排序。
select * from emp where gender='男' and (age between 20 and 40) order by age asc,entrydate asc limit 0 , 5;
