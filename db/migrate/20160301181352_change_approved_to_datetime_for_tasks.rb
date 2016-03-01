class ChangeApprovedToDatetimeForTasks < ActiveRecord::Migration
  def up
    add_column :tasks, :archived_at, :datetime, default: nil

    Task.where(archived: true).each do |task|
      if task.time_entries.last
        task.update(archived_at: task.time_entries.last.started_at)
      else
        task.update(archived_at: task.updated_at)
      end
    end

    remove_column :tasks, :archived, :boolean
  end

  def down
    add_column :tasks, :archived, :boolean

    Task.where.not(archived_at: nil).order(:archived_at).each do |task|
      task.update(archived: true)
    end

    remove_column :tasks, :archived_at, :datetime
  end
end
