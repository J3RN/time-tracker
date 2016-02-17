class AddArchivedToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :archived, :boolean
  end
end
