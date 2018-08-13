class AddProjectIdToTasks < ActiveRecord::Migration[4.2]
  def change
    add_column :tasks, :project_id, :integer
  end
end
