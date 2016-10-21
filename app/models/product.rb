class Product < ActiveRecord::Base
  has_many :product_details,class_name: "ProductPriceDetail"


  def list_sizes
  	JSON.parse(self.sizes)
  	
  end
end