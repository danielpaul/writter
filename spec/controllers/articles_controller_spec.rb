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
    let(:article) { create(:article) }
    
    before(:each) do
      get :show, params: { id: article }
    end

    it "assigns the requested article to @article" do
      expect(assigns(:article)).to eq(article)
    end

    it "renders show with success" do
      expect(response).to render_template("show")
    end
  end

  describe "GET#new" do
    context "logged out user" do
      it "redirects to sign in" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "logged in user" do
      it "creates a new article" do
        user = create(:user)
        sign_in user
        get :new
        expect(assigns(:article)).to be_a_new(Article)
      end

      it "renders new with success" do
        user = create(:user)
        sign_in user
        get :new
        expect(response).to render_template("new")
      end
    end
  end

  describe "POST#create" do
    context "logged out user" do
      it "redirects to user sign in" do
        post :create, params: { article: attributes_for(:article) }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "logged in user" do
      context "with valid attributes" do
        it "creates a new article" do
          user = create(:user)
          sign_in user

          expect{
            post :create, params: { article: attributes_for(:article) }
          }.to change(Article, :count).by(1)
        end
      end
      context "with invalid attrubutes" do
        it "does not create an article" do
          user = create(:user)
          sign_in user

          #debugger

          expect{
            post :create, params: { article: attributes_for(:article, title: nil, text: nil) }
          }.to change(Article, :count).by(0)

        end
      end
    end
  end

  describe "GET#edit" do
    context "logged out user" do
      it "redirects to user sign in" do
        article = create(:article)
        get :edit, params: { id: article }

        expect(response).to redirect_to new_user_session_path
      end
    end

    context "logged in user" do
      context "not author" do
        it "does not allow edit" do
          user = create(:user)
          sign_in user

          article = create(:article)
          get :edit, params: { id: article }

            expect(response).to redirect_to root_path
        end
      end
      context "is author" do
        it "allows edit" do
          article = create(:article)
          user = article.user
          sign_in user

          get :edit, params: { id: article }

          expect(assigns(:article)).to eq(article)
          expect(response).to render_template("edit")
        end
      end
    end
  end

  describe "POST#update" do
    context "logged out user" do
      it "redirects to user sign in" do
        article = create(:article)
        post :update, params: { id: article }

        expect(response).to redirect_to new_user_session_path
      end
    end

    context "logged in user" do
      context "not author" do
        it "does not allow update" do
          user = create(:user)
          sign_in user

          article = create(:article)
          post :update, params: { id: article }

          expect(response).to redirect_to root_path
        end
      end
      context "is author" do
        it "allows update" do
          article = create(:article)
          user = article.user
          sign_in user

          post :update, params: { id: article, article: attributes_for(:article, title: "test") }
          expect(Article.find(article.id).title).to eq('test')
          expect(response).to redirect_to article_path(article)
        end
      end
    end
  end

  describe "DELETE#destroy" do
    context "logged out user" do
      it "redirects to user sign in" do
        article = create(:article)
        delete :destroy, params: { id: article }

        expect(response).to redirect_to new_user_session_path
      end
    end
    context "logged in user" do
      context "not author" do
        it "does not allow delete" do
          user = create(:user)
          sign_in user

          article = create(:article)
          expect {delete :destroy, params: { id: article }}.to change{ Article.count }.by(0)
          expect(response).to redirect_to root_path
        end
      end

      context "is author" do
        it "deletes the article" do
          article = create(:article)
          user = article.user
          sign_in user

          expect {delete :destroy, params: { id: article }}.to change{ Article.count }.by(-1)
          expect(response).to redirect_to articles_path
        end
      end
    end
  end
end
