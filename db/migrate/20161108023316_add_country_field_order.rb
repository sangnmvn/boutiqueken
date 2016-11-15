class AddCountryFieldOrder < ActiveRecord::Migration
  def change
  	add_column :orders,:country,:string
  end
end
