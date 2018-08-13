class AddTaskAndGoalToTimeEntries < ActiveRecord::Migration[4.2]
  def change
    add_column :time_entries, :task, :string
    add_column :time_entries, :goal, :string
  end
end
