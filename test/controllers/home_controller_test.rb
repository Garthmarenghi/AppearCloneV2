require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

  test "should get about" do
    get home_about_url(:locale => 'en')
    assert_response :success
  end

end
