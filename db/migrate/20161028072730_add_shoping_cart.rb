class AddShopingCart < ActiveRecord::Migration
  def up
  	create_table :shopping_carts do |t|

      t.timestamps
    end
    create_table :shopping_cart_items do |t|
      t.shopping_cart_item_fields
      t.timestamps
      t.integer :product_price_detail_id
    end

  end

  def down
  	drop_table :shopping_carts
  	drop_table :shopping_cart_items
  end
end
