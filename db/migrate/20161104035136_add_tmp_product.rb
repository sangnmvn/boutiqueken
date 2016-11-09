class AddTmpProduct < ActiveRecord::Migration
  def up
    sql =<<-STR
        DROP TABLE IF EXISTS tmp_products;
        SELECT * INTO tmp_products FROM products LIMIT 0; 
    STR
    
    ActiveRecord::Base.connection.execute(sql)
  end

  def down
    drop_table :tmp_products
  end
end
