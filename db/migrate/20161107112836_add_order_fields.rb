class AddOrderFields < ActiveRecord::Migration
  def change
    add_column :order_details,:product_image,:string
    add_column :orders,:currency,:string,default: "USD"
  end
end
