class AddOrderTable < ActiveRecord::Migration
  def up
    create_table :orders do |t|
      t.integer :user_id
      t.integer :billing_address_id
      t.integer :shipping_address_id
      t.string :email
      t.string :phone
      t.integer :status,:default => 0
      t.timestamps
    end

    create_table :order_details do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :product_price_detail_id
      t.string :product_name
      t.string :color
      t.integer :quantity
      t.integer :size
      t.decimal :price,precision: 10, scale: 2
      t.string :currency
      t.timestamps
    end

  end

  def down
    
  end
end
