require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:user) { create(:user) }
  let(:commentable) { create(:article, user: user) }
  let(:comment) { create(:comment, commentable: commentable) }
  let(:comment_attributes) { attributes_for(:comment) }

  def post_create
    post :create, params: { comment: comment_attributes }
  end

  describe "POST #create" do
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
            post :create, params: { comment: attributes_for(:comment, body: nil) }
          }.to change(Comment, :count).by(0)
        end
      end
    end
  end
end
