-- 创建用户表 添加约束
create table user (
    id int primary key auto_increment comment '主键',
    name varchar(10) not null unique comment '姓名',
    age int check ( age >0 &&age <= 120 ) comment '年龄',
    status char(1) default '1' comment '状态',
    genter char(1) comment '性别'
) comment '用户表';

-- 插入数据
insert into user (name,age,status,genter) values ('Tom',19,'1','男'),('Tom1',23,'0','男'),('Tom2',22,'0','男');

insert into user (name,age,status,genter) values ('Tom2',19,'1','男');




-- --------------------------------------------- 约束 (外键) -------------------------------------
-- 准备数据
create table dept(
    id   int auto_increment comment 'ID' primary key,
    name varchar(50) not null comment '部门名称'
)comment '部门表';
INSERT INTO dept (id, name) VALUES (1, '研发部'), (2, '市场部'),(3, '财务部'), (4, '销售部'), (5, '总经办');


create table emp(
    id  int auto_increment comment 'ID' primary key,
    name varchar(50) not null comment '姓名',
    age  int comment '年龄',
    job varchar(20) comment '职位',
    salary int comment '薪资',
    entrydate date comment '入职时间',
    managerid int comment '直属领导ID',
    dept_id int comment '部门ID'
)comment '员工表';

INSERT INTO emp (id, name, age, job,salary, entrydate, managerid, dept_id) VALUES
            (1, '金庸', 66, '总裁',20000, '2000-01-01', null,5),(2, '张无忌', 20, '项目经理',12500, '2005-12-05', 1,1),
            (3, '杨逍', 33, '开发', 8400,'2000-11-03', 2,1),(4, '韦一笑', 48, '开发',11000, '2002-02-05', 2,1),
            (5, '常遇春', 43, '开发',10500, '2004-09-07', 3,1),(6, '小昭', 19, '程序员鼓励师',6600, '2004-10-12', 2,1);


-- 添加外键
alter table emp add constraint dept_id foreign key (dept_id) references dept (id);

-- 删除外键
-- 语法 : alter table 表名 drop foreign key 外键名称;

alter table emp drop foreign key dept_id;


-- ---------------------------------- 删除/更新行为 -----------------------------

-- 语法 : alter table 表名 add constraint 外键名称 foreign key (外键字段) references 主表名 (主表字段名) on update cascade on DELETE cascade ;

-- 实现 :
-- cascade:
alter table emp add constraint dept_id foreign key (dept_id) references dept (id) on update cascade on delete cascade;

-- set null:
alter table emp add constraint dept_id foreign key (dept_id) references dept (id) on update set null on delete set null ;


