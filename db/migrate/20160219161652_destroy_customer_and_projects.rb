class DestroyCustomerAndProjects < ActiveRecord::Migration
  def change
    drop_table :customers do
    end

    drop_table :projects do
    end
  end
end
