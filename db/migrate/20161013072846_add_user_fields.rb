class AddUserFields < ActiveRecord::Migration
  def up
  	add_column :users,:title,:string
  	add_column :users,:first_name,:string
  	add_column :users,:last_name,:string
  	add_column :users,:middle_name,:string
  	add_column :users,:is_contact_reference,:boolean, default: false
  	add_column :users,:is_skas_member,:boolean,default: false
  end

  def down
  	remove_column :users,:title
  	remove_column :users,:first_name
  	remove_column :users,:last_name
  	remove_column :users,:middle_name
  	remove_column :users,:is_contact_reference
  	remove_column :users,:is_skas_member
  	
  end
end
