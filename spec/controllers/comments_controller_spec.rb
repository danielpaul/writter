require 'rails_helper'

RSpec.describe Articles::CommentsController, type: :controller do

  render_views

  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:comment) { create(:comment, commentable: article) }
  let(:comment_attributes) { attributes_for(:comment) }

  def post_create
    post :create, params: { article_id: article.id, comment: comment_attributes }
  end

  def delete_destroy
    delete :destroy, params: { article_id: article.id, id: comment}
  end

  describe "POST #create" do
    context "logged out user" do
      it "does not create an comment" do
        expect {
          post_create
        }.to change(Comment, :count).by(0)
      end
    end

    context "logged in user" do

      before(:each) do
        sign_in user
      end

      context "with valid attributes" do
        it "creates a new comment" do
          expect {
            post_create
          }.to change(Comment, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not create an comment" do
          expect {
            post :create, params: { article_id: article.id, comment: attributes_for(:comment, body: nil) }
          }.to change(Comment, :count).by(0)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    context "logged out user" do
      it "does not delete comment" do
        comment.reload
        expect {
          delete_destroy
        }.to change(Comment, :count).by(0)
      end
      it "redirects to user sign in" do
        expect(delete_destroy).to redirect_to new_user_session_path
      end
    end

    context "logged in user" do
      context "author of article" do
        it "deletes comment" do
          sign_in user
          article.user = user
          comment.commentable = article
          expect {
            delete_destroy
          }.to change(Comment, :count).by(-1)
        end
      end
      context "author of comment" do
        it "deletes comment" do
          new_user = create(:user)
          article.user = new_user
          sign_in user
          comment.user = user
          comment.commentable = article
          expect {
            delete_destroy
          }.to change(Comment, :count).by(-1)
        end
      end
      context "random user" do
        it "doesn not delete comment" do
          comment.reload
          new_user = create(:user)
          sign_in new_user
          expect {
            delete_destroy
          }.to change(Comment, :count).by(0)
        end
      end
    end
  end
end
