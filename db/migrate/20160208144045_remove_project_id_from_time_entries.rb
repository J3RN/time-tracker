class RemoveProjectIdFromTimeEntries < ActiveRecord::Migration[4.2]
  def change
    remove_column :time_entries, :project_id, :integer
  end
end
