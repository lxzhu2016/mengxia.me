drop database lxzhu;
create database lxzhu;
use lxzhu;
create table user(
	userid bigint not null auto_increment primary key,
	username nvarchar(100) not null,
	password nvarchar(32) not null
);

create table proto_product_code(
	proto_product_code int not null primary key,
	name nvarchar(100) not null,
	description nvarchar(400),
	mobile_class nvarchar(100),
	backend_web_class nvarchar(100),
	frontend_web_class nvarchar(100),
	extenstion_table_name nvarchar(100)
);

create table proto_product(
	proto_product_id bigint not null auto_increment primary key,
	proto_product_code int not null,
	proto_product_name nvarchar(100) not null,
	proto_product_description nvarchar(2000) null
);

create table proto_product_option(
	id bigint not null auto_increment primary key,
	proto_product_code int not null,
	identifier_name nvarchar(100) not null,
  label nvarchar(100) not null,
  data_type_id int not null
);	

create table sys_data_type(
	id int not null primary key,
	name nvarchar(36) not null
);





