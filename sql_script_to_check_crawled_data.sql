-- truncate categories
-- truncate left_navs
-- truncate featured_categories
-- truncate filters

select * from filters
where category_id = 34051

select * from categories
where site_cat_id = 34051

select * from filters
where category_id in (4068)

select * from filters

select * from categories
where site_cat_id = 63538

select * from left_navs
where parent_id = 3102
order by pos

select * from categories
where cat_name ilike '%All plus size%'

select * from left_navs
where parent_id = 2594

truncate filters


select id, site_cat_id into products_bk_20161101 from products

update products
set site_cat_id = convert_to_integer(split_part(url, 'CategoryID=',2))
where site_cat_id != convert_to_integer(split_part(url, 'CategoryID=',2))


alter table products
drop column is_child

select is_child from products


select c.cat_name, c.site_cat_id, c.parent_id, p.cat_name from categories c
join categories p on p.id = c.parent_id
where c.seo_title is null

select * from categories
where id = 3689

select * from left_navs
where parent_id = 3689

select * from filters
where category_id = 3689

-- Check left-nav of HOME
select id from categories where cat_name = 'WOMEN'

select id, site_cat_id, cat_name, group_name, parent_id from categories
where id in (
	select id from categories where parent_id = 6204 and is_shown_in_menu = true
	except
	(select parent_id from left_navs where parent_id in (
	select id from categories where parent_id = 6204))
	except
	select category_id from filters where category_id in (
	select id from categories where parent_id = 6204
	)
)

6830
6245
6911
7862


select * from left_navs
where parent_id = 7862

select c.id, c.cat_name, p.cat_name, c.is_shown_in_menu, c.parent_id from categories c
join categories p on p.id = c.parent_id
where c.site_cat_id = 68223

select * from left_navs
where parent_id = 6830

select * from filters
where category_id in (6124)

select * from categories where id = 6082

select id, site_cat_id, cat_name, parent_id, seo_title, seo_desc, seo_keywords
from categories
where seo_title is null and is_shown_in_menu = true

truncate categories;
truncate left_navs;
truncate featured_categories;
truncate filters;


select * from product_price_details
limit 100

select count(1) from filters


create index products_site_product_id_idx
on products (site_product_id);

create index category_site_cat_id_parent_id_idx
on categories (site_cat_id, parent_id);

create index product_price_details_product_id_color_name_idx
on product_price_details(product_id, color_name);

create index product_price_details_product_ididx
on product_price_details(product_id);

create index filters_category_id_group_name_idx
on filters(category_id, group_name);

create index filters_category_id_group_name_sub_group_name_idx
on filters(category_id, group_name, sub_group_name);

select count(1) from left_navs
select count(1) from categories
select * from featured_categories

select id from categories
where parent_id is null;

select n.cat_name, n.group_name, c.cat_name, n.pos from left_navs n
join categories c on c.id = n.parent_id
where c.parent_id is null
order by c.id, n.group_name, n.pos

select * from categories
where parent_id in (select id from categories
where parent_id is null) 
and is_shown_in_menu and (group_name is null or  group_name = '')

select id from categories
where is_shown_in_menu and parent_id = any(
	select id from categories
	where cat_name = 'HOME' and parent_id is null
)
except

-- Check menu
-- + List of menu
SELECT cat_name, pos FROM categories WHERE parent_id is null
ORDER BY pos;

-- + List of sub-menu
SELECT cat_name, group_name FROM categories
WHERE is_shown_in_menu AND parent_id = any(
	select id from categories
	where parent_id is null
) order by parent_id, pos

-- + Check SEO info
SELECT seo_title, seo_desc, seo_keywords, cat_name, pos 
FROM categories 
WHERE parent_id is null and
seo_title is null and seo_desc is null and seo_keywords is null;

-- Check left-nav
-- + Menu-> left-nav
SELECT * FROM left_navs
WHERE parent_id = any(
	SELECT id FROM categories WHERE cat_name = 'HOME' and parent_id is null
)

-- + Sub-menu -> left-nav
SELECT * FROM categories
WHERE id IN (
	SELECT id FROM categories
	WHERE parent_id = any(
		SELECT id FROM categories WHERE cat_name = 'JEWELRY' and parent_id is null
	)
	and is_shown_in_menu = true

	EXCEPT

	select distinct parent_id from left_navs
	where parent_id in (
		SELECT id FROM categories
		WHERE parent_id = any(
			SELECT id FROM categories WHERE cat_name = 'JEWELRY' and parent_id is null
		)
		and is_shown_in_menu = true
	)

	EXCEPT

	select distinct category_id from filters
	where category_id in (
		SELECT id FROM categories
		WHERE parent_id = any(
			SELECT id FROM categories WHERE cat_name = 'JEWELRY' and parent_id is null
		)
		and is_shown_in_menu = true
	)
)

-- Check featured categories
-- Check filters

-- truncate products;
-- truncate product_price_details;

select * from left_navs
where parent_id = 18936
order by pos

select * from categories
where id = 18787

select * from categories
where site_cat_id = 63573

select * from filters
where category_id = 18848


