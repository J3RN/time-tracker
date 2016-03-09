require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    sign_in @user

    @task = tasks(:one)
  end

  test "should get index" do
    get :index
    # TODO - Fix?
  end

  # test "should not see others' tasks" do
  '''
    get :dashboard

    assert_equal(@user.tasks.active.count, assigns(:active).count)
    assert_equal(@user.tasks.archived.count, assigns(:archived).count)
  end
  '''
end
