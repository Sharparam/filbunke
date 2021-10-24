# frozen_string_literal: true

class UserFile < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  enum visibility: {
    secret: 0,
    unlisted: 1,
    visible: 2
  }

  resourcify

  def to_param
    uuid
  end
end
