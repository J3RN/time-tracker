require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    sign_in @user

    @task = tasks(:unarchived_full)

    @params = {
      task_name: "Foobar",
      tags: tags(:one),
      priority: 1,
      estimate: 60,
      due_date: "08/05/2016"
    }

    @bad_params = @params.dup.tap { |p| p[:task_name] = nil }
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
      post :create, task: @params
    end

    assert_redirected_to tasks_path(assigns(:tasks))
  end

  test "render 'new' on fail to create" do
    assert_no_difference('Task.count') do
      post :create, task: @bad_params
    end
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @task
    assert_response :success
  end

  test "should update task" do
    patch :update, id: @task, task: @params
    assert_redirected_to tasks_path(assigns(:tasks))
    @task.reload
    assert_equal @params[:priority], @task.priority
  end

  test "render 'edit' on fail to update" do
    patch :update, id: @task, task: @bad_params
    assert_response :success
    @task.reload
    refute_equal @bad_params[:priority], @task.priority
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete :destroy, id: @task
    end

    assert_redirected_to tasks_path
  end

  test "should not see others' tasks" do
    get :index

    assert_equal(@user.tasks.active.count, assigns(:active).count)
    assert_equal(@user.tasks.archived.count, assigns(:archived).count)
  end
end
