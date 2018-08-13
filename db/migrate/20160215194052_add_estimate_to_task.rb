class AddEstimateToTask < ActiveRecord::Migration[4.2]
  def change
    add_column :tasks, :estimate, :integer
  end
end
