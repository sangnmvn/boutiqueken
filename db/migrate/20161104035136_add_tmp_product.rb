class AddTmpProduct < ActiveRecord::Migration
  def up
    sql =<<-STR
        CREATE TABLE tmp_products(
          id int default 0
        )
        INHERITS (products);
    STR
    
    ActiveRecord::Base.connection.execute(sql)
  end

  def down
    drop_table :tmp_products
  end
end
