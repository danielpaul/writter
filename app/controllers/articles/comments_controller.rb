class Articles::CommentsController < CommentsController
  before_action :set_commentable

  private
  def set_commentable
    @commentable = Article.find_by_hash_id!(params[:article_id])
  end
end
