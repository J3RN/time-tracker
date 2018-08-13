class DropWickets < ActiveRecord::Migration[4.2]
  def change
    drop_table(:wickets) do
    end
  end
end
