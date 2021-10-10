# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable, :omniauthable,
         omniauth_providers: %i[github gitlab google_oauth2]

  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       format: {
                         with: /^[A-Za-z0-9_.\-]+$/,
                         multiline: true
                       }

  attr_writer :login

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.info.nickname
      user.email = auth.info.email
      user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.github_data'])
        user.username = data['info']['nickname'] if user.username.blank?
        user.email = data['info']['email'] if user.email.blank?
      elsif (data = session['devise.gitlab_data'])
        user.username = data['info']['username'] if user.username.blank?
        user.email = data['info']['email'] if user.email.blank?
      elsif (data = session['devise.google_data'])
        user.email = data['info']['email'] if user.email.blank?
      end
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete :login)
      find_from_login_for_database_authentication conditions, login
    elsif conditions.key?(:username) || conditions.key?(:email)
      find_from_keys_for_database_authentication conditions
    end
  end

  def self.find_from_login_for_database_authentication(conditions, login)
    sql = 'lower(username) = :value OR lower(email) = :value'
    args = { value: login.downcase }
    where(conditions).find_by [sql, args]
  end

  def self.find_from_keys_for_database_authentication(conditions)
    conditions[:email]&.downcase!
    conditions[:username]&.downcase!
    find_by conditions
  end

  def login
    @login || username || email
  end

  def password_required?
    super && provider.blank?
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def to_s
    username || email
  end
end
