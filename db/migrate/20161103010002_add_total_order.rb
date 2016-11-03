class AddTotalOrder < ActiveRecord::Migration
  def change
    add_column :orders,:total,:decimal,precision: 10, scale: 2,default: 0
    add_column :order_details,:sub_total,:decimal,precision: 10, scale: 2,default: 0
  end
end
