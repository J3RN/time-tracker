class MakeArchivedFalse < ActiveRecord::Migration
  def change
    change_column :tasks, :archived, :boolean, null: false, default: false

    Task.where(archived: nil).update_all(archived: false)
  end
end
