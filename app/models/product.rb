class Product < ActiveRecord::Base
  has_many :product_details,class_name: "ProductPriceDetail"


  def list_sizes
  	return [] if self.sizes.blank?
  	JSON.parse(self.sizes)
  	
  end
end