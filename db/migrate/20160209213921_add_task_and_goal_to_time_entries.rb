class AddTaskAndGoalToTimeEntries < ActiveRecord::Migration
  def change
    add_column :time_entries, :task, :string
    add_column :time_entries, :goal, :string
  end
end
