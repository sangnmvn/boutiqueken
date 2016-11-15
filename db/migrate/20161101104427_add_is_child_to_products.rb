class AddIsChildToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :is_child, :boolean, default: false
  end
end
