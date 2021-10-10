# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

sendgrid_api_key = ENV.fetch('SENDGRID_API_KEY') do
  Rails.application.credentials.dig :sendgrid, :api_key
end

ActionMailer::Base.smtp_settings = {
  user_name: 'apikey',
  password: sendgrid_api_key,
  domain: 'sharparam.com',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}

# Initialize the Rails application.
Rails.application.initialize!
