require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  render_views

  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:article_attributes) { attributes_for(:article) }

  def get_show
    get :show, params: { id: article }
  end

  def get_new
    get :new
  end

  def get_edit
    get :edit, params: { id: article }
  end

  def post_create
    post :create, params: { article: article_attributes }
  end

  def put_update
    put :update, params: { id: article, :article => {:name => "New name" } }
  end

  def delete_destroy
    delete :destroy, params: { id: article }
  end

  describe "GET #index" do
    it "directs to index" do
      expect(get :index).to render_template("index")
    end
  end

  describe "GET #show" do

    before(:each) do get_show end

    it "assigns the requested article to @article" do
      expect(assigns(:article)).to eq(article)
    end

    it "renders show with success" do
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    context "logged out user" do
      it "redirects to sign in" do
        expect(get :new).to redirect_to new_user_session_path
      end
    end

    context "logged in user" do

      before(:each) do
        sign_in user
        get_new
      end

      it "creates a new article" do
        expect(assigns(:article)).to be_a_new(Article)
      end

      it "renders new with success" do
        expect(response).to render_template("new")
      end
    end
  end

  describe "POST #create" do
    context "logged out user" do
      it "redirects to user sign in" do
        expect(post :create).to redirect_to new_user_session_path
      end
    end

    context "logged in user" do

      before(:each) do
        sign_in user
      end

      context "with valid attributes" do
        it "creates a new article" do
          expect {
            post_create
          }.to change(Article, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not create an article" do
          expect {
            post :create, params: { article: attributes_for(:article, title: nil, text: nil) }
          }.to change(Article, :count).by(0)
        end
      end
    end
  end

  describe "GET #edit" do
    context "logged out user" do
      it "redirects to user sign in" do
        expect(get_edit).to redirect_to new_user_session_path
      end
    end

    context "logged in user" do
      context "not author" do
        it "does not allow edit" do
          user = create(:user)
          sign_in user

          expect(get_edit).to redirect_to root_path
        end
      end

      context "is author" do
        before(:each) do
          sign_in user
          get_edit
        end

        it "allows edit" do
          expect(assigns(:article)).to eq(article)
        end
        it "renders edit" do
          expect(response).to render_template("edit")
        end
      end
    end
  end

  describe "PUT #update" do
    context "logged out user" do
      it "redirects to user sign in" do
        expect(put_update).to redirect_to new_user_session_path
      end
    end

    context "logged in user" do
      context "not author" do
        it "does not allow update" do
          user = create(:user)
          sign_in user

          expect(put_update).to redirect_to root_path
        end
      end
      context "is author" do
        before(:each) do
          sign_in user
          post :update, params: { id: article, article: attributes_for(:article, title: "test") }
        end

        it "allows update" do
          expect(Article.find(article.id).title).to eq('test')
        end
        it "redirects to article path" do
          expect(response).to redirect_to article_path(article)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    context "logged out user" do
      it "redirects to user sign in" do
        expect(delete_destroy).to redirect_to new_user_session_path
      end
    end

    context "logged in user" do

      before(:each) do
        article.reload
      end

      context "not author" do
        before(:each) do
          user = create(:user)
          sign_in user
        end

        it "does not allow delete" do
          expect {
            delete_destroy
          }.to change(Article, :count).by(0)
        end
        it "redirects to root path" do
          expect(delete_destroy).to redirect_to root_path
        end
      end

      context "is author" do
        before(:each) do
          sign_in user
        end

        it "deletes the article" do
          expect {
            delete_destroy
          }.to change(Article, :count).by(-1)
        end
        it "redirects to articles path" do
          expect(delete_destroy).to redirect_to articles_path
        end
      end
    end
  end
end
