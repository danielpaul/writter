require 'rails_helper'

RSpec.describe PublicationsController, type: :controller do

  render_views

  let(:user) { create(:user) }
  let(:publication) { create(:publication, user: user) }
  let(:publication_attributes) { attributes_for(:publication) }

  def get_show
    get :show, params: { id: publication }
  end

  def get_new
    get :new
  end

  def get_edit
    get :edit, params: { id: publication }
  end

  def post_create
    post :create, params: { publication: publication_attributes }
  end

  def put_update
    put :update, params: { id: publication, :publication => {:name => "New name" } }
  end

  def delete_destroy
    delete :destroy, params: { id: publication }
  end

  describe "GET #index" do
    it "directs to index" do
      expect(get :index).to render_template("index")
    end
  end

  describe "GET #show" do

    before(:each) do get_show end

    it "assigns the requested publication to @publication" do
      expect(assigns(:publication)).to eq(publication)
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

      it "creates a new publication" do
        expect(assigns(:publication)).to be_a_new(publication)
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
        it "creates a new publication" do
          expect {
            post_create
          }.to change(publication, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not create an publication" do
          expect {
            post :create, params: { publication: attributes_for(:publication, title: nil, text: nil) }
          }.to change(publication, :count).by(0)
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
          expect(assigns(:publication)).to eq(publication)
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
          post :update, params: { id: publication, publication: attributes_for(:publication, title: "test") }
        end

        it "allows update" do
          expect(publication.find(publication.id).title).to eq('test')
        end
        it "redirects to publication path" do
          expect(response).to redirect_to publication_path(publication)
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
        publication.reload
      end

      context "not author" do
        before(:each) do
          user = create(:user)
          sign_in user
        end

        it "does not allow delete" do
          expect {
            delete_destroy
          }.to change(publication, :count).by(0)
        end
        it "redirects to root path" do
          expect(delete_destroy).to redirect_to root_path
        end
      end

      context "is author" do
        before(:each) do
          sign_in user
        end

        it "deletes the publication" do
          expect {
            delete_destroy
          }.to change(publication, :count).by(-1)
        end
        it "redirects to publications path" do
          expect(delete_destroy).to redirect_to publications_path
        end
      end
    end
  end
end
