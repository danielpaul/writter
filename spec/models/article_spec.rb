# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :text }
  it { is_expected.to validate_presence_of :user_id }

  it { should belong_to(:user) }

  describe '#send_email' do
    before(:all) do
      @user = create(:user)
    end

    it 'should send email after creating first article' do
      have_enqueued_jobs 1 do
        create(:article, user: @user)
      end
    end

    it 'should not send email after first article' do
      have_enqueued_jobs 0 do
        create(:article, user: @user)
      end
    end
  end
end
