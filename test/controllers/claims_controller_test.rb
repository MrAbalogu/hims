require 'test_helper'

class ClaimsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @claim = claims(:one)
  end

  test "should get index" do
    get claims_url
    assert_response :success
  end

  test "should get new" do
    get new_claim_url
    assert_response :success
  end

  test "should create claim" do
    assert_difference('Claim.count') do
      post claims_url, params: { claim: { authority_designation: @claim.authority_designation, authority_name: @claim.authority_name, authorization_number: @claim.authorization_number, authorized_amount: @claim.authorized_amount, date: @claim.date, facility_name: @claim.facility_name, insurer_id: @claim.insurer_id, member_number: @claim.member_number, provider_id: @claim.provider_id, rejected_amount: @claim.rejected_amount, status: @claim.status, total_requested_amount: @claim.total_requested_amount } }
    end

    assert_redirected_to claim_url(Claim.last)
  end

  test "should show claim" do
    get claim_url(@claim)
    assert_response :success
  end

  test "should get edit" do
    get edit_claim_url(@claim)
    assert_response :success
  end

  test "should update claim" do
    patch claim_url(@claim), params: { claim: { authority_designation: @claim.authority_designation, authority_name: @claim.authority_name, authorization_number: @claim.authorization_number, authorized_amount: @claim.authorized_amount, date: @claim.date, facility_name: @claim.facility_name, insurer_id: @claim.insurer_id, member_number: @claim.member_number, provider_id: @claim.provider_id, rejected_amount: @claim.rejected_amount, status: @claim.status, total_requested_amount: @claim.total_requested_amount } }
    assert_redirected_to claim_url(@claim)
  end

  test "should destroy claim" do
    assert_difference('Claim.count', -1) do
      delete claim_url(@claim)
    end

    assert_redirected_to claims_url
  end
end
