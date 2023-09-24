require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get api_date" do
    get home_api_date_url
    assert_response :success
  end
end
