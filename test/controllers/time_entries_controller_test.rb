require "test_helper"

class TimeEntriesControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    sign_in @user

    @time_entry = time_entries(:one)
    @tag = tags(:one)

    user2 = users(:two)
    @tag2 = tags(:two)
    @tag2.update!(user: user2)

    @params = {
      duration: 30,
      note: "note",
      start_time: Time.new(2016, 8, 28, 10, 30).american_date,
      task_id: tasks(:uncompleted_full).id,
      user_id: users(:one).id
    }

    @bad_params = @params.dup.tap { |p| p[:task_id] = nil }

    @update_params = { id: @time_entry.id, time_entry: {} }
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create time_entry" do
    assert_difference("TimeEntry.count") do
      post :create, params: { time_entry: @params }
    end

    start_date = Time.american_date(@params[:start_time]).to_date
    assert_redirected_to time_entries_path(date: start_date)
  end

  test "renders new on failed time_entry create" do
    assert_no_difference("TimeEntry.count") do
      post :create, params: { time_entry: @bad_params }
    end

    assert_response :success
  end

  test "redirects to past entries after creating an past entry" do
    yesterday = Time.current - 1.day
    @params[:start_time] = yesterday.american_date
    post :create, params: { time_entry: @params }
    assert_redirected_to time_entries_path(date: yesterday.to_date)
  end

  test "should get edit" do
    get :edit, params: { id: @time_entry }
    assert_response :success
  end

  test "should update time_entry" do
    patch :update, params: { id: @time_entry, time_entry: @params }
    @time_entry.reload
    assert_equal @params[:duration], @time_entry.duration
    assert_equal @params[:start_time], @time_entry.start_time.american_date
  end

  test "renders edit on failed time_entry update" do
    original_note = @time_entry.note
    patch :update, params: { id: @time_entry, time_entry: @bad_params }
    assert_response :success
    @time_entry.reload
    assert_equal original_note, @time_entry.note
  end

  test "redirects to today's entries after updating an entry for today" do
    now = Time.current
    @update_params[:time_entry][:start_time] = now.american_date
    patch :update, params: @update_params
    assert_redirected_to time_entries_path(date: now.to_date)
  end

  test "redirects to past entries after updating a past time entry" do
    @update_params[:time_entry][:start_time] = 2.days.ago.american_date
    patch :update, params: @update_params
    assert_redirected_to time_entries_path(date: 2.days.ago.to_date)
  end

  test "should destroy time_entry" do
    assert_difference("TimeEntry.count", -1) do
      delete :destroy, params: { id: @time_entry }
    end

    assert_redirected_to time_entries_path
  end
end
