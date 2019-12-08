--当表格存在时，删除它
CREATE DATABASE `tdschool`;
use `tdschool`;
DROP TABLE `td_student` IF EXISTS;
CREATE TABLE `td_student`(
	`id` int(11) unsigned auto_increment primary key,
	`uname` varchar(255) not null,-- 用户登录账号，具有唯一性
	`unick` varchar(255) default null,--昵称
	`ugender` enum('男','女'),--性别
	`upass` char(32) not null,--密码,固定32位长度，为了做md5加密
	`addtime` timestamp not null default CURRENT_TIMESTRAMP,-- 添加时间 直接写入，不需要赋值
	`deltime` int(10) default null,-- 删除时间，作为一个删除标记，当做用户删除的时候是修改当前标记，而非从数据库里直接删除，保证数据结构完整性，便于意外删除的数据恢复
);

delete from `tdschool` where id>1;
alter table `tdschool` add unique index(uname);

