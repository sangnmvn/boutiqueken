drop table if exists categories;
create table categories
(
id serial NOT NULL,
site_cat_id int,
cat_name text,
group_name text,
pos int,
parent_id int,
is_shown_in_menu boolean default true,
seo_title text,
seo_keywords text,
seo_desc text,
filters text, -- store json string
CONSTRAINT categories_pkey primary key (id)
);

drop table if exists left_navs;
create table left_navs
(
id serial NOT NULL,
cat_id int,
parent_id int,
site_cat_id int,
cat_name text,
group_name text,
pos int,
group_pos int,
seo_title text,
seo_keywords text,
seo_desc text,
CONSTRAINT left_navs_pkey primary key (id)
);

drop table if exists products;
create table products
(id serial NOT NULL,
site_product_id int NOT NULL, -- store Web Id
category_id int,
short_desc text,
long_desc text,
bullet_text text, -- store json
retail_price real,
orginal_price real,
sale_price real,
stock_status boolean,
brand_name text,
product_name text,
main_image_url text,
sizes text, -- store json string
related_products int[],
related_loved_product int[],
size_chart_id int,
checksum text, -- is used to detect modified product details
seo_title text,
seo_keywords text,
seo_desc text,
slider_images text,
is_price_color boolean,
shipping_return text,
CONSTRAINT products_pkey primary key (id));

drop table if exists product_price_details;
create table product_details
(  
id serial NOT NULL,  
product_id int,  
price real,  
color_name text,  
color_image text,  
product_image text,  
CONSTRAINT product_color_details primary key (id))

drop table if exists featured_categories;
create table featured_categories
(  
id serial NOT NULL,  
cat_name text,
parent_id int,  
image_url text,  
category_id int,
site_cat_id int,
is_top_sale boolean,
pos int,
CONSTRAINT featured_categories_pkey primary key (id)
);

drop table if exists filters;
create table filters
(
id serial NOT NULL,
category_id int,
group_name text,
group_pos int,
sub_group_name text,
sub_group_pos int,
filter_ui_type text,
filter_product_field_name text,
filters text, --json: [{name: "", value: "", action: ""}]
CONSTRAINT filters_pkey primary key (id)
);

select * from categories
where cat_name = 'Bath Rugs & Bath Mats'

select * from categories
where id = 454

select cat_name, count(1) from categories
where parent_id is null
group by cat_name


select * from categories
where site_cat_id = 63565


select * from left_navs
where group_name is null
order by pos

select * from left_navs
order by parent_id, group_pos, pos

select seo_desc from categories
where parent_id is null

truncate featured_categories
select * from featured_categories
select * from categories

select * from categories
where parent_id is null

select distinct parent_id from featured_categories

select * from left_navs

select * from categories
where id = 700

select * from categories
where cat_name = 'Bed & Bath'

select * from left_navs
where parent_id = 1
order by group_name, pos


