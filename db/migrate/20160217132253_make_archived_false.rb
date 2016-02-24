class MakeArchivedFalse < ActiveRecord::Migration
  def up
    change_column :tasks, :archived, :boolean, null: false, default: false

    Task.where(archived: nil).update_all(archived: false)
  end

  def down
    change_column :tasks, :archived, :boolean, null: true, default: nil
  end
end
