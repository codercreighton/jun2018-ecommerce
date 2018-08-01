require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get user_list" do
    get admin_user_list_url
    assert_response :success
  end

  test "should get edit_user" do
    get admin_edit_user_url
    assert_response :success
  end

end
