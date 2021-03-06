class CommentsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user

    authorize @comment

    @comment.save
    redirect_to @commentable, notice: "Your comment was successfully posted"
  end

  def destroy
    set_comment
    authorize @comment

    @comment.destroy
    redirect_to @commentable, notice: 'comment was successfully destroyed.'
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_comment
      @comment = @commentable.comments.find(params[:id])
    end
end
