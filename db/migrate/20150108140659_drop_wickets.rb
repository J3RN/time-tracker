class DropWickets < ActiveRecord::Migration
  def change
    drop_table(:wickets)
  end
end
