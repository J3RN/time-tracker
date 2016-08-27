require 'test_helper'

class TimeEntriesControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    sign_in @user

    @time_entry = time_entries(:one)
    @tag = tags(:one)
    @start_time = "08/02/2016 10:32 PM"

    user2 = users(:two)
    @tag2 = tags(:two)
    @tag2.update!(user: user2)
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
      params = {
        duration: @time_entry.duration,
        note: @time_entry.note,
        start_time: @start_time,
        task_id: @time_entry.task_id,
        user_id: @time_entry.user_id
      }
      post :create, time_entry: params
    end

    assert_redirected_to time_entries_path(assigns(:time_entries))
  end

  test "should get edit" do
    get :edit, id: @time_entry
    assert_response :success
  end

  test "should update time_entry" do
    params = {
      duration: @time_entry.duration,
      note: @time_entry.note,
      start_time: @start_time,
      task_id: @time_entry.task_id,
      user_id: @time_entry.user_id
    }
    patch :update, id: @time_entry, time_entry: params
    assert_redirected_to time_entries_path(assigns(:time_entries))
  end

  test "should destroy time_entry" do
    assert_difference('TimeEntry.count', -1) do
      delete :destroy, id: @time_entry
    end

    assert_redirected_to time_entries_path
  end

  test "should get report" do
    get :report, tag_id: @tag.id
    assert_response :success
  end

  test "should not get report on other's tags" do
    get :report, tag_id: @tag2.id

    assert_redirected_to time_entries_path
  end
end
