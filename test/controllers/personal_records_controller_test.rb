require 'test_helper'

class PersonalRecordsControllerTest < ActionController::TestCase
  setup do
    @personal_record = personal_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:personal_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create personal_record" do
    assert_difference('PersonalRecord.count') do
      post :create, personal_record: { event_type: @personal_record.event_type, int: @personal_record.int, int: @personal_record.int, int: @personal_record.int, person_id: @personal_record.person_id, string: @personal_record.string }
    end

    assert_redirected_to personal_record_path(assigns(:personal_record))
  end

  test "should show personal_record" do
    get :show, id: @personal_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @personal_record
    assert_response :success
  end

  test "should update personal_record" do
    patch :update, id: @personal_record, personal_record: { event_type: @personal_record.event_type, int: @personal_record.int, int: @personal_record.int, int: @personal_record.int, person_id: @personal_record.person_id, string: @personal_record.string }
    assert_redirected_to personal_record_path(assigns(:personal_record))
  end

  test "should destroy personal_record" do
    assert_difference('PersonalRecord.count', -1) do
      delete :destroy, id: @personal_record
    end

    assert_redirected_to personal_records_path
  end
end
