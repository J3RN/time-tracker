require 'test_helper'

class WicketsControllerTest < ActionController::TestCase
  setup do
    @wicket = wickets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wickets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wicket" do
    assert_difference('Wicket.count') do
      post :create, wicket: { name: @wicket.name, part_number: @wicket.part_number, user_id: @wicket.user_id }
    end

    assert_redirected_to wicket_path(assigns(:wicket))
  end

  test "should show wicket" do
    get :show, id: @wicket
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wicket
    assert_response :success
  end

  test "should update wicket" do
    patch :update, id: @wicket, wicket: { name: @wicket.name, part_number: @wicket.part_number, user_id: @wicket.user_id }
    assert_redirected_to wicket_path(assigns(:wicket))
  end

  test "should destroy wicket" do
    assert_difference('Wicket.count', -1) do
      delete :destroy, id: @wicket
    end

    assert_redirected_to wickets_path
  end
end
