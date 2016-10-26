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
category_id int,
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
site_product_id int NOT NULL,
category_id int,
site_cat_id int,
short_desc text,
long_desc text,
bullet_text text, -- store json

regular_price real,
was_price real,
sale_price real,

price_range real[],

stock_status boolean,
brand_name text,
sizes text, -- store json string
related_products int[],
related_loved_products int[],
size_chart_id int,
size_chart_table text, -- json
checksum text, -- is used to detect modified product details
seo_title text,
seo_keywords text,
seo_desc text,
shipping_return text,

main_image_url text, -- map with imageSource
additional_images text, -- json, map with additionalImages

is_price_color boolean default false, -- use colorway_pricing_swatches to count how many prices in product

-- product collection
colorway_primary_images text, -- product images by color
colorway_additional_images text, -- product images by color
colorway_pricing_swatches text, -- json, price and color mapping
swatch_color_list text, -- json, color and color image mapping

product_atts text, -- store json string
is_collection boolean default false,
child_site_product_ids int[],
video_id text,
pos int,
url text,
CONSTRAINT products_pkey primary key (id));

alter table products
add column cust_rating text,
add column macys_sale_price real,
add column 

drop table if exists product_price_details;
create table product_price_details
(  
id serial NOT NULL,  
product_id int,  
price real,  
color_name text,  
color_image text,  
product_image text,  
CONSTRAINT product_price_details_pkey primary key (id));

drop table if exists featured_categories;
create table featured_categories
(  
id serial NOT NULL,  
cat_name text,
parent_id int,  
image_url text,  
category_id int,
site_cat_id int,
is_top_sale boolean default false,
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

drop table if exists seo_infos;
create table seo_infos
(
id serial NOT NULL,
page_name text,
seo_title text,
seo_keywords text,
seo_desc text,
CONSTRAINT seo_infos_pkey primary key (id)
);

create index products_site_product_id_idx
on products (site_product_id);

create index category_site_cat_id_idx
on categories (site_cat_id);

create index product_price_details_product_id_color_name_idx
on product_price_details(product_id, color_name);

create index filters_category_id_group_name_idx
on filters(category_id, group_name);


select sale_price, macys_sale_price, cust_rating from products limit 1

truncate categories

select * from categories
where is_shown_in_menu and parent_id = 65

select * from categories
where parent_id = 1327
order by pos;



truncate products;
truncate product_price_details;

truncate left_navs;
truncate featured_categories;

truncate filters

select * from featured_categories


rails runner Scrapper.new.scrape_left_nav
rails runner Scrapper.new.scrape_filters

select * from categories
where site_cat_id = 29891


select * from left_navs
where site_cat_id = 63574

select * from products
where site_product_id = 2967275

select * from categories
where site_cat_id = 31460

select id, size_chart_id, site_product_id, size_chart_table from products
where size_chart_table != '' and site_product_id = 2757441
limit 100

select count(1) from products

"
{
"sizeChartMedia":{"brandName":"Style & Co","categoryName":"Dresses","tabs":["DRESSES- Style & CO"],"bazaarVoice":true,"intimates":false,"footer":"All measurements are approximate.","sizeChartData":[{"sizeChartTitle":"<p><strong>size chart</strong></p>", (...)"


