class AddUserIdToTasks < ActiveRecord::Migration[4.2]
  def change
    add_column :tasks, :user_id, :integer

    # Set user for each task
    Task.all.each do |task|
      task.update(user_id: task.time_entries.first.try(:user_id) || User.first)
    end
  end
end
