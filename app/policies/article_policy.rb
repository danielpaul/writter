class ArticlePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present?
  end

  def update?
    user.present? && user == article.user
  end

  def destroy?
    update?
  end

  def show?
    true
  end

  def like?
    create?
  end

end
