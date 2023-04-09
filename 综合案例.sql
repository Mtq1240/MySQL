-- 判断数据库是否存在

IF EXISTS(SELECT * FROM sys.databases WHERE name='StudentDB')

--删除数据库

DROP DATABASE StudentDB
GO

CREATE DATABASE StudentDB -- 创建数据库
ON PRIMARY  -- 定义在主文件组上的文件
(
	NAME=stu_date, -- 逻辑名称
	FILENAME='D:\Student\StudentRecordDB.mdf', -- 物理名称
	SIZE=10MB,
	MAXSIZE=unlimited,
	FILEGROWTH=10%)
	LOG ON
(	
	NAME=stu_log,
	FILENAME='D:\Student\StudentRecordDB.ldf', -- 物理名称
	SIZE=1,
	MAXSIZE=5,
	FILEGROWTH=1
)

use StudentDB
go
-- 创建 系别表 Department 记录
create table Department(
	Departid int primary key,
	departname varchar(20) NOT NULL
);

-- 创建 班级表 Class 记录
create table Class(
	Classid int primary key,
	Classname varchar(10) NOT NULL,
	Specialty varchar(10) NOT NULL,
	Departid int NOT NULL,
	FOREIGN KEY (Departid) REFERENCES Department(Departid)
);

-- 创建 学生表 Student 记录
create table Student (
	Studentid int primary key,
	Studentname varchar(50) NOT NULL,
	Classid int NOT NULL,
	Sex varchar(5) NOT NULL,
	Address varchar(100),
	Postalcode varchar(6),
	Tel varchar(11),
	Enrolldate date NOT NULL,
	Graduatedate date,
	State varchar(10),
	Memo varchar(100),
	FOREIGN KEY (Classid) REFERENCES Class(Classid)
);

-- 创建课程表 Course 记录
create table Course (
	Courseid int primary key,
	Coursename varchar(20) NOT NULL,
	Type varchar(10),
	Mark float NOT NULL
);

-- 创建成绩表 Score 记录
create table Score (
	Studentid int NOT NULL,
	Courseid int NOT NULL,
    Score float NOT NULL,
    primary key(Studentid, Courseid),	-- 唯一的 Studentid 和 Courseid 值
    foreign key (Studentid) REFERENCES Student(Studentid),
    foreign key (Courseid) REFERENCES Course(Courseid)
);

-- 向 Department 表导入数据
insert into Department (Departid, departname) VALUES
(1, '电子信息系'),
(2, '机电系');

-- 向 Class 表导入数据
insert into Class (Classid, Classname, Specialty, Departid) VALUES
(10701,'电子200701','电子信息工程技术',1),
(10702,'电子200702','电子信息工程技术',1),
(10801,'电子200801','电子信息工程技术',1),
(10802,'电子200802','电子信息工程技术',1),
(20701,'电子200701','机电一体化',2),
(20702,'电子200702','机电一体化',2),
(20801,'电子200801','机电一体化',2),
(20802,'电子200802','机电一体化',2);

ALTER TABLE StudentDB.dbo.Class	-- 定义短了
ALTER COLUMN Specialty VARCHAR(30);	

ALTER TABLE StudentDB.dbo.Student
ALTER COLUMN Postalcode varchar(10);

ALTER TABLE StudentDB.dbo.Student
ALTER COLUMN Tel varchar(20);

-- 忘记了 Birthday 列
ALTER TABLE Student
ADD Birthday DATE NOT NULL;


-- 向 Student 表导入数据
insert into Student (Studentid,Studentname,Classid,Sex,Address,Postalcode,Tel,Enrolldate,Graduatedate,State,Memo,Birthday) VALUES
(10701001,'郭玉娇',10701,'女','江苏省南京市','210038','13802748383','2007-9-3',NULL,'在校',NULL,'1988-3-4'),
(10701002,'张蓓蕾',10701,'女','湖北省武汉市','430042','13894749384','2007-9-3',NULL,'在校',NULL,'1988-2-25'),
(10701003,'姜新峰',10701,'男','湖北省襄樊市','441054','13904030284','2007-9-3',NULL,'在校',NULL,'1989-3-6'),
(10702001,'姜住进',10702,'男','江苏省苏州市','215021',NULL,'2007-9-3',NULL,'在校',NULL,'1988-5-4'),
(10702002,'李大春',10702,'男','江苏省常州市','213003',NULL,'2007-9-3',NULL,'在校',NULL,'1988-2-7'),
(10702003,'陆航可',10702,'男','山东省济南市','250021','13905403050','2007-9-3',NULL,'在校',NULL,'1988-2-15'),
(10801001,'徐杰',10801,'男','浙江省杭州市','310020','13907040600','2008-9-1',NULL,'在校',NULL,'1984-4-15'),
(10801002,'胡伟伟',10801,'男','浙江省杭州市','310020',NULL,'2008-9-1',NULL,'休学',NULL,'1989-2-5'),
(10801003,'缪广林',10801,'男','安徽省黄山市','245900',NULL,'2008-9-10',NULL,'在校',NULL,'1989-2-27'),
(10802001,'陈华明',10802,'男','吉林省长春市','130032','13865094948','2008-9-1',NULL,'在校',NULL,'1989-8-12'),
(10802002,'宋金龙',10802,'男','湖南省长沙市','410013','13985839374','2008-9-1',NULL,'在校',NULL,'1989-10-4'),
(10802003,'张赛风',10802,'男','北京市','100081','13958493859','2008-9-1',NULL,'在校',NULL,'1989-4-6'),
(20701001,'闻翠平',20701,'女','江苏省南京市','210056',NULL,'2007-9-3',NULL,'在校',NULL,'1988-5-12'),
(20701002,'李亮',20701,'男','江苏省连云港市','222062',NULL,'2007-9-3',NULL,'在校',NULL,'1988-6-26'),
(20701003,'祁强',20701,'男','江苏省淮安市','223321','13892747201','2007-9-3',NULL,'在校',NULL,'1988-7-4'),
(20702001,'黄晓林',20702,'女','上海市','200061','13869305809','2007-9-3',NULL,'在校',NULL,'1988-4-16'),
(20702002,'张芳',20702,'女','江苏省常州市','213003',NULL,'2007-9-3',NULL,'在校',NULL,'1989-7-17'),
(20702003,'徐海东',20702,'男','安徽省合肥市','230022','13905039583','2007-9-3',NULL,'退学',NULL,'1988-1-7'),
(20801001,'滕荣立',20801,'女','安徽省马鞍市','243061','13705020989','2008-9-1','2009-9-1','退学',NULL,'1989-4-7'),
(20801002,'熙冬梅',20801,'女','浙江省杭州市','320032',NULL,'2008-9-2',NULL,'在校',NULL,'1989-3-8'),
(20801003,'毕志成',20801,'男','江苏省无锡市','214107','13982620500','2008-9-1',NULL,'在校',NULL,'1989-7-25'),
(20802001,'王甲演',20802,'男','江苏省淮安市','223324','13984503988','2008-9-1',NULL,'在校',NULL,'1989-7-3');

