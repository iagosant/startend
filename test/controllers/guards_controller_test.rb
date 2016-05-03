require 'test_helper'

class GuardsControllerTest < ActionController::TestCase
  setup do
    @guard = guards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:guards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create guard" do
    assert_difference('Guard.count') do
      post :create, guard: { first_name: @guard.first_name, last_name: @guard.last_name }
    end

    assert_redirected_to guard_path(assigns(:guard))
  end

  test "should show guard" do
    get :show, id: @guard
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @guard
    assert_response :success
  end

  test "should update guard" do
    patch :update, id: @guard, guard: { first_name: @guard.first_name, last_name: @guard.last_name }
    assert_redirected_to guard_path(assigns(:guard))
  end

  test "should destroy guard" do
    assert_difference('Guard.count', -1) do
      delete :destroy, id: @guard
    end

    assert_redirected_to guards_path
  end
end
