class AddEstimateToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :estimate, :integer
  end
end
