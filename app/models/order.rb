class Order < ActiveRecord::Base
  belongs_to :user
  has_one :billing_address, class_name: "Address", primary_key: "shipping_address_id"
  has_one :shipping_address, class_name: "Address", primary_key: "shipping_address_id"
  accepts_nested_attributes_for :billing_address, :shipping_address
  has_many :order_details
  def parse_items_from_cart(shop_cart)
  	# t.integer :order_id
   #    t.integer :product_id
   #    t.integer :product_price_detail_id
   #    t.string :product_name
   #    t.string :color
   #    t.integer :quantity
   #    t.integer :size
   #    t.decimal :price,precision: 10, scale: 2
   #    t.string :currency
  	shop_cart.shopping_cart_items.each do |i|
  		
  	end
  	
  end
end
