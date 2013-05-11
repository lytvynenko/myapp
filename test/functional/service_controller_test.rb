require 'test_helper'

class ServiceControllerTest < ActionController::TestCase
  test "should get cn_load" do
    get :cn_load
    assert_response :success
  end

end
