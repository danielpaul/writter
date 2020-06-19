require 'rails_helper'

RSpec.describe Publication, type: :model do

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :user_id }

  it { should belong_to(:user) }
end
