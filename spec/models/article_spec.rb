# == Schema Information
#
# Table name: articles
#
#  id             :bigint(8)        not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  title          :string           not null
#  text           :string           not null
#  user_id        :bigint(8)
#  hash_id        :string
#  publication_id :bigint(8)
#  privacy        :integer
#

require 'rails_helper'
require "models/concerns/commentable_spec"

RSpec.describe Article, type: :model do

  it_behaves_like "commentable"

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :text }
  it { is_expected.to validate_presence_of :user_id }

  it { should belong_to(:user) }

  describe "#send_email" do
    before(:all) do
      @user = create(:user)
    end

    it "should send email after creating first article" do
      have_enqueued_jobs 1 do
        create(:article, user: @user)
      end
    end

    it "should not send email after first article" do
      have_enqueued_jobs 0 do
        create(:article, user: @user)
      end
    end
  end

end
