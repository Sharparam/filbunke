# frozen_string_literal: true

json.array! @user_files, partial: 'user_files/user_file', as: :user_file
