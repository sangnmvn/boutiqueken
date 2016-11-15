class AddOrderAddress < ActiveRecord::Migration
  def up
    create_table :order_addresses do |t|
      t.integer :order_id
      t.integer :user_id
      t.string :title
      t.string :first_name
      t.string :mi_name
      t.string :last_name
      t.string :company_name
      t.string :telephone
      t.string :fax
      t.string :street_address
      t.string :street_address2
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :country
      t.boolean :is_default_billing,default: false
      t.boolean :is_default_shipping,default: false
    end

    #remove_column :addresses,:order_id
  end

  def down
    drop_table :order_addresses
  end
end
