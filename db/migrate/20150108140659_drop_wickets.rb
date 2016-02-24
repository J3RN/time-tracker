class DropWickets < ActiveRecord::Migration
  def change
    drop_table(:wickets) do
    end
  end
end
