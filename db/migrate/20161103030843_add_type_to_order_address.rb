class AddTypeToOrderAddress < ActiveRecord::Migration
  def change
  	add_column :order_addresses,:address_type, :string,default: "shipping"
  end
end
