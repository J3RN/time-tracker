class DueDateToDate < ActiveRecord::Migration
  def up
    change_column :tasks, :due_date, :date
  end

  def down
    change_column :tasks, :due_date, :datetime
  end
end
