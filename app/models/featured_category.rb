class FeaturedCategory < ActiveRecord::Base
  belongs_to :parent_category, class_name: "Category", foreign_key: "parent_id"
  belongs_to :category
end