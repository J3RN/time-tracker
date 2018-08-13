class AddArchivedToTasks < ActiveRecord::Migration[4.2]
  def change
    add_column :tasks, :archived, :boolean
  end
end
