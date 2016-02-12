class RenameGoalResult < ActiveRecord::Migration
  def change
    rename_column :time_entries, :goal, :result
  end
end
