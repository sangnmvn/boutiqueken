class LeftNav < ActiveRecord::Base
  belongs_to :category, class_name: "Category", foreign_key: "cat_id"
  belongs_to :parent_category, class_name: "Category", foreign_key: "parent_id"
end