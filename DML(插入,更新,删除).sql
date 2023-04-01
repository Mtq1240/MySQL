# 1.DML-插入数据 : insert into 表名 (字段1,字段2,字段3,...) values (字段1的值,字段2的值,字段3的值,...);
insert into employee(id, workno, name, gender, age, idcard, entrydate) VALUES (1,'1','Itcast','男',10,'123456789012345678','2000-01-01');

# 2.DML-修改数据 : update 表名 set 字段名1=值1,字段名2=值2,... where 条件; 条件可以有也可以没有,没有条件就会修改整张表的值
# (1)修改id为1的数据,将name修改外itheima
update employee set name='itheima' where id=1;
# (2)修改id为1 的数据,将name改为小昭,gender修改为女
update employee set name='小昭' where id=1;
# (3)将所有的员工入职日期修改为 2008-01-01
update employee set entrydate='2008-01-01';

# 3.DML-删除数据 : delete from 表名 where 条件; 条件可以有也可以没有,没有条件就会修改整张表的值  delete 语句不能删除某一个字段(可以使用update).
# (1)删除 gender 为女的员工
delete from employee where gender='女';
# (2)删除所有员工
delete from employee ;
