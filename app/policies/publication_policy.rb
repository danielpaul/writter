class PublicationPolicy < ApplicationPolicy
  attr_reader :user, :publication

  def initialize(user, publication)
    @user = user
    @publication = publication
  end

  def index?
    true
  end

  def create?
    user.present?
  end

  def update?
    user.present? && user == publication.users
  end

  def destroy?
    update?
  end

  def show?
    true
  end
end
