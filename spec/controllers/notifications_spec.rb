require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do

  let(:notification) { create(:notification) }
  let(:user) { create(:user) }

  def get_show
    get :show, params: { id: notification }
  end

  def delete_destroy
    delete :destroy, params: { id: notification }
  end


  describe "GET #index" do
    context "signed in user" do
      it "directs to index" do
        sign_in user
        expect(get :index).to render_template("index")
      end
    end
    context "signed out user" do
      it "redirects to sign in" do
        expect(get :index).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET #show" do
    context "signed in user" do
      it "directs to article" do
        sign_in user
        expect(get_show).to redirect_to article_path(notification.second_target)
      end
    end
    context "signed out user" do
      it "redirects to sign in" do
        expect(get_show).to redirect_to new_user_session_path
      end
    end
  end

  describe "delete #destroy" do
    context "signed in user" do
      it "directs to index" do
        sign_in user
        expect{delete_destroy}.to change(Notification, :count).by(1)
      end
    end
    context "signed out user" do
      it "redirects to sign in" do
        expect(delete_destroy).to redirect_to new_user_session_path
      end
    end
  end

  describe "mark as read" do
    3.times {FactoryBot.create(:notification)}
    context "signed in user" do
      it "marks all as read" do
        sign_in user
        expect(mark_as_read).to redirect_to article_path(notification.second_target)
      end
    end
    context "signed out user" do
      it "redirects to sign in" do
        expect(notifications.mark_as_read).to redirect_to new_user_session_path
      end
    end
  end

end
