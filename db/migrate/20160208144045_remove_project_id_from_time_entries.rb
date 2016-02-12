class RemoveProjectIdFromTimeEntries < ActiveRecord::Migration
  def change
    remove_column :time_entries, :project_id
  end
end
