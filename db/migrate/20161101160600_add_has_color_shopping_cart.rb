class AddHasColorShoppingCart < ActiveRecord::Migration
  def change
    add_column :shopping_cart_items, :has_color, :boolean, default: true
  end
end
