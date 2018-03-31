require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  setup do
    @task = tasks(:uncompleted_full)
    @tag = tags(:one)
    @time_entry = time_entries(:one)
  end

  test 'does not orphan taggings' do
    before_taggings = Tagging.count

    @task.save!
    @task.tags << @tag

    # Assert tagging was created
    assert_equal(Tagging.count, before_taggings + 1)

    @task.destroy

    # Assert tagging was destroyed
    assert_equal(Tagging.count, before_taggings)
  end

  test 'does not orphan time entries' do
    before_count = TimeEntry.count

    @task.save!

    # Associate this time_entry to the task
    @time_entry.update(task_id: @task.id)

    @task.destroy

    # Assert the time entry was destroyed with the task
    assert_equal(TimeEntry.count, before_count - 1)
  end

  test 'time remaining base case' do
    @task.update(due_date: Date.today + 1.days)
    assert_equal(60, @task.time_remaining_today)
  end

  test 'time remaining handles zero days case' do
    @task.update(due_date: Date.today)
    assert_equal(60, @task.time_remaining_today)
  end

  test 'time remaining handles negative days case' do
    @task.update(due_date: Date.today - 1.days)
    assert_equal(60, @task.time_remaining_today)
  end

  test 'time remaining handles timezones at least sort of' do
    initial_time_remaining = @task.time_remaining_today
    @task.time_entries.create!(user: users(:one), duration: 30, start_time: Date.today.to_time + 22.hours)
    assert_equal(initial_time_remaining - 30, @task.time_remaining_today)
  end

  test 'time remaining does not go below zero' do
    @task.time_entries.create!(user: users(:one), duration: 75, start_time: Date.today.to_time)
    assert_equal(0, @task.time_remaining_today)
  end

  test 'due today base case' do
    @task.update!(estimate: 100, due_date: Date.today)
    assert_equal(@task.due_today, 100)
  end

  test 'due today with time entry' do
    @task.update!(estimate: 100, due_date: Date.today)
    @task.time_entries.create!(user: users(:one), duration: 75, start_time: Date.today.to_time)
    assert_equal(@task.due_today, 100)
  end

  test 'due today no due date case' do
    @task.update!(estimate: 100, due_date: nil)
    assert_equal(@task.due_today, 0)
  end

  test 'due today no estimate case' do
    @task.update!(estimate: nil, due_date: Date.today)
    assert_equal(@task.due_today, 0)
  end

  test 'due today not started' do
    @task.update!(start_date: Date.today + 1)
    assert_equal(@task.due_today, 0)
  end
end
