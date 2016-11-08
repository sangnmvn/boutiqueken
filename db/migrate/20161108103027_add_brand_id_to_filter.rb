class AddBrandIdToFilter < ActiveRecord::Migration
  def change
    add_column :filters, :brand_id, :integer
  end
end
