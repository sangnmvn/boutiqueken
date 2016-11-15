class AddSizeShoppingCart < ActiveRecord::Migration
  def change
  	add_column :products, :size, :string
  end
end
