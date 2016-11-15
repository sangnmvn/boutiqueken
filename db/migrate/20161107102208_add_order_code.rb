class AddOrderCode < ActiveRecord::Migration
  def change
    add_column :orders,:code,:string,default: ""
  end
end
