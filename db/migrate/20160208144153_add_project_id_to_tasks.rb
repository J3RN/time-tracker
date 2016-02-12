class AddProjectIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :project_id, :integer
  end
end
