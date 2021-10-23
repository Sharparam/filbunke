# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user

    can :read, UserFile, visibility: %i[visible unlisted]

    return if @user.blank?

    add_logged_in_perms

    add_uploader_perms if @user.is_uploader?
    add_admin_perms if @user.is_admin?
  end

  def add_logged_in_perms
    can :manage, UserFile, user: @user
    can :read, UserFile, id: UserFile.with_role(:viewer, @user).pluck(:id)
  end

  def add_uploader_perms
    can :create, UserFile
  end

  def add_admin_perms
    can :manage, :all
  end
end
