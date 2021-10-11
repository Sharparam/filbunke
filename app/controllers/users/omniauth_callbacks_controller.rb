# frozen_string_literal: true

# Contains code for User-related stuff.
module Users
  # Contains code for OmniAuth callbacks.
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    DISPLAY_NAMES = {
      github: 'GitHub',
      gitlab: 'GitLab',
      google_oauth2: 'Google'
    }.freeze

    def github
      omniauth :github
    end

    def gitlab
      omniauth :gitlab
    end

    def google_oauth2
      omniauth :google_oauth2
    end

    private

    def omniauth(kind)
      auth = request.env['omniauth.auth']
      authentication = Authentication.from_omniauth auth

      if authentication&.persisted?
        sign_in_user authentication, kind
      elsif current_user
        add_new_oauth auth, kind
      else
        create_new_user auth, kind
      end
    end

    def sign_in_user(authentication, kind)
      @user = authentication.user
      if current_user && current_user.id != @user.id
        redirect_to root_path, alert: 'That login belongs to someone else'
      else
        sign_in_and_redirect @user, event: :authentication
        set_flash_message :notice, :success, kind: DISPLAY_NAMES[kind] if is_navigational_format?
      end
    end

    def add_new_oauth(auth, kind)
      @user = current_user
      @user.apply_omniauth auth
      if @user.save
        redirect_to edit_user_registration_path
        set_flash_message :notice, :success, kind: DISPLAY_NAMES[kind] if is_navigational_format?
      else
        redirect_to edit_user_registration_path, alert: @user.errors.full_messages.join("\n")
      end
    end

    def create_new_user(auth, kind)
      @user = User.new.apply_omniauth auth
      if @user.save
        sign_in_and_redirect @user, event: :authentication
        set_flash_message :notice, :success, kind: DISPLAY_NAMES[kind] if is_navigational_format?
      else
        session['devise.oauth_data'] = {
          username: auth.info.nickname || auth.info.username,
          email: auth.info.email
        }
        redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
      end
    end
  end
end
