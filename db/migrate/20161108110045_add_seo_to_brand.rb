class AddSeoToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :seo_title, :text
    add_column :brands, :seo_keywords, :text
    add_column :brands, :seo_desc, :text
  end
end
