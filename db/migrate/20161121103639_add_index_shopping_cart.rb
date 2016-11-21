class AddIndexShoppingCart < ActiveRecord::Migration
  def up
  	add_index :shopping_cart_items, :owner_id
  	add_index :shopping_cart_items, :item_id
  	add_index :categories,:parent_id
  end

  def down
  	remove_index :shopping_cart_items, :owner_id
  	remove_index :shopping_cart_items, :item_id
  end
end
