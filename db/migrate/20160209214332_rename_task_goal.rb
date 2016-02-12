class RenameTaskGoal < ActiveRecord::Migration
  def change
    rename_column :time_entries, :task, :goal
  end
end
