require 'test_helper'

class DependantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dependant = dependants(:one)
  end

  test "should get index" do
    get dependants_url
    assert_response :success
  end

  test "should get new" do
    get new_dependant_url
    assert_response :success
  end

  test "should create dependant" do
    assert_difference('Dependant.count') do
      post dependants_url, params: { dependant: { blood_group: @dependant.blood_group, dob: @dependant.dob, enrolee.references: @dependant.enrolee.references, firstname: @dependant.firstname, genotype: @dependant.genotype, middlename: @dependant.middlename, photo: @dependant.photo, primary_hospital: @dependant.primary_hospital, secondary_hospital: @dependant.secondary_hospital, sex: @dependant.sex, surname: @dependant.surname } }
    end

    assert_redirected_to dependant_url(Dependant.last)
  end

  test "should show dependant" do
    get dependant_url(@dependant)
    assert_response :success
  end

  test "should get edit" do
    get edit_dependant_url(@dependant)
    assert_response :success
  end

  test "should update dependant" do
    patch dependant_url(@dependant), params: { dependant: { blood_group: @dependant.blood_group, dob: @dependant.dob, enrolee.references: @dependant.enrolee.references, firstname: @dependant.firstname, genotype: @dependant.genotype, middlename: @dependant.middlename, photo: @dependant.photo, primary_hospital: @dependant.primary_hospital, secondary_hospital: @dependant.secondary_hospital, sex: @dependant.sex, surname: @dependant.surname } }
    assert_redirected_to dependant_url(@dependant)
  end

  test "should destroy dependant" do
    assert_difference('Dependant.count', -1) do
      delete dependant_url(@dependant)
    end

    assert_redirected_to dependants_url
  end
end
