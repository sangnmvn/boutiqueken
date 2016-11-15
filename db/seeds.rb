# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Add FAKE category to demo
# id serial NOT NULL,
# cat_name text,
# pos int,
# parent_id int,
# seo_title text,
# seo_keywords text,
# seo_desc text,
# filters text, -- store json string
Category.create({:cat_name => "HOME",pos: 1})
Category.create({:cat_name => "BED & BATH",pos: 2})
Category.create({:cat_name => "WOMEN",pos: 3})
Category.create({:cat_name => "MEN",pos: 4})
Category.create({:cat_name => "JUNIORS",pos: 5})
Category.create({:cat_name => "KID",pos: 6})
Category.create({:cat_name => "ACTIVE",pos: 7})
Category.create({:cat_name => "BEAUTY",pos: 8})
Category.create({:cat_name => "SHOES",pos: 9})
Category.create({:cat_name => "HANDBAGS",pos: 10})
Category.create({:cat_name => "JEWELRY",pos: 11})
Category.create({:cat_name => "WATCHES",pos: 12})
Category.create({:cat_name => "BRANDS",pos: 13})

#HOME CHILDREN
home = Category.where(:cat_name =>"HOME").first
Category.create({:cat_name => "Home essentials",pos: 1,parent_id: home.id})
Category.create({:cat_name => "Kitchen",pos: 2,parent_id: home.id})
Category.create({:cat_name => "Dining & entertainment",pos: 3,parent_id: home.id})
Category.create({:cat_name => "Furniture",pos: 4,parent_id: home.id})
Category.create({:cat_name => "Home Furnishing",pos: 5,parent_id: home.id})
Category.create({:cat_name => "Special Shops",pos: 6,parent_id: home.id})
Category.create({:cat_name => "Our best home brands",pos: 7,parent_id: home.id})

#HOME ESSENTIALS CHILDREN

home_ess = Category.where(:cat_name =>"Home essentials").first
Category.create({:cat_name => "BED & BATH",pos: 1,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH2",pos: 2,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH3",pos: 3,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH4",pos: 4,parent_id: home_ess.id})

home_ess = Category.where(:cat_name =>"Kitchen").first
Category.create({:cat_name => "BED & BATH",pos: 1,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH2",pos: 2,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH3",pos: 3,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH4",pos: 4,parent_id: home_ess.id})

home_ess = Category.where(:cat_name =>"Dining & entertainment").first
Category.create({:cat_name => "BED & BATH",pos: 1,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH2",pos: 2,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH3",pos: 3,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH4",pos: 4,parent_id: home_ess.id})


home_ess = Category.where(:cat_name =>"Furniture").first
Category.create({:cat_name => "BED & BATH",pos: 1,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH2",pos: 2,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH3",pos: 3,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH4",pos: 4,parent_id: home_ess.id})

home_ess = Category.where(:cat_name =>"Home Furnishing").first
Category.create({:cat_name => "BED & BATH",pos: 1,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH2",pos: 2,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH3",pos: 3,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH4",pos: 4,parent_id: home_ess.id})


home_ess = Category.where(:cat_name =>"Special Shops").first
Category.create({:cat_name => "BED & BATH",pos: 1,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH2",pos: 2,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH3",pos: 3,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH4",pos: 4,parent_id: home_ess.id})

home_ess = Category.where(:cat_name =>"Our best home brands").first
Category.create({:cat_name => "BED & BATH",pos: 1,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH2",pos: 2,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH3",pos: 3,parent_id: home_ess.id})
Category.create({:cat_name => "BED & BATH4",pos: 4,parent_id: home_ess.id})

