class Product < ActiveRecord::Base
  has_many :product_details,class_name: "ProductPriceDetail"



  def list_sizes
  	sizes.to_s.split(",")
  	
  end
end