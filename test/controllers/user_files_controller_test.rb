require "test_helper"

class UserFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_file = user_files(:one)
  end

  test "should get index" do
    get user_files_url
    assert_response :success
  end

  test "should get new" do
    get new_user_file_url
    assert_response :success
  end

  test "should create user_file" do
    assert_difference('UserFile.count') do
      post user_files_url, params: { user_file: { user_id: @user_file.user_id, visibility: @user_file.visibility } }
    end

    assert_redirected_to user_file_url(UserFile.last)
  end

  test "should show user_file" do
    get user_file_url(@user_file)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_file_url(@user_file)
    assert_response :success
  end

  test "should update user_file" do
    patch user_file_url(@user_file), params: { user_file: { user_id: @user_file.user_id, visibility: @user_file.visibility } }
    assert_redirected_to user_file_url(@user_file)
  end

  test "should destroy user_file" do
    assert_difference('UserFile.count', -1) do
      delete user_file_url(@user_file)
    end

    assert_redirected_to user_files_url
  end
end
