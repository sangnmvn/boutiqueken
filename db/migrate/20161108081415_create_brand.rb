class CreateBrand < ActiveRecord::Migration
  def self.up
    create_table :brands do |t|
      t.text :brand_name
      t.integer :category_id
      t.integer :site_cat_id
      t.timestamps null: false
    end
  end
end
