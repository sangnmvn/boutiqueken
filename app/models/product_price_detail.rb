class ProductPriceDetail < ActiveRecord::Base
  belongs_to :product
  belongs_to :category
  def get_price
  	if self.price.present?
  		self.price
  	else
  		self.product.sale_price
  	end
  end

  def require_size
    return true if product.sizes.present?
    return false
  end


end
