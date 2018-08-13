class RenameGoalResult < ActiveRecord::Migration[4.2]
  def change
    rename_column :time_entries, :goal, :result
  end
end
