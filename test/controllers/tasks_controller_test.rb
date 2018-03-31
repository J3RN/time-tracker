require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    sign_in @user

    @task = tasks(:uncompleted_full)

    @params = {
      task_name: 'Foobar',
      tags: tags(:one),
      priority: 1,
      estimate: 60,
      due_date: '08/05/2016'
    }

    @bad_params = @params.dup.tap { |p| p[:task_name] = nil }
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create task' do
    assert_difference('Task.count') do
      post :create, params: { task: @params }
    end

    assert_redirected_to tasks_path
  end

  test "render 'new' on fail to create" do
    assert_no_difference('Task.count') do
      post :create, params: { task: @bad_params }
    end
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @task }
    assert_response :success
  end

  test 'should update task' do
    patch :update, params: { id: @task, task: @params }
    assert_redirected_to tasks_path
    @task.reload
    assert_equal @params[:priority], @task.priority
  end

  test "render 'edit' on fail to update" do
    patch :update, params: { id: @task, task: @bad_params }
    assert_response :success
    @task.reload
    refute_equal @bad_params[:priority], @task.priority
  end

  test 'should destroy task' do
    assert_difference('Task.count', -1) do
      delete :destroy, params: { id: @task }
    end

    assert_redirected_to tasks_path
  end
end
