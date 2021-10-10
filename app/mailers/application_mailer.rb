# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'filbunke@sharparam.com'
  layout 'mailer'
end
