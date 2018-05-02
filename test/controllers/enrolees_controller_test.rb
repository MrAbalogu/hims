require 'test_helper'

class EnroleesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @enrolee = enrolees(:one)
  end

  test "should get index" do
    get enrolees_url
    assert_response :success
  end

  test "should get new" do
    get new_enrolee_url
    assert_response :success
  end

  test "should create enrolee" do
    assert_difference('Enrolee.count') do
      post enrolees_url, params: { enrolee: { address: @enrolee.address, card_issued: @enrolee.card_issued, company: @enrolee.company, cover_status: @enrolee.cover_status, dob: @enrolee.dob, email: @enrolee.email, enrolee_number: @enrolee.enrolee_number, expiry_date: @enrolee.expiry_date, firstname: @enrolee.firstname, middlename: @enrolee.middlename, phone: @enrolee.phone, photo: @enrolee.photo, plan: @enrolee.plan, primary_provider: @enrolee.primary_provider, secondary_provider: @enrolee.secondary_provider, sex: @enrolee.sex, state: @enrolee.state, suraname: @enrolee.suraname, tertiary_provider: @enrolee.tertiary_provider } }
    end

    assert_redirected_to enrolee_url(Enrolee.last)
  end

  test "should show enrolee" do
    get enrolee_url(@enrolee)
    assert_response :success
  end

  test "should get edit" do
    get edit_enrolee_url(@enrolee)
    assert_response :success
  end

  test "should update enrolee" do
    patch enrolee_url(@enrolee), params: { enrolee: { address: @enrolee.address, card_issued: @enrolee.card_issued, company: @enrolee.company, cover_status: @enrolee.cover_status, dob: @enrolee.dob, email: @enrolee.email, enrolee_number: @enrolee.enrolee_number, expiry_date: @enrolee.expiry_date, firstname: @enrolee.firstname, middlename: @enrolee.middlename, phone: @enrolee.phone, photo: @enrolee.photo, plan: @enrolee.plan, primary_provider: @enrolee.primary_provider, secondary_provider: @enrolee.secondary_provider, sex: @enrolee.sex, state: @enrolee.state, suraname: @enrolee.suraname, tertiary_provider: @enrolee.tertiary_provider } }
    assert_redirected_to enrolee_url(@enrolee)
  end

  test "should destroy enrolee" do
    assert_difference('Enrolee.count', -1) do
      delete enrolee_url(@enrolee)
    end

    assert_redirected_to enrolees_url
  end
end
