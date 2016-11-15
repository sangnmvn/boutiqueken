class AddOrderCurrencyInfo < ActiveRecord::Migration
  def change
    add_column :orders,:total_by_currency,:decimal,precision: 10, scale: 2,default: 0
    add_column :orders,:currency_by_user,:string,:default =>"USD"

    add_column :order_details,:price_by_currency,:decimal,precision: 10, scale: 2,default: 0
    add_column :order_details,:currency_by_user,:string,:default =>"USD"
    add_column :order_details,:subtotal_by_currency,:decimal,precision: 10, scale: 2,default: 0
  end
end