-- 向 Course 中导入数据
insert into Course (Courseid,Coursename,Type,Mark) VALUES
(100001,'高等数学','基础课',4),
(100002,'高等数学','基础课',4),
(200101,'高等数学','基础课',4),
(200102,'高等数学','基础课',4),
(200201,'高等数学','基础课',4),
(200202,'高等数学','基础课',4);


-- 向 Score 表导入数据
insert into Score (Studentid,Courseid,Score) VALUES
(10701001,100001,94),
(10701002,100001,47),
(10701003,100001,86),
(10702001,100001,75),
(10702002,100001,87),
(10702003,100001,64),
(20701001,100001,86),
(20701002,100001,59),
(20701003,100001,97),
(20702001,100001,87),
(20702002,100001,84),
(20702003,100001,76),
(10701002,100002,47),
(10701003,100002,48),
(10702001,100002,75),
(10702002,100002,87),
(10702003,100002,64),
(20701001,100002,86),
(20701002,100002,60),
(20701003,100002,97),
(20702001,100002,87),
(20702002,100002,95),
(20702003,100002,75),
(10701001,200101,94),
(10701002,200101,48),
(10701003,200101,86),
(10702001,200101,98),
(10702002,200101,87),
(10702003,200101,96),
(20701001,200201,84),
(20701002,200201,85),
(20701003,200201,38),
(20702001,200201,87),
(20702002,200201,84),
(20702003,200201,76),
(10701001,200102,94),
(10701002,200102,84),
(10701003,200102,86),
(10702001,200102,76),
(10702002,200102,87),
(10702003,200102,64),
(20701001,200202,86),
(20701002,200202,49),
(20701003,200202,97),
(20702001,200202,87),
(20702002,200202,75),
(20702003,200202,97);


							-- 实现 --

-- 1.查询学生表中所有学生的学号和姓名.
select Studentid,Studentname from Student;
-- 2.查询学生表中所有学生的年龄.-- 系统函数getdate,datepart
select Studentname, datepart(YY,GETDATE()) - datepart(YY,Birthday) as'年龄' from Student;
-- 3.-查询学生表班级编号为“10801”的学生学号和姓名。
select Studentid , Studentname , Classid from Student where Classid = '10801';
-- 4.查询所有姓“李”并且名字为两个字的学生姓名和班级编号。
select Studentname , Classid from Student where Studentname like'李_';
-- 5.查询20702班的学生或所有班级的女学生的姓名和电话号码。
select Studentname ,Sex, Tel from Student where Sex = '女' or Classid = '20702';
-- 6.查询所有不姓“李”的学生姓名和班级编号。
select Studentname ,Classid from Student where Studentname not like '李%';
-- 7.查询所有出生日期早于1988年4月1日或晚于1988年7月31日的学生姓名和学号。
select Studentname , Studentid , Birthday from Student where Birthday not between '1988-4-1'and '1988-7-31';
-- 8.查询所有电话号码不为空的学生姓名和学号。
select Studentname , Studentid , Tel from Student where Tel is not NULL;
-- 9.查询10701班所有学生的姓名、学号和出生日期，结果按性别升序和出生日期降序排列。
select Classid , Studentname , Studentid , Birthday , Sex from Student where Classid = '10701' order by Sex asc,Birthday desc;
-- 10.查询课程号为100001的所有成绩，取前5%。
select top(5) percent Studentid , Courseid , Score '成绩' from Score where Courseid =100001 order by Score desc;
-- 11.查询课程号为100001 的所有成绩,取前5名(含并列名次)。
--select top(5) percent Studentid , Courseid , Score '成绩' from Score where
