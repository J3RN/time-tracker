class AddRunningToTimeEntries < ActiveRecord::Migration[4.2]
  def change
    add_column :time_entries, :running, :boolean
  end
end
