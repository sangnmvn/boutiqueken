class CreateTmpProductPriceDetail < ActiveRecord::Migration
  def up
    sql =<<-STR
        DROP TABLE IF EXISTS tmp_product_price_details;
        SELECT * INTO tmp_product_price_details FROM product_price_details LIMIT 0; 
    STR
    
    ActiveRecord::Base.connection.execute(sql)
  end

  def down
    drop_table :tmp_product_price_details
  end
end
