class DestroyCustomerAndProjects < ActiveRecord::Migration
  def change
    drop_table :customers
    drop_table :projects
  end
end
