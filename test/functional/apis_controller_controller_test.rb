require 'test_helper'

class ApisControllerControllerTest < ActionController::TestCase
  test "should get tracker" do
    get :tracker
    assert_response :success
  end

end
