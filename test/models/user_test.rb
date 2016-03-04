require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @tag = tags(:one)
    @task = tasks(:one)
    @time_entry = time_entries(:one)
  end

  test "does not orphan tags" do
    @user.save!
    @tag.save!

    @tag.update(user: @user)
    @user.destroy

    # Assert that the tag was destroyed
    assert(@tag.destroyed?, "Tag not destroyed")
  end

  test "does not orphan tasks" do
    @user.save!
    @task.save!

    @task.update(user: @user)
    @user.destroy

    # Assert that the task was destroyed
    assert(@task.destroyed?, "Task not destroyed")
  end

  # test "does not orphan time_entries" do
  #   @user.save!
  #   @time_entry.save!

  #   before_time_entries = time_entry.count

  #   @time_entry.update!(user: @user)

  #   @user.destroy

  #   # Assert that the time_entry was destroyed
  #   assert_equal(time_entry.count, before_time_entries - 1)
  # end
end
