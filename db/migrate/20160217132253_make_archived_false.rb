class MakeArchivedFalse < ActiveRecord::Migration[4.2]
  def up
    change_column :tasks, :archived, :boolean, null: false, default: false

    Task.where(archived: nil).update_all(archived: false)
  end

  def down
    change_column :tasks, :archived, :boolean, null: true, default: nil
  end
end
