# frozen_string_literal: true

json.extract! user_file, :id, :file, :user_id, :visibility, :created_at, :updated_at
json.url user_file_url(user_file, format: :json)
json.file url_for(user_file.file)
