class AddGroupNameToBrand < ActiveRecord::Migration
  def change
  	add_column :brands, :group_name, :text
  end
end
