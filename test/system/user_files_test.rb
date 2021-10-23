require "application_system_test_case"

class UserFilesTest < ApplicationSystemTestCase
  setup do
    @user_file = user_files(:one)
  end

  test "visiting the index" do
    visit user_files_url
    assert_selector "h1", text: "User Files"
  end

  test "creating a User file" do
    visit user_files_url
    click_on "New User File"

    fill_in "User", with: @user_file.user_id
    fill_in "Visibility", with: @user_file.visibility
    click_on "Create User file"

    assert_text "User file was successfully created"
    click_on "Back"
  end

  test "updating a User file" do
    visit user_files_url
    click_on "Edit", match: :first

    fill_in "User", with: @user_file.user_id
    fill_in "Visibility", with: @user_file.visibility
    click_on "Update User file"

    assert_text "User file was successfully updated"
    click_on "Back"
  end

  test "destroying a User file" do
    visit user_files_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User file was successfully destroyed"
  end
end
