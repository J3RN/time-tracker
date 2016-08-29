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

    @params = {
      duration: 30,
      note: "note",
      start_time: "08/28/2016 10:30 AM",
      task_id: tasks(:one).id,
      user_id: users(:one).id
    }

    @bad_params = @params.dup.tap { |p| p[:task_id] = nil }
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
      post :create, time_entry: @params
    end

    assert_redirected_to time_entries_path(assigns(:time_entries))
  end

  test "renders new on failed time_entry create" do
    assert_no_difference('TimeEntry.count') do
      post :create, time_entry: @bad_params
    end

    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @time_entry
    assert_response :success
  end

  test "should update time_entry" do
    patch :update, id: @time_entry, time_entry: @params
    assert_redirected_to time_entries_path(assigns(:time_entries))
    @time_entry.reload
    assert_equal @params[:note], @time_entry.note
  end

  test "renders edit on failed time_entry update" do
    original_note = @time_entry.note
    patch :update, id: @time_entry, time_entry: @bad_params
    assert_response :success
    @time_entry.reload
    assert_equal original_note, @time_entry.note
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
