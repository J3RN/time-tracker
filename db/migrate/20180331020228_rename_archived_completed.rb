class RenameArchivedCompleted < ActiveRecord::Migration[5.0]
  def change
    rename_column(:tasks, :archived_at, :completed_at)
  end
end
