class CreateProcessingTasks < ActiveRecord::Migration
  def change
    create_table :processing_tasks do |t|
      t.text :module_name
      t.text :status
      t.datetime :start_at
      t.datetime :end_at
      t.integer :progress
      t.text :log
      t.timestamps null: false
    end
  end
end
