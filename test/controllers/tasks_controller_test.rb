require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    sign_in @user

    @task = tasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post :create, task: { task_name: @task.task_name }
    end

    assert_redirected_to tasks_path(assigns(:tasks))
  end

  test "should get edit" do
    get :edit, id: @task
    assert_response :success
  end

  test "should update task" do
    patch :update, id: @task, task: { task_name: @task.task_name }
    assert_redirected_to tasks_path(assigns(:tasks))
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete :destroy, id: @task
    end

    assert_redirected_to tasks_path
  end
end
