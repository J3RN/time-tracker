class AddRunningToTimeEntries < ActiveRecord::Migration
  def change
    add_column :time_entries, :running, :boolean
  end
end
