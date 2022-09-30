require "test_helper"

class ChannelsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get channels_index_url
    assert_response :success
  end

  test "should get new" do
    get channels_new_url
    assert_response :success
  end

  test "should get edit" do
    get channels_edit_url
    assert_response :success
  end

  test "should get show" do
    get channels_show_url
    assert_response :success
  end

  test "should get create" do
    get channels_create_url
    assert_response :success
  end

  test "should get update" do
    get channels_update_url
    assert_response :success
  end

  test "should get delete" do
    get channels_delete_url
    assert_response :success
  end
end
