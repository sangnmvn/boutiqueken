class AddAddressBook < ActiveRecord::Migration
  def up
    create_table :addresses do |t|
      t.integer :user_id
      t.string :first_name
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
  
  end

  def down
    drop_table :addresses
  end
end 
