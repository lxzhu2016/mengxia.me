drop database mengxia_me;
create database mengxia_me;
use mengxia_me;

#系统中的配置项
create table sys_config(
	k nvarchar(255) not null,
	v nvarchar(255)  null
);
#虚拟文件系统的入口点
create table virtual_dirs(
	id int not null,
	url nvarchar(100) not null
);
#虚拟文件
create table virtual_file(
	id bigint not null,
	dir_id int,
	path nvarchar(1024) not null,
	name nvarchar(100) not null,
	mime nvarchar(100),
	size bigint not null,
	modified_on datetime not null		
);

#系统中所有的用户
create table user(
	id bigint auto_increment primary key,
	username nvarchar(255) not null,
	password nvarchar(32) not null,
	nickname nvarchar(32) not null,
	email nvarchar(255) not null
);
#用户的基本信息
create table user_profile(
	user_id bigint not null,
	thumbnail_file_id bigint
);
#地区列表
create table sys_region(
	id int not null, #地区在本系统中的id
	level smallint not null,#地区的级别，分为国家(0)/省(1)/城市(2)/县(3)/街道(乡镇)(4)/居委会(村)(5)
	code nvarchar(100) , #标准编码,如国家编码，中国的行政区编码等
	name nvarchar(100) not null, #名称,系统所使用的语言下的名称，如在中国部署，则无论该地区在哪个国家,此处都填写汉语
	local_name nvarchar(100) not null,#该国家本地语言中的名称
	parent_id int null #上级region的id,上级region的level必须比下级region的level数字小.
);
#用户的地址
#冗余存储了id和name,id用于索引和快速定位.
create table user_address(
	user_id bigint not null,
	country_name nvarchar(100) not null,
	country_id int not null,
	state_name nvarchar(100),
	state_id int,
	city_name nvarchar(100),
	city_id int,
	county_name nvarchar(100),
	county_id int,
	street_name nvarchar(100),
	stree_id int,
	community_name nvarchar(100),
	community_id int,
	address_line nvarchar(100),
	postal_code nvarchar(20)
);
#系统中所有的用户分组
create table group(
	id int not null primary key,
	name nvarchar(32) not null
);
#用户所在的组
create table user_group(
	user_id bigint not null,
	group_id int not null
);

#产品工业分类
create table product_class(
	id int not null,
	name nvarchar(100),
	#扩展信息表
	extension_table nvarchar(100),
	web_view_class nvarchar(200) #web客户端应该理解这个字符串从而做出正确的渲染选择.
);

#产品的基本信息
create table product(
	id bigint auto_increment primary key,
	product_class_id int not null,
	name nvarchar(100) not null,
	rating_stars smallint not null,
	market_price double not null, #市场价
	unit_price double not null #单价,此价格由系统任务根据product_price_list定时更新. 	
);
#该产品的额外标签
create table product_tag(
   product_id bigint not null,
   tag_name nvarchar(100) not null,
   tag_count int not null
);
#产品的评价
create table product_rating(
	product_id bigint not null,
	customer_id bigint not null,
	rating_stars smallint not null,
	title nvarchar(100) not null,
	comment nvarchar(800) not null,
	has_picture char not null,
	created_on datetime not null,
	like_count int not null,
	unlike_count int not null
);

#产品评价的统计信息
create table product_rating_stat(
  product_id bigint not null primary key,
  good_count int not null, #4或者5星的评价为好评
  middle_count int not null,#2或者3星为中评
  bad_count int not null #1星为差评
);
#书籍(一种产品)的扩展表
create table product_book(
	product_id bigint not null primary key,
	published_on datetime not null, #出版日期
	page_count int not null, #页数
	isbn nvarchar(100), #isbn
	language nvarchar(100), #语言
	paper_size nvarchar(10), #开本
	paper_type nvarchar(10),#纸张
	version_number int, #版次
	print_number int ,#印次	
);
#书籍的介绍信息
create table product_book_intro(
	product_id bigint not null primary key, #书籍的产品id
	title nvarchar(100) not null, #介绍信息的title 如编辑介绍,作者介绍，获奖信息
	intro nvarchar(2000) not null, #介绍信息的内容
	intro_order int not null  #介绍信息的显示次序
);

#书籍和作者，译者的关系表，此表为系统中用到的原始数据.
create table product_book_author(
	product_id bigint not null primary key,
	author_id bigint not null,
	author_type smallint not null, 0 表示作者，1表示翻译,2表示其它
);
#书籍有关的视图表(越等于存储视图,但是由代码生成)
create table product_view_book(
	product_id bigint not null primary key,
	authors nvarchar(400) not null, #作者名称列表，使用如下格式[{"I{id}":""},...]的格式，如[I4:"朱良雄"],表示作者为朱良雄,朱良雄的id为4.
	translator nvarchar(400) not null, #译者名称列表，使用和作者列表一样的格式.
);

#产品价格表
create table product_price_list(
	product_id bigint not null,
	start_date datetime not null, #精度为分钟
	end_date datetime not null, #精度为分钟
	price double not null
);
#订单
create table sales_booking(
	id bigint auto_increment primary key,
	customer_id bigint not null,
	customer_address_id bigint not null,
	#最重要的时间节点
	created_on datetime not null,
	paid_on datetime,
	received_on datetime
);
#订单产品项
create table sales_booking_item(
	id bigint auto_increment primary key,
	booking_id bigint not null,
	product_id bigint not null,
	unit_price double not null,
	amount double not null,
	line_price double not null
);

#订单额外费用(折扣也是fee的一种)
create table sales_booking_fee(
	id bigint auto_increment primary key,
	booking_id bigint not null,
	fee_type_id int, #fee_type_id 和fee_type_name对应，但是也可以只有fee_type_name而没有fee_type_id
	fee_type_name nvarchar(100),
	fee_amount double not null
);

#仓库
create table product_warehouse(
	id int not null,
	name nvarchar(100)
);

#库存量
create table proto_product_stock(
	product_id bigint not null,
	warehouse_id int not null,
	amount double not null
);

# 入库单
create table proto_product_stockin(
	product_id bigint not null,
	warehouse_id int not null,
	amount double not null,
	unit_price double not null,
	total_price double not null
);

# 出库单
create table proto_product_stockout(
	
);


	