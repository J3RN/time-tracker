class UpdatePriorityForOldTasks < ActiveRecord::Migration
  def change
    Task.where(priority: nil).update_all(priority: 1)
  end
end
