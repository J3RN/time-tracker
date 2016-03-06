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

    before = Tag.count

    @tag.update(user: @user)
    @user.destroy

    # Assert that one or more tags was destroyed
    assert(before > Tag.count, "No tags destroyed")
  end

  test "does not orphan tasks" do
    @user.save!
    @task.save!

    before = Task.count

    @task.update(user: @user)
    @user.destroy

    # Assert that the task was destroyed
    assert(before > Task.count, "No tasks destroyed")
  end

  test "does not orphan time_entries" do
    @user.save!
    @time_entry.save!

    before = TimeEntry.count

    @time_entry.update!(user: @user)
    @user.destroy

    # Assert that the time_entry was destroyed
    assert(before > TimeEntry.count, "Time Entry not destroyed")
  end
end
