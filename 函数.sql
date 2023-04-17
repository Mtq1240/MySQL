        -- 函数演示 --
    -- 语法: select 函数(参数);
-- 1.字符串函数
-- concat(拼接字符串)
select concat('hello','MySQL');

-- lower(转换为小写字母)
select  lower('Hello');

-- upper(转换为大写字母)
select upper('hello');

-- lpad(左边补齐)
select lpad('01',5,'-');

-- rpad(右边补齐)
select rpad('01',5,'-');

-- trim(去除头部和尾部空格,中间空格还在)
select trim(' hello MySQL ');

-- substring(返回当前字符串的前len个字符)
select substring('hello MySQL',1,5);

-- 1.企业员工的工号,统一为5位数, 目前不足5位数的全部在前面补0.比如: 1号员工的工号应该是00001.
update emp set workno = lpad(workno,5,'0');


-- 2.数值函数
-- ceil (向上取整)
select ceil(1.5);

-- floor(向下取整)
select floor(1.1);

-- mod(求模 7%4)
select mod(3,4);

-- rand(生成 0~1 之间的随机数)
select rand();

-- roune(四舍五入,保留几位小数)
select round(2.345,2);

-- 需求 : 通过数据库的函数,生成一个六位数的随机验证码.(0.01*1000000=10000,所以再加个 lpad 函数,不足 6 位补 0)
select lpad(round(rand()*1000000 , 0),6,'0');



-- 3.日期函数
-- curdate(当前日期)
select curdate();

-- curtime(当前时间)
select curtime();

-- now(当前日期和时间)
select now();

-- year , month , day
select YEAR(now()); -- 当前日期 now ,所属年份 year

select MONTH(now()); -- 当前日期 now ,所属月份 month

select DAY(now()); -- 当前日期 now ,所属日期 day

-- date_add(返回一个日期/时间,加上一个时间间隔后的时间值)
select date_add(now(),INTERVAL 70 DAY );   -- now 当前时间 (INTERVAL 固定写法) ,加上 70day 后的时间/日期.
select date_add(now(),INTERVAL 70 MONTH );
select date_add(now(),INTERVAL 70 YEAR );

-- datediff(两个指定时间之间相差的天数),第一个时间 - 第二个时间
select datediff('2023-4-17','2022-4-17');

-- 需求 : 查询所有员工的入职天数,并根据入职天数倒序排序.
select name,datediff(curdate(),entrydate) as 'entrydays' from emp order by entrydays desc;
-- 时间相减函数datediff( 当前时间函数curdate - 列表名 entrydate) desc降序


-- 4.流程函数
-- if(判断是否为 true ,为 true 返回 ok ,不是返回 Error)
select if(true,'ok','Error');

-- ifnull(判断非空,非空返回 ok ,空则返回后面的 default)
select ifnull('ok','default');

select ifnull('','default');  -- 字符串 空,返回空字符串

select ifnull(null ,'default');  -- 返回 null

-- case when then else end
-- 需求:查询 emp 表的员工姓名合工作地址(如果是北京或者上海返回 ---> 一线城市 ,其他返回 ---> 二线城市 )
select
       name,
       ( case workaddress when '北京' then '一线城市' when '上海' then '一线城市' else '二线城市' end ) as '工作地址'
from emp;

-- 需求:统计班级各个学员的成绩, 展示的规则如下:
-- >=85,展示优秀,
-- >=60,展示及格,
-- 其他,展示不及格.
                    -- 创建成绩表
create table score (
    id int comment 'ID',
    name varchar(20) comment '姓名',
    math int comment '数学',
      english int comment '英语',
    chinese int comment '语文'
) comment '学员成绩表';
insert into score(id, name, math, english, chinese) VALUES (1,'Tom',67,88,95),(2,'Rose',23,66,90),(3,'Jack',56,98,76);

--
select
    id,name,
        (case when math >=80 then '优秀' when math >= 60 then '及格' else '不及格' end) '数学',
        (case when english >=80 then '优秀' when english >= 60 then '及格' else '不及格' end) '英语',
        (case when chinese >=80 then '优秀' when chinese >= 60 then '及格' else '不及格' end) '语文'
from score;
