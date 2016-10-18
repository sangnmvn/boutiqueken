drop table if exists categories;
create table categories
(
id serial NOT NULL,
cat_name text,
pos int,
parent_id int,
seo_title text,
seo_keywords text,
seo_desc text,
filters text, -- store json string
CONSTRAINT categories_pkey primary key (id)
);

drop table if exists featured_categories;
create table featured_categories(
  id serial NOT NULL,
  parent_category_id int,
  image_url text,
  category_id int,
  is_top_sale boolean,
  CONSTRAINT featured_categories_pkey primary key (id)
);


drop table if exists products;
create table products
(
id serial NOT NULL,
sku int NOT NULL, -- store Web Id
category_id int,
short_desc text,
long_desc text,
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
CONSTRAINT products_pkey primary key (id)
);

drop table if exists product_details;
create table product_details(
  id serial NOT NULL,
  product_id int,
  price real,
  color_name text,
  color_image text,
  product_image text,

  CONSTRAINT product_details_pkey primary key (id)
)
