# frozen_string_literal: true

require 'argon2'
require 'devise'
require 'devise-encryptable'

module Devise
  module Encryptable
    module Encryptors
      # Argon2 encryptor for Devise.
      class Argon2 < Base
        def self.digest(password, _stretches, salt, pepper)
          ::Argon2::Password.create("#{password}#{salt}", secret: pepper)
        end

        def self.compare(encrypted_password, password, _stretches, salt, pepper)
          ::Argon2::Password.verify_password("#{password}#{salt}", encrypted_password, pepper)
        end
      end
    end
  end
end
