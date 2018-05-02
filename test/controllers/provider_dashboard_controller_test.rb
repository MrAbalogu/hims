require 'test_helper'

class ProviderDashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get provider_dashboard_index_url
    assert_response :success
  end

  test "should get claims" do
    get provider_dashboard_claims_url
    assert_response :success
  end

end
