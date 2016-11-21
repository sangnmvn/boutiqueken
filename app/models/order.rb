class Order < ActiveRecord::Base
  belongs_to :user
  has_one :billing_address, class_name: "OrderAddress",dependent: :destroy
  has_one :shipping_address, class_name: "OrderAddress",dependent: :destroy
  accepts_nested_attributes_for :billing_address, :shipping_address
  has_many :order_details,dependent: :destroy
  has_many :order_comments,dependent: :destroy
  include ActionView::Helpers::NumberHelper
  include ApplicationHelper
  before_create :generate_code

  def generate_code
    code = "BEK-" + Random.new.rand((10**(12 - 1))..(10**12)).to_s
    existed = Order.where(:code => code).first
    until !existed.present? do
      code = "BEK-" + Random.new.rand((10**(12 - 1))..(10**12)).to_s
      existed = Order.where(:code => code).first
    end

    self.code = code
  end

  def show_total_price
    [self.currency_by_user,("$" + show_2digit(self.total_by_currency).to_s)].join(" ")
  end

  def parse_items_from_cart(shop_cart,user_currency)
  	# t.integer :order_id
   #    t.integer :product_id
   #    t.integer :product_price_detail_id
   #    t.string :product_name
   #    t.string :color
   #    t.integer :quantity
   #    t.integer :size
   #    t.decimal :price,precision: 10, scale: 2
   #    t.string :currency


  #  id serial NOT NULL,
  # owner_id integer,
  # owner_type character varying,
  # quantity integer,
  # item_id integer,
  # item_type character varying,
  # price_cents integer NOT NULL DEFAULT 0,
  # price_currency character varying NOT NULL DEFAULT 'USD'::character varying,
  # created_at timestamp without time zone,
  # updated_at timestamp without time zone,
  # product_price_detail_id integer,
  # size character varying,
  # has_color boolean DEFAULT true,
  # CONSTRAINT shopping_cart_items_pkey PRIMARY KEY (id)
  	shop_cart.shopping_cart_items.each do |i|
      #product without detail
      detail = OrderDetail.new({order_id: self.id})
      if !i.has_color
        product = Product.find(i.item_id)
        detail.product_id = i.item_id
        detail.price = i.price
        detail.product_name = product.short_desc
        detail.size = i.size
        detail.quantity = i.quantity
        detail.currency = i.price_currency
        detail.product_image = product.main_image_url
        detail.currency_by_user = user_currency
        detail.save
      else
        product_detail = ProductPriceDetail.find(i.item_id)
        product = product_detail.product
        detail.product_id = product_detail.product.id
        detail.product_price_detail_id = product_detail.id
        detail.color = product_detail.color_name
        detail.price = i.price
        detail.quantity = i.quantity
        detail.product_name = product.short_desc
        detail.size = i.size
        detail.currency = i.price_currency
        detail.currency_by_user = user_currency
        url =  product_detail.product_image
        url =  product.main_image_url if url.blank?
        detail.product_image = url
        detail.save
      end
  		
      
  	end
  	
  end


end
