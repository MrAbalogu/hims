require 'test_helper'

class InsurerDashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get insurer_dashboard_index_url
    assert_response :success
  end

end
