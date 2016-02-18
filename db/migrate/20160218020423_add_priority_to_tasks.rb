class AddPriorityToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :priority, :integer, default: 1, null: false
  end
end
