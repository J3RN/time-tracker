require 'test_helper'

class TimeEntriesControllerTest < ActionController::TestCase
  setup do
    @time_entry = time_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:time_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create time_entry" do
    assert_difference('TimeEntry.count') do
      post :create, time_entry: { duration: @time_entry.duration, note: @time_entry.note, project_id: @time_entry.project_id, start_time: @time_entry.start_time, task_id: @time_entry.task_id, user_id: @time_entry.user_id }
    end

    assert_redirected_to time_entry_path(assigns(:time_entry))
  end

  test "should show time_entry" do
    get :show, id: @time_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @time_entry
    assert_response :success
  end

  test "should update time_entry" do
    patch :update, id: @time_entry, time_entry: { duration: @time_entry.duration, note: @time_entry.note, project_id: @time_entry.project_id, start_time: @time_entry.start_time, task_id: @time_entry.task_id, user_id: @time_entry.user_id }
    assert_redirected_to time_entry_path(assigns(:time_entry))
  end

  test "should destroy time_entry" do
    assert_difference('TimeEntry.count', -1) do
      delete :destroy, id: @time_entry
    end

    assert_redirected_to time_entries_path
  end
end
