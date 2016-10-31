class AddSizeShoppingCart < ActiveRecord::Migration
  def change
  	add_column :shopping_cart_items, :size, :string
  end
end
