class AddOrderComments < ActiveRecord::Migration
  def up
    create_table :order_comments do |t|
      t.integer :order_id
      t.text :comment
      t.integer :track_status
      t.integer :user_id
      t.date :expected_arrived
      t.timestamps null: false
    end
  end

  def down
    drop_table :order_comments
  end
end
