class AddSiteCatIdToProductPriceDetails < ActiveRecord::Migration
  def change
    add_column :product_price_details, :site_cat_id, :integer
  end
end
