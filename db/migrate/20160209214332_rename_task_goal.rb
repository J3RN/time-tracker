class RenameTaskGoal < ActiveRecord::Migration[4.2]
  def change
    rename_column :time_entries, :task, :goal
  end
end
