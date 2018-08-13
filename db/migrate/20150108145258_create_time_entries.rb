class CreateTimeEntries < ActiveRecord::Migration[4.2]
  def change
    create_table :time_entries do |t|
      t.integer :project_id
      t.integer :user_id
      t.integer :task_id
      t.integer :duration
      t.datetime :start_time
      t.text :note

      t.timestamps null: false
    end
  end
end
