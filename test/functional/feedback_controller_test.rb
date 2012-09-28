require 'test_helper'

class FeedbackControllerTest < ActionController::TestCase
  test "should get leave" do
    get :leave
    assert_response :success
  end

end
