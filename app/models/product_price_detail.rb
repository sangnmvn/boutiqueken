class ProductPriceDetail < ActiveRecord::Base
  belongs_to :product
  belongs_to :category
  
end