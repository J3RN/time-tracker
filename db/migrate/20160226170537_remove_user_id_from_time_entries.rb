class RemoveUserIdFromTimeEntries < ActiveRecord::Migration
  def change
    remove_column :time_entries, :user_id
  end
end
