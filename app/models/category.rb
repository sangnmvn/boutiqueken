class Category < ActiveRecord::Base

  has_many :children, class_name: "Category", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Category", foreign_key: "parent_id"
  has_many :left_navs, foreign_key: "parent_id"
  
  has_many :feature_categories
  def self.main_menus
    Category.where(:parent_id =>nil).order("pos asc")
  end
end
