class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :text
    add_column :users, :display_name, :text
  end
end
