class RemoveProjectIdFromTimeEntries < ActiveRecord::Migration
  def change
    remove_column :time_entries, :project_id, :integer
  end
end
