class AddUserIdToTags < ActiveRecord::Migration
  def change
    add_column :tags, :user_id, :integer

    # Give each tag a user
    Tag.find_each do |tag|
      tag.update(user_id: tag.time_entries.first.try(:user_id) || User.first)
    end
  end
end
