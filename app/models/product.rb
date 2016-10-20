class Product < ActiveRecord::Base
  has_many :product_details



  def list_sizes
  	sizes.to_s.split(",")
  	
  end
end