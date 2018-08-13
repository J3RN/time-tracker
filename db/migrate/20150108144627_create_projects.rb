class CreateProjects < ActiveRecord::Migration[4.2]
  def change
    create_table :projects do |t|
      t.text :project_name
      t.integer :customer_id

      t.timestamps null: false
    end
  end
end
