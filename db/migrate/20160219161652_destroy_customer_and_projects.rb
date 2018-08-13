class DestroyCustomerAndProjects < ActiveRecord::Migration[4.2]
  def change
    drop_table :customers do
    end

    drop_table :projects do
    end
  end
end
