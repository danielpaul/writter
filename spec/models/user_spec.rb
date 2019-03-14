# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a username, first name, last name, email, and password' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it { is_expected.to validate_presence_of :username }
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_presence_of :email }

  it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it { should have_many(:articles) }
end
