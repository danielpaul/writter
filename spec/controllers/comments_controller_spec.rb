require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  def post_create
    post :create, params: { comment: comment_attributes }
  end

  def delete_destroy
    delete :destroy, params: { id: comment }
  end
