class UpdatePriorityForOldTasks < ActiveRecord::Migration[4.2]
  def change
    Task.where(priority: nil).update_all(priority: 1)
  end
end
