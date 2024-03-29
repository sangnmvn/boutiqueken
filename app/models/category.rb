class Category < ActiveRecord::Base

  has_many :children, class_name: "Category", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Category", foreign_key: "parent_id"
  has_many :left_navs, foreign_key: "parent_id"
  
  has_many :feature_categories
  
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]


  def self.main_menus
    Category.includes(:children).where(:parent_id =>nil).order("pos asc")
  end

  def slug_candidates
  	total_name = cat_name
  	if parent.present?
  		[
      	[parent.cat_name, :cat_name],
        [parent.cat_name, :id, :cat_name]
    	]
  	else
      [
        [:cat_name],
        [:id, :cat_name]
      ]
  	end
  end

  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end

  def to_friend_or_id
    if self.friendly_id? || self.slug.present?
      self.friendly_id
    else
      self.save
      self.friendly_id
    end
  end
end
