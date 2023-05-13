-- ---------------------------- 事务操作 ----------------------------
-- 数据准备
create table account(
    id int auto_increment primary key comment '主键ID',
    name varchar(10) comment '姓名',
    money int comment '余额'
) comment '账户表';
insert into account(id, name, money) VALUES (null,'张三',2000),(null,'李四',2000);

-- 恢复数据
update account set money = 2000 where name = '张三' or name = '李四';



select @@autocommit; -- 查询当前事务执行方式, 查询结果 0 为手动提交 , 1 为自动提交

set @@autocommit = 0; -- 设置为手动提交

-- 转账操作 (张三给李四转账1000)
-- 1. 查询张三账户余额
select * from account where name = '张三';

-- 2. 将张三账户余额-1000
update account set money = money - 1000 where name = '张三';

程序执行报错 ... -- 这里程序执行错误,前面两条语句执行,下面语句不会执行

-- 3. 将李四账户余额+1000
update account set money = money + 1000 where name = '李四';

-- 事务执行成功,没有错误则 提交事务 手动提交
commit;

-- 回滚事务 如果执行过程出错,则执行回滚操作,返回初始值
rollback ;



-- 方式二
-- 转账操作 (张三给李四转账1000)
start transaction ;  -- 开启事务

-- 1. 查询张三账户余额
select * from account where name = '张三';

-- 2. 将张三账户余额-1000
update account set money = money - 1000 where name = '张三';

程序执行报错 ... -- 这里程序执行错误,前面两条语句执行,下面语句不会执行

-- 3. 将李四账户余额+1000
update account set money = money + 1000 where name = '李四';


-- 事务执行成功,没有错误则 提交事务 手动提交
commit;

-- 回滚事务 如果执行过程出错,则执行回滚操作,返回初始值
rollback;




-- 查看事务隔离级别
select @@transaction_isolation;

-- 设置事务隔离级别
set session transaction isolation level read uncommitted ;

set session transaction isolation level repeatable read ;
















