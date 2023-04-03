--  --------------------------------------- DCL用户管理 -------------------------
# #1.查询用户 :  use mysql ;
#              select * from user;
#2.创建用户 :  create user '用户名'@'主机名' identified by '密码' ;

#3.修改用户密码   :   alter user '用户名'@'主机名' identified with mysql_native_password by '新密码' ;

#4.删除用户 :   drop user '用户名'@'主机名' ;


# 1.创建用户 itcast , 只能够在当前主机localhost访问,密码123456.
create user 'itcast'@'localhost' identified by '123456';

# 2.创建用户 heima ,可以在任意主机访问数据库,密码123456.
create user 'heima'@'%' identified by '123456';

# 3.修改用户 heima 的访问密码为 1234.
alter user 'heima'@'%' identified with mysql_native_password by '1234';

#4.删除itcast@localhost用户.
drop user 'itcast'@'localhost' ;

-- ---------------------- DCL权限查询 ---------------
# 1. 查询权限 : show grants for '用户名'@'主机名' ;

# 2. 授予权限 : grant 权限列表 on 数据库名.表名 to '用户名'@'主机名' ;

# 3. 撤销权限 : revoke 权限列表 on 数据库名.表名 from '用户名'@'主机名' ;


#1. 查询权限
show grants for 'heima'@'%';

#2. 授予权限
grant all on itcast.* to 'heima'@'%';

#3. 撤销权限
revoke all on itcast.* from 'heima'@'%';
