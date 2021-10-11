# frozen_string_literal: true

# Generic application helper.
module ApplicationHelper
  def humanize_oauth_provider(provider)
    provider = :google if provider == :google_oauth2
    OmniAuth::Utils.camelize provider
  end
end
