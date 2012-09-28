require 'test_helper'

class StaticControllerTest < ActionController::TestCase
  test "should get eula" do
    get :eula
    assert_response :success
  end

  test "should get privacy" do
    get :privacy
    assert_response :success
  end

  test "should get feedback" do
    get :feedback
    assert_response :success
  end

end
