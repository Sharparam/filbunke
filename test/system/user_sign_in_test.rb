# frozen_string_literal: true

require 'application_system_test_case'

class UserSignInTest < ApplicationSystemTestCase
  test 'valid credential user logs in' do
    visit user_session_path
    fill_in 'user[login]', with: 'one@example.com'
    fill_in 'user[password]', with: '123456'
    find('input[name="commit"]').click
  end
end
