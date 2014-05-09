drop database mengxia_me;
create database mengxia_me;
use mengxia_me;

#ϵͳ�е�������
create table sys_config(
	k nvarchar(255) not null,
	v nvarchar(255)  null
);
#�����ļ�ϵͳ����ڵ�
create table virtual_dirs(
	id int not null,
	url nvarchar(100) not null
);
#�����ļ�
create table virtual_file(
	id bigint not null,
	dir_id int,
	path nvarchar(1024) not null,
	name nvarchar(100) not null,
	mime nvarchar(100),
	size bigint not null,
	modified_on datetime not null		
);

#ϵͳ�����е��û�
create table user(
	id bigint auto_increment primary key,
	username nvarchar(255) not null,
	password nvarchar(32) not null,
	nickname nvarchar(32) not null,
	email nvarchar(255) not null
);
#�û��Ļ�����Ϣ
create table user_profile(
	user_id bigint not null,
	thumbnail_file_id bigint
);
#�����б�
create table sys_region(
	id int not null, #�����ڱ�ϵͳ�е�id
	level smallint not null,#�����ļ��𣬷�Ϊ����(0)/ʡ(1)/����(2)/��(3)/�ֵ�(����)(4)/��ί��(��)(5)
	code nvarchar(100) , #��׼����,����ұ��룬�й��������������
	name nvarchar(100) not null, #����,ϵͳ��ʹ�õ������µ����ƣ������й����������۸õ������ĸ�����,�˴�����д����
	local_name nvarchar(100) not null,#�ù��ұ��������е�����
	parent_id int null #�ϼ�region��id,�ϼ�region��level������¼�region��level����С.
);
#�û��ĵ�ַ
#����洢��id��name,id���������Ϳ��ٶ�λ.
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
#ϵͳ�����е��û�����
create table group(
	id int not null primary key,
	name nvarchar(32) not null
);
#�û����ڵ���
create table user_group(
	user_id bigint not null,
	group_id int not null
);

#��Ʒ��ҵ����
create table product_class(
	id int not null,
	name nvarchar(100),
	#��չ��Ϣ��
	extension_table nvarchar(100),
	web_view_class nvarchar(200) #web�ͻ���Ӧ���������ַ����Ӷ�������ȷ����Ⱦѡ��.
);

#��Ʒ�Ļ�����Ϣ
create table product(
	id bigint auto_increment primary key,
	product_class_id int not null,
	name nvarchar(100) not null,
	rating_stars smallint not null,
	market_price double not null, #�г���
	unit_price double not null #����,�˼۸���ϵͳ�������product_price_list��ʱ����. 	
);
#�ò�Ʒ�Ķ����ǩ
create table product_tag(
   product_id bigint not null,
   tag_name nvarchar(100) not null,
   tag_count int not null
);
#��Ʒ������
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

#��Ʒ���۵�ͳ����Ϣ
create table product_rating_stat(
  product_id bigint not null primary key,
  good_count int not null, #4����5�ǵ�����Ϊ����
  middle_count int not null,#2����3��Ϊ����
  bad_count int not null #1��Ϊ����
);
#�鼮(һ�ֲ�Ʒ)����չ��
create table product_book(
	product_id bigint not null primary key,
	published_on datetime not null, #��������
	page_count int not null, #ҳ��
	isbn nvarchar(100), #isbn
	language nvarchar(100), #����
	paper_size nvarchar(10), #����
	paper_type nvarchar(10),#ֽ��
	version_number int, #���
	print_number int ,#ӡ��	
);
#�鼮�Ľ�����Ϣ
create table product_book_intro(
	product_id bigint not null primary key, #�鼮�Ĳ�Ʒid
	title nvarchar(100) not null, #������Ϣ��title ��༭����,���߽��ܣ�����Ϣ
	intro nvarchar(2000) not null, #������Ϣ������
	intro_order int not null  #������Ϣ����ʾ����
);

#�鼮�����ߣ����ߵĹ�ϵ���˱�Ϊϵͳ���õ���ԭʼ����.
create table product_book_author(
	product_id bigint not null primary key,
	author_id bigint not null,
	author_type smallint not null, 0 ��ʾ���ߣ�1��ʾ����,2��ʾ����
);
#�鼮�йص���ͼ��(Խ���ڴ洢��ͼ,�����ɴ�������)
create table product_view_book(
	product_id bigint not null primary key,
	authors nvarchar(400) not null, #���������б�ʹ�����¸�ʽ[{"I{id}":""},...]�ĸ�ʽ����[I4:"������"],��ʾ����Ϊ������,�����۵�idΪ4.
	translator nvarchar(400) not null, #���������б�ʹ�ú������б�һ���ĸ�ʽ.
);

#��Ʒ�۸��
create table product_price_list(
	product_id bigint not null,
	start_date datetime not null, #����Ϊ����
	end_date datetime not null, #����Ϊ����
	price double not null
);
#����
create table sales_booking(
	id bigint auto_increment primary key,
	customer_id bigint not null,
	customer_address_id bigint not null,
	#����Ҫ��ʱ��ڵ�
	created_on datetime not null,
	paid_on datetime,
	received_on datetime
);
#������Ʒ��
create table sales_booking_item(
	id bigint auto_increment primary key,
	booking_id bigint not null,
	product_id bigint not null,
	unit_price double not null,
	amount double not null,
	line_price double not null
);

#�����������(�ۿ�Ҳ��fee��һ��)
create table sales_booking_fee(
	id bigint auto_increment primary key,
	booking_id bigint not null,
	fee_type_id int, #fee_type_id ��fee_type_name��Ӧ������Ҳ����ֻ��fee_type_name��û��fee_type_id
	fee_type_name nvarchar(100),
	fee_amount double not null
);

#�ֿ�
create table product_warehouse(
	id int not null,
	name nvarchar(100)
);

#�����
create table proto_product_stock(
	product_id bigint not null,
	warehouse_id int not null,
	amount double not null
);

# ��ⵥ
create table proto_product_stockin(
	product_id bigint not null,
	warehouse_id int not null,
	amount double not null,
	unit_price double not null,
	total_price double not null
);

# ���ⵥ
create table proto_product_stockout(
	
);


	