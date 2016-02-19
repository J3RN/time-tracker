class RemoveCustomerAndProjectRelations < ActiveRecord::Migration
  def change
    remove_column :tasks, :project_id
  end
end
