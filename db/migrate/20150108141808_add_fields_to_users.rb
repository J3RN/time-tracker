class AddFieldsToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :username, :text
    add_column :users, :display_name, :text
  end
end
