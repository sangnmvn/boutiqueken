class Order < ActiveRecord::Base
  belongs_to :user
  has_one :billing_address, class_name: "Address", primary_key: "shipping_address_id"
  has_one :shipping_address, class_name: "Address", primary_key: "shipping_address_id"
  accepts_nested_attributes_for :billing_address, :shipping_address
end
