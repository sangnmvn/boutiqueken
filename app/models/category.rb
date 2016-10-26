class Category < ActiveRecord::Base

  has_many :children, class_name: "Category", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Category", foreign_key: "parent_id"
  has_many :left_navs, foreign_key: "parent_id"
  
  has_many :feature_categories
  
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged


  def self.main_menus
    Category.where(:parent_id =>nil).order("pos asc")
  end

  def slug_candidates
    [
      [:id,:cat_name]
    ]
  end

  def should_generate_new_friendly_id?
    # new_record? || slug.blank?
    true
  end
end
