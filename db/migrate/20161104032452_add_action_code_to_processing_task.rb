class AddActionCodeToProcessingTask < ActiveRecord::Migration
  def change
    add_column :processing_tasks, :action_code, :text, default: "run"
  end
end
