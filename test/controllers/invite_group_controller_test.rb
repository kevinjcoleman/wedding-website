require 'test_helper'

class InviteGroupControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get invite_group_index_url
    assert_response :success
  end

  test "should get show" do
    get invite_group_show_url
    assert_response :success
  end

end
