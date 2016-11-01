class ShoppingCartItem < ActiveRecord::Base
  acts_as_shopping_cart_item
  belongs_to :product_price_detail, class_name: "ProductPriceDetail", foreign_key: "item_id"
  belongs_to :product, class_name: "Product", foreign_key: "item_id"
end
