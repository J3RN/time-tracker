class AddStartDateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :start_date, :date
  end
end
