require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  setup do
    @task = tasks(:one)
    @tag = tags(:one)
    @time_entry = time_entries(:one)
  end

  test "does not orphan taggings" do
    before_taggings = Tagging.count

    @task.save!
    @task.tags << @tag

    # Assert tagging was created
    assert_equal(Tagging.count, before_taggings + 1)

    @task.destroy

    # Assert tagging was destroyed
    assert_equal(Tagging.count, before_taggings)
  end

  test "does not orphan time entries" do
    before_count = TimeEntry.count

    @task.save!

    # Associate this time_entry to the task
    @time_entry.update(task_id: @task.id)

    @task.destroy

    # Assert the time entry was destroyed with the task
    assert_equal(TimeEntry.count, before_count - 1)
  end
end
