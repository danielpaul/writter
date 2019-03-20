class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @comment = comment
    @user = user
    @commentable = comment.commentable
  end

  def create?
    user.present?
  end

  def destroy?
    user.present? && (user == comment.user || user == @commentable.user)
  end
end
