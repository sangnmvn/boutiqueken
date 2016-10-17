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

drop table if exists products;
create table products
(
id serial NOT NULL,
sku int NOT NULL, -- store Web Id
short_desc text,
long_desc text,
reg_price real,
sale_price real,
stock_status boolean,
img_urls text, -- store json string, img depends on color
colors text, -- store json string
sizes text, -- store json string
size_chart_url text,
size_chart_table text,
related_products int[],
checksum text, -- is used to detect modified product details
seo_title text,
seo_keywords text,
seo_desc text,
CONSTRAINT products_pkey primary key (id)
);
