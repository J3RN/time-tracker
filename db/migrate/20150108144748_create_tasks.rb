class CreateTasks < ActiveRecord::Migration[4.2]
  def change
    create_table :tasks do |t|
      t.text :task_name

      t.timestamps null: false
    end
  end
end
