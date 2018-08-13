class RemoveCustomerAndProjectRelations < ActiveRecord::Migration[4.2]
  def change
    remove_column :tasks, :project_id, :integer
  end
end
