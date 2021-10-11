class Authentication < ApplicationRecord
  DISPLAY_NAMES = {
    'github' => 'GitHub',
    'gitlab' => 'GitLab',
    'google' => 'Google',
    'google_oauth2' => 'Google'
  }.freeze

  belongs_to :user

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first
  end

  def to_s
    DISPLAY_NAMES[provider] || super
  end
end
