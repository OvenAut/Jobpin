require 'test_helper'

class PinsControllerTest < ActionController::TestCase
  setup do
    @pin = pins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pin" do
    assert_difference('Pin.count') do
      post :create, :pin => @pin.attributes
    end

    assert_redirected_to pin_path(assigns(:pin))
  end

  test "should show pin" do
    get :show, :id => @pin.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @pin.to_param
    assert_response :success
  end

  test "should update pin" do
    put :update, :id => @pin.to_param, :pin => @pin.attributes
    assert_redirected_to pin_path(assigns(:pin))
  end

  test "should destroy pin" do
    assert_difference('Pin.count', -1) do
      delete :destroy, :id => @pin.to_param
    end

    assert_redirected_to pins_path
  end
end
