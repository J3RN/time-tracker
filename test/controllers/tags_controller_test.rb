require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    sign_in @user

    @tag = tags(:one)

    @params = {
      name: @tag.name,
      user_id: @tag.user_id
    }

    @bad_params = @params.dup.tap { |p| p[:name] = nil }
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create tag' do
    assert_difference('Tag.count') do
      post :create, params: { tag: @params }
    end

    assert_redirected_to tags_path
  end

  test "render 'new' on fail to create" do
    assert_no_difference('Tag.count') do
      post :create, params: { tag: @bad_params }
    end

    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @tag }
    assert_response :success
  end

  test 'should update tag' do
    patch :update, params: { id: @tag, tag: @params }
    assert_redirected_to tags_path
    @tag.reload
    assert_equal @params[:name], @tag.name
  end

  test "render 'edit' on fail to update" do
    patch :update, params: { id: @tag, tag: @bad_params }
    assert_response :success
    @tag.reload
    refute_equal @bad_params[:name], @tag.name
  end

  test 'should destroy tag' do
    assert_difference('Tag.count', -1) do
      delete :destroy, params: { id: @tag }
    end

    assert_redirected_to tags_path
  end
end
