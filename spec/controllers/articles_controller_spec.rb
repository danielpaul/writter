require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET#show" do
    it "assigns the requested article to @article" do
      article = create(:article)
      get :show, params: { id: article }
      expect(assigns(:article)).to eq(article)
    end
  end

  describe "GET#new" do
    context "when initialized" do
      let(:article) { Article.new }

      it "is a new article" do
        user = create(:user)
        sign_in user
        expect(article).to be_a_new(Article)
      end
    end
  end

  describe "POST#create" do
    context "with valid attributes" do
      it "creates a new article" do
        user = create(:user)
        sign_in user

        expect{
          post :create, params: { article: attributes_for(:article) }
        }.to change(Article, :count).by(1)
      end
    end

    context "logged out user" do
      it "creates a new shop" do
        post :create, params: { article: attributes_for(:article) }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "DELETE#destroy" do
      before :each do
        user = create(:user)
        sign_in user
        @article = create(:article, :user => user)
      end

      it "deletes the article" do
        expect {
          delete :destroy, params: {id: @article}
        }.to change{ Article.count }.by(-1)
        expect(response).to redirect_to articles_url
        expect(response).to have_http_status(302)
      end
    end

end
